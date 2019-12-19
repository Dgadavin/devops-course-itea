# Setup logging for docker containers

We will setup:
- elasticsearch cluster
- fluentd ECS service to parse and transfer logs to ES

## AWS authentication

Please use your crenetials.csv file that you download when create IAM user or generate
new one.
Create file `~/aws_creds.txt` with such content:

```bash
export AWS_ACCESS_KEY_ID=""
export AWS_SECRET_ACCESS_KEY=""
```

Before start terraform commands please do:

```bash
source ~/aws_creds.txt
```

## Deploy AWS ES service

```bash
cd elasticsearch
export TF_VAR_env=dev
# Change @@bucket@@ to your bucket
# Change subnet_id and vpc_id to your
terraform init -backend-config=config/${TF_VAR_env}-state.conf
terraform plan -var-file=environment/${TF_VAR_env}.tfvars
terraform apply -var-file=environment/${TF_VAR_env}.tfvars
```

## Build fluentd docker container

```bash
# Create ECR repository for fluentd
cd docker
docker build -t fluent:1.0 .
docker tag fluent:1.0 <YOUR_ECR>
docker push <YOUR_ECR>
```

## Deploy fluend service to ECS cluster

```bash
cd fluent-logging
export TF_VAR_env=dev
# Change @@bucket@@ to your bucket
# In task_definition.tf please provide you image and ES domain name without schema
terraform init -backend-config=config/${TF_VAR_env}-state.conf
terraform plan -var-file=environment/${TF_VAR_env}.tfvars
terraform apply -var-file=environment/${TF_VAR_env}.tfvars
```

## Redeploy ECS service from previous lesson

Please redeploy ECS service and enable sending logs from STDOUT to fluentd

```json
"logConfiguration": {
"logDriver": "fluentd",
  "options": {
    "tag": "nginx.${service_name}.{{.ID}}"
  }
}
```

## ssh tunel to ES

```bash
ssh -L localhost:9090:<ES_ADRESS>:80 ec2-user@<BASTION_IP>
```
