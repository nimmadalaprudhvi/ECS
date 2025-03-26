resource "aws_apigatewayv2_api" "http_api" {
  name          = "ecs-http-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_vpc_link" "vpc_link" {
  name        = "ecs-vpc-link"
  security_group_ids = [aws_security_group.alb_sg.id]
  subnet_ids  = data.aws_subnets.public.ids
}

resource "aws_apigatewayv2_integration" "nlb_integration" {
  api_id           = aws_apigatewayv2_api.http_api.id
  integration_type = "HTTP_PROXY"
  integration_uri  = aws_lb.nlb.arn
  connection_type  = "VPC_LINK"
  connection_id    = aws_apigatewayv2_vpc_link.vpc_link.id
}

resource "aws_apigatewayv2_route" "proxy_route" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "ANY /{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.nlb_integration.id}"
}
