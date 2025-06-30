resource "aws_instance" "babaji-web"{
  count = length( var.subnetcidr)
  ami = var.amiid
  instance_type = var.intype
  security_groups = [aws_security_group.babaji-sg.id]
  subnet_id = element(aws_subnet.babaji-pub.*.id,count.index)
  user_data = file("install_httpd.sh")
}