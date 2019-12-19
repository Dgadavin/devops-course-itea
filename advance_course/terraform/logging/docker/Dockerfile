FROM fluent/fluentd:edge-debian

USER root
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
        ruby-dev \
	    gcc \
	    make \
 && buildDeps=" \
      make gcc g++ libc-dev \
      ruby-dev \
      wget bzip2 gnupg dirmngr \
    "
COPY fluent.conf /fluentd/etc/fluentd.conf
RUN fluent-gem install fluent-plugin-grok-parser fluent-plugin-s3 fluent-plugin-aws-elasticsearch-service
CMD fluentd -c /fluentd/etc/fluentd.conf -p /fluentd/plugins $FLUENTD_OPT
