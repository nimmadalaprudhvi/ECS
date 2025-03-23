variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

### ECS Cluster Variables
variable "ecs_cluster_name" {
  description = "ECS Cluster Name"
  type        = string
  default     = "my-cluster"
}

### VPC Variables
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnets" {
  description = "List of private subnet IDs for the ECS service"
  type        = list(string)
  default     = ["subnet-abc123", "subnet-def456"]
}

### ECS Task Definition Variables
variable "ecs_task_family" {
  description = "ECS Task Family Name"
  type        = string
  default     = "api-tasks"
}

variable "ecs_task_cpu" {
  description = "CPU for ECS Task"
  type        = number
  default     = 2048
}

variable "ecs_task_memory" {
  description = "Memory for ECS Task"
  type        = number
  default     = 6144
}

variable "container_images" {
  description = "List of container names and their corresponding image URLs"
  type        = map(string)
  default = {
    "registration-api"  = "nginx"
    "search-api"        = "node"
    "notifications-api" = "postgres"
    "audit-api"         = "redis"
    "reporting-api"     = "rabbitmq"
  }
}

variable "container_ports" {
  description = "List of container ports"
  type        = list(number)
  default     = [80, 3000, 5432, 6379, 5672]
}

variable "app_count" {
  description = "Number of tasks to run"
  type        = number
  default     = 1
}