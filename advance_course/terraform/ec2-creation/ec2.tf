# data "terraform_remote_state" "base-stack" {
#   backend = "s3"
#   config = {
#     bucket = "terraform-dp-dev-state"
#     key    = "ec2Creation/terraform.tfstate"
#     region = "eu-west-1"
#   }
# }

resource "aws_key_pair" "deployer" {
  key_name   = "itea-test-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAD9QDB6MRH8kIF4rtXBgqCA4ioO8SiYEjAf5OJGoEgLKeLJhOmhVcW2T/+t2HZWJKQbID6Le28bCHPSOPVk76apIkNfmeYBRhTCEDnheJAtu76oGED3pGddvjClaCkjslTjSFpFcOWH4oAiyWQyRnYS/tIgOgy3cX7XPtjvzlTNyoy7TaBxOv2lZ8HQTWSQkPpM30s+NPOZr//ARBbLaB1aQXTrkmYSRYRBOSLtHjtUcJID0ktK4DjVGV41RwEoUcKXbqnEffT45/6RpfP+fInYZA6pfuwEb5A+Lx6HHsNWjAP6e8mw/7CSyNIJty2VGWgboLW5GLWZCvEo7AxHpKCL1nVSbISxsXg9qPnwMYs42yopwvRDPGdHZQ6jJOtdUYfOMUMNhAPBq1K8tOqfuHQINoZVLvr61lFlvRMHfQe2+lsh4ghPwQOEpp6VzVwthwjhIc9RRFqtNko1WV8+9pzs5TaYZ5x2eApstEV0+8yY3YlB4umt8e7+4gbdQcqhtz7tfMNvMtPD8WgtFYJUUbi8+cYk9moNu+l4DL0bHWvfG7I7D0Aco37heI/GLyhK+1j1XpOmD9q4GQOqu9PgNUXSubdiZENZNb+bkusHDDx63mqAmdFHZjHqiVvtSkAl87gnW/LAa8MtwaLvEsuolmcQ9A9W+/0R2XnRg3ll7gQykLYXX6XUG6P6CDYXsBwn31T6XXZ78WxG8qSIjNT0oGlAOeDuFp1yh4aZY10Ww8Y1Z2Vexmai+WHjXt8VNvS0fo8kKZzDvfzJb0Ot2gQ5RQdZdAuqSpZXAaH3sMVeAG1VBVYhzR+y9QOs6/npqbdTgC0rCa1qoRc1UJK6s+uuVs/xDUPR7j1F320OUbb7a5PEGx5tOc/IM9cGOUBLHgtVzaaYB3efmPcEkbfcNK1vxq/4Ic0V2ilD+mq2o2I7y1Td8dsYAcx6tHRsTHQqr3zbZU05X1OB+ngSTs5nGiwAXm3RPwP+6QS5nbYmIGMjz6T+WHd1r5t7/efRSsLVYxzM+e1tcmAoLFLf/cImRoiTyPQlsucE2eSHSHMCM2opgyyCVBJoyuWxM3YQ1TQ+9iFH7HSy988MwyReNHly6qha8Kb9g3UXbB6RMIZpsj6DxKwHJbqlVzvKnPpkY8u473Nnuezruu9suvLZUjP19cJK5C6otwmQ0Q/ODwM7SDoFO/JyaXtrJ4NoYHvEU9WcWph/kqoS8MuuxGFQyrxIN45Xk/x5UGNsC3qrxwIP7fNSWnX5xHo+gXfxGCHMM8S//kH3T1gm/x4sscEGy6WW3MLGI05AaLVJJln6P4u57Do/xOrv5zsPMhHWaqtN56ROJdimBEoGwhmECgf feriartos@Maksyms-MacBook-Pro.local"
}

resource "aws_instance" "web" {
  ami           = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  iam_instance_profile = "${aws_iam_instance_profile.instance_profile.name}"
  key_name = "${aws_key_pair.deployer.key_name}"
  # vpc_security_group_ids = ["${aws_security_group.instance-sg.id}"]
  subnet_id = "${var.subnet_id}"

  tags = {
    Name = "HelloWorld"
  }
}
