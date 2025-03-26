resource "aws_security_group" "example" {
    name        = "example-alb-sg"
    description = "Allow HTTP and HTTPS traffic"
    vpc_id      = aws_vpc.example.id

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        # Allow traffic from the NLB security group
        security_groups = [aws_security_group.nlb.id]
    }

    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        # Allow traffic from the NLB security group
        security_groups = [aws_security_group.nlb.id]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "nlb" {
    name        = "example-nlb-sg"
    description = "Security group for NLB"
    vpc_id      = aws_vpc.example.id

    # Define rules for the NLB as needed
}
