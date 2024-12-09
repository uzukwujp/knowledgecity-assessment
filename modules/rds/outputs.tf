

output "db_instance_endpoint" {
  description = "The connection endpoint"
  value       = aws_db_instance.default.endpoint
}

output "db_instance_name" {
  description = "The database name"
  value       = aws_db_instance.default.db_name
}

output "db_instance_arn" {
  description =  "database instance arn"
  value = aws_db_instance.default.arn
}