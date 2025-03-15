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

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
  default     = "10.0.2.0/24"
}

#### ECS Task Definition Variables

variable "ecs_task_family" {
  description = "ECS Task Family Name"
  type        = string
  default     = "api-tasks"
}

variable "ecs_task_cpu" {
  description = "CPU for ECS Task"
  type        = number
  default     = "256"
}

variable "ecs_task_memory" {
  description = "Memory for ECS Task"
  type        = number
  default     = "512"
}

variable "container_images" {
  description = "List of container names and their corresponding image URLs"
  type        = map(string)
  default = {
    "registration-api"  = "your-image-url" # replace with your image URL    
    "search-api"        = "your-image-url" # replace with your image URL
    "notifications-api" = "your-image-url" # replace with your image URL
    "audit-api"         = "your-image-url" # replace with your image URL
    "reporting-api"     = "your-image-url" # replace with your image URL
  }
}

variable "container_ports" {
  description = "List of container ports"
  type        = list(number)
  default     = [8080, 8081, 8082, 8083, 8084]
  
}
### RDS and DynamoDB Variables

variable "db_allocated_storage" {
  description = "The size of the database (GB)."
  type        = number
  default     = 20
}

variable "db_storage_type" {
  description = "The storage type for the database."
  type        = string
  default     = "gp2"
}

variable "db_engine_version" {
  description = "The PostgreSQL engine version."
  type        = string
  default     = "12"
}

variable "db_instance_class" {
  description = "The instance class for the database."
  type        = string
  default     = "db.t3.micro"
}

variable "db_username" {
  description = "Database username."
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Database password."
  type        = string
  sensitive   = true
}

variable "db_parameter_group_name" {
  description = "The DB parameter group name."
  type        = string
  default     = "default.postgres12"
}

variable "db_name" {
  description = "Initial database name"
  type        = string
  default     = "mydatabase"
}

variable "dynamodb_table_name" {
  description = "DynamoDB Table Name"
  type        = string
  default     = "my-dynamodb-table"
}

variable "app_count" {
  description = "Number of tasks to run"
  type        = number
  default     = 1
  
}
