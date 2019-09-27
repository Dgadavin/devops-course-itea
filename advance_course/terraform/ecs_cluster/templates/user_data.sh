#!/bin/bash

/usr/local/bin/pubkeysync org_team_ops org_team_mep

mkdir /etc/ecs
cat <<'EOF' >> /etc/ecs/ecs.config
ECS_AVAILABLE_LOGGING_DRIVERS=["syslog", "awslogs", "fluentd", "json-file"]
ECS_CLUSTER=${cluster_name}
EOF

/sbin/service rsyslog restart

yum install -y docker-17.06.2ce ecs-init
service docker start
start ecs
