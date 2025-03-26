resource "aws_lb" "nlb" {
    name               = "nlb-example"
    internal           = false
    load_balancer_type = "network"
    security_groups    = []
    subnets            = ["subnet-xxxxxxxx", "subnet-yyyyyyyy"]

    enable_deletion_protection = false
}

resource "aws_lb_target_group" "alb_target_group" {
    name        = "alb-target-group"
    port        = 80
    protocol    = "HTTP"
    vpc_id      = "vpc-xxxxxxxx"
    target_type = "alb"
}

resource "aws_lb_listener" "nlb_listener" {
    load_balancer_arn = aws_lb.nlb.arn
    port              = 80
    protocol          = "TCP"

    default_action {
        type               = "forward"
        target_group_arn   = aws_lb_target_group.alb_target_group.arn
    }
}