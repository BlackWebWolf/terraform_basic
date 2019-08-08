## ECS

resource "aws_ecs_cluster" "main" {
  name = "${var.app_name}"
}


## ALB

resource "aws_alb_target_group" "test" {
  name     = "${var.app_name}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${module.vpc.vpc_id}"
}

resource "aws_alb" "main" {
  name            = "${var.app_container_name}"
  subnets         = ["${module.vpc.public_subnets}"]
  security_groups = ["${aws_security_group.lb_sg.id}"]
}
resource "aws_alb_listener" "main" {
  load_balancer_arn = "${aws_alb.main.id}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.test.id}"
    type             = "forward"
  }
}


## CloudWatch Logs

resource "aws_cloudwatch_log_group" "ecs" {
  name = "tf-ecs-group/ecs-agent"
}

resource "aws_cloudwatch_log_group" "app" {
  name = "tf-ecs-group/app"
}