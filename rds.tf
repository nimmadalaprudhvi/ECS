resource "aws_db_instance" "postgres" {
  allocated_storage    = var.db_allocated_storage
  storage_type         = var.db_storage_type
  engine               = "postgres"
  engine_version       = var.db_engine_version
  instance_class       = var.db_instance_class
  publicly_accessible  = false
  db_name              = var.db_name   # Only valid during creation
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = var.db_parameter_group_name
  skip_final_snapshot  = true
}