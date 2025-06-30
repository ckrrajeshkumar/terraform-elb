resource "aws_instance" "babaji-web"{
  count = length( var.subnetcidr)
  ami = var.amiid
  instance_type = var.intype
  security_groups = [aws_security_group.babaji-sg.id]
  subnet_id = element(var.subnetcidr.babaji-pub.*.id)
  user_data = file("install_httpd.sh")
}