data "template_file" "task_definition" {
  template = "${file("${path.module}/task-definition.json")}"

  vars {
    image_url        = "${var.image_url}"
    container_name   = "${var.app_container_name}"
    log_group_region = "${var.aws_region}"
    log_group_name   = "${aws_cloudwatch_log_group.app.name}"
  }
}


resource "aws_ecs_task_definition" "app" {
  family                   = "${var.app_name}"
  execution_role_arn       = "${aws_iam_role.ecs_task_execution_role.arn}"
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
  container_definitions    = "${data.template_file.task_definition.rendered}"
}

resource "aws_ecs_service" "main" {
  name            = "cb-service"
  cluster         = "${aws_ecs_cluster.main.id}"
  task_definition = "${aws_ecs_task_definition.app.arn}"
  desired_count   = 1
  launch_type     = "EC2"

  load_balancer {
    target_group_arn = "${aws_alb_target_group.test.id}"
    container_name = "${var.app_container_name}"
    container_port   = 80
  }

  depends_on = ["aws_alb_listener.main"]
}