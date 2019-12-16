# Terraform

Download [terraform](https://releases.hashicorp.com/terraform/0.11.14/)

```bash
unzip terraform.zip
cp terraform /usr/local/bin/terraform
chmod u+x /usr/local/bin/terraform
terraform version
```

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

More info how to authenticate in AWS you can find [here](https://www.terraform.io/docs/providers/aws/index.html#authentication)

## ECS cluster creation

```bash
cd advance_course/terraform/ecs-cluster
# Please provide vpc_id and 2 subnet_ids in dev.tfvars file
# Please change @@bucket@@ to your bucket for remote states in config/dev-state.conf
export TF_VAR_env=dev
terraform init -backend-config=config/${TF_VAR_env}-state.conf
terraform plan -var-file=environment/${TF_VAR_env}.tfvars
terraform apply -var-file=environment/${TF_VAR_env}.tfvars
```
