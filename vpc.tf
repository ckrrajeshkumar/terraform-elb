resource "aws_vpc" "babaji-vpc"{
  cidr_block = var.vpccidr
  tags={
    Name = var.vpcname
  }
}
resource "aws_subnet" "babaji-pub"{
  count = length(var.subnetcidr)
  vpc_id = aws_vpc.babaji-vpc.id
  cidr_block = element(var.subnetcidr,count.index)
  availability_zone = element(var.az,count.index)
  map_public_ip_on_launch = true
  tags={
        Name = "subnet-${count.index+1}"
   }
}
resource "aws_internet_gateway" "babaji-igw"{
  vpc_id = aws_vpc.babaji-vpc.id
  tags={
    Name = var.igname
  }
}
resource "aws_route_table" "babaji-rtr"{
  vpc_id = aws_vpc.babaji-vpc.id
  route {
    cidr_block = var.igwcidr
    gateway_id = aws_internet_gateway.babaji-igw.id
  }
  tags={
    Name = var.rtrname
  }
}
resource "aws_route_table_association" "babaji-rta"{
  route_table_id = aws_route_table.babaji-rtr.id
  count = length(var.subnetcidr)
  subnet_id = element (aws_subnet.babaji-pub.*.id,count.index)
}