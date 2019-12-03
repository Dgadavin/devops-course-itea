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

## Deploy simple stack

Go to the `advance_course/terraform/ec2-creation`
Please provide you `subnet_id` and `vpc_id` in `variables.tf`.
Please add your public key into `ec2.tf`

```bash
terraform init
terraform plan
terraform apply
```
