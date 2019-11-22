import datetime
import json
import logging
import os
import socket
import ssl
from urllib2 import Request, urlopen, URLError, HTTPError

import boto3

logger = logging.getLogger()
logger.setLevel(logging.INFO)


def get_route53_domains():
    client = boto3.client('route53')
    hosted_zone_info = client.list_hosted_zones()
    domain_list = []

    for k in hosted_zone_info['HostedZones']:
        hosted_zone_id = k['Id'].split('/')[2]
        r = client.list_resource_record_sets(HostedZoneId=hosted_zone_id)
        for i in r['ResourceRecordSets']:
            if i['Type'] == 'A' or i['Type'] == 'CNAME':
                domain_list.append(i['Name'])

    return domain_list


def ssl_expiry_datetime(hostname):
    ssl_date_fmt = r'%b %d %H:%M:%S %Y %Z'

    context = ssl.create_default_context()
    conn = context.wrap_socket(
        socket.socket(socket.AF_INET),
        server_hostname=hostname,
    )
    conn.settimeout(2)
    try:
        conn.connect((hostname, 443))
        ssl_info = conn.getpeercert()
        return datetime.datetime.strptime(ssl_info['notAfter'], ssl_date_fmt)
    except socket.error as sockerror:
        pass
    except ssl.CertificateError as e:
        pass


def ssl_valid_time_remaining(hostname):
    """Get the number of days left in a cert's lifetime."""
    expires = ssl_expiry_datetime(hostname)
    if not expires:
        return False
    else:
        logger.info('SSL cert for %s expires at %s', hostname, expires.isoformat())
        return expires - datetime.datetime.utcnow()


def ssl_expires_in(hostname, buffer_days=14):
    """Check if `hostname` SSL cert expires is within `buffer_days`.

    Raises `AlreadyExpired` if the cert is past due
    """
    remaining = ssl_valid_time_remaining(hostname)
    if remaining:
        if remaining < datetime.timedelta(days=0):
            send_slack_notification(hostname, remaining.days)
        elif remaining < datetime.timedelta(days=buffer_days):
            send_slack_notification(hostname, remaining.days)
        else:
            return False
    else:
        pass


def send_slack_notification(hostname, remaining):
    slack_channel = os.environ['slackChannel']
    hook_url = os.environ['HookUrl']
    slack_message = {
        'channel': slack_channel,
        'text': 'SSL certificate for %s will expire in %s days!' % (hostname, remaining)
    }

    req = Request(hook_url, json.dumps(slack_message))
    try:
        response = urlopen(req)
        response.read()
        logger.info("Message posted to %s", slack_message['channel'])
    except HTTPError as e:
        logger.error("Request failed: %d %s", e.code, e.reason)
    except URLError as e:
        logger.error("Server connection failed: %s", e.reason)


def lambda_handler(event, context):
    domain_list = get_route53_domains()

    for i in domain_list:
        domain_without_dot = i[:-1]
        ssl_expires_in(domain_without_dot, 30)
