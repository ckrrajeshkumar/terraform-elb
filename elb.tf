resource "aws_elb" "babaji-elb"{
  security_groups = [aws_security_group.babaji-sg.id]
  subnets = aws_subnet.babaji-pub.*.id
  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
  health_check{
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "http:80/index.html"
    interval = 30
  }
  instances = [aws_instance.babaji-web[1].id, aws_instance.babaji-web[2].id]
  cross_zone_load_balancing = true
  idle_timeout = 100
  connection_draining = true
  connection_draining_timeout = 300
  tags = {
    Name = var.elbname
  }
}