resource "aws_vpc" "main" {
  cidr_block = "${var.vpc_cidr_range}"
  enable_dns_hostnames = true
  tags {
    Name = "${var.short_name}-vpc"
  }
}
#Create public and private subnets
resource "aws_subnet" "public" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${var.public_subnet_cidr}"

  tags {
    Name = "${var.short_name}-public"
  }
}

resource "aws_subnet" "private" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${var.private_subnet_cidr}"

  tags {
    Name = "${var.short_name}-private"
  }
}
#Create Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"
  tags {
    Name = "${var.short_name}-gw"
  }
}

resource "aws_eip" "nat" {
}

#Create NAT Gateway
resource "aws_nat_gateway" "gw" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id = "${aws_subnet.public.id}"
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.main.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main.id}"
  }
  tags {
    Name = "${var.short_name}-public"
  }
}

resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.main.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.gw.id}"
  }
  tags {
    Name = "${var.short_name}-private"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id = "${aws_subnet.public.id}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "private" {
  subnet_id = "${aws_subnet.private.id}"
  route_table_id = "${aws_route_table.private.id}"
}