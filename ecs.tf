

resource "aws_ecs_cluster" "main" {
  name = var.ecs_cluster_name
}

resource "aws_ecs_task_definition" "api_tasks" {
  family                   = var.ecs_task_family
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  memory                   = var.ecs_task_memory
  cpu                      = var.ecs_task_cpu

  container_definitions = jsonencode([
    for name, image in var.container_images : {
      name        = name
      image       = image
      memory      = var.ecs_task_memory
      cpu         = var.ecs_task_cpu

      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "app-service" {
  name            = "app-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.api_tasks.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs.id]
    subnets          = [aws_subnet.private.id]
    assign_public_ip = false  # Set to true if using public subnets
  }
}