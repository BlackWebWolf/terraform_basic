resource "aws_security_group" "lb_sg" {
  description = "controls access to the application ELB"

  vpc_id = "${module.vpc.vpc_id}"
  name   = "tf-ecs-lbsg"

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
}
#laziest way possible
data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

resource "aws_security_group" "instance_sg" {
  description = "controls direct access to application instances"
  vpc_id      = "${module.vpc.vpc_id}"
  name        = "tf-ecs-instsg"

  ingress {
    protocol  = "tcp"
    from_port = 22
    to_port   = 22
    cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
  }

  ingress {
    protocol  = "tcp"
    from_port = 0
    to_port   = 65535

    security_groups = [
      "${aws_security_group.lb_sg.id}",
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


