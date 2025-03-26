resource "aws_lb" "nlb" {
    name               = "nlb-example"
    internal           = false
    load_balancer_type = "network"
    security_groups    = []
    subnets            = ["subnet-x", "subnet-y"]

    enable_deletion_protection = false
}

resource "aws_lb" "alb" {
    name               = "private-alb"
    internal           = true  
    load_balancer_type = "application"
    security_groups    = [aws_security_group.alb_sg.id]
    subnets            = ["subnet-a", "subnet-b"]
}

resource "aws_lb_target_group" "alb_target_group" {
    name        = "alb-target-group"
    port        = 80
    protocol    = "TCP"  
    vpc_id      = "vpc-id"
    target_type = "ip"  

    health_check {
        protocol = "TCP"
        port     = "traffic-port"
    }
}

resource "aws_lb_listener" "nlb_listener" {
    load_balancer_arn = aws_lb.nlb.arn
    port              = 80
    protocol          = "TCP"

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.alb_target_group.arn
    }
}
