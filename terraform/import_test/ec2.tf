resource "aws_instance" "example" {
  ami = "ami-0862aabda3fb488b5"
  instance_type = "t2.medium"
}
