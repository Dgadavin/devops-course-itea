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

```bash
terraform init -backend-config=config/${TF_VAR_env}.state.conf
terraform plan -var-file=environment/${TF_VAR_env}.tfvars
terraform apply -var-file=environment/${TF_VAR_env}.tfvars
```
```bash
Note:
To use backet S3, you must install "awscli" by typing "pip install awscli".
Then type "aws configure" and enter "aws access key" and "aws secret access key".
```
