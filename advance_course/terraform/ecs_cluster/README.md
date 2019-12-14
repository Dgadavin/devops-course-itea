## Install terraform

Download the terraform package from official site https://www.terraform.io/downloads.html
Unzip and copy terraform into /usr/local/bin
```bash
cp terraform /usr/local/bin
```

## Configure for manual deploy

Before start we need to set ENV variables
```bash
export TF_VAR_env=dev
```
**Please check if in config/\<env\>-state.conf in key you have valid service name.**
**Don't change the bucket or region**

Before start terraform commands please do:

```bash
source ~/aws_creds.txt
```

```bash
terraform init
terraform plan -var-file=environment/${TF_VAR_env}.tfvars
terraform apply -var-file=environment/${TF_VAR_env}.tfvars
```
