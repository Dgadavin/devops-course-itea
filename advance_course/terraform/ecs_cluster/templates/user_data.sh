#!/bin/bash

mkdir /etc/ecs
cat <<'EOF' >> /etc/ecs/ecs.config
ECS_AVAILABLE_LOGGING_DRIVERS=["syslog", "awslogs", "fluentd", "json-file"]
ECS_CLUSTER=${cluster_name}
EOF
