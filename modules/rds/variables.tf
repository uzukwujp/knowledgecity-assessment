variable "environment" {
  description = "Environment (production or development)"
  type        = string
  validation {
    condition     = contains(["production", "development"], var.environment)
    error_message = "Environment must be either 'production' or 'development'."
  }
}

variable "db_instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
}

variable "db_username" {
  description = "Username for the master DB user"
  type        = string
}

variable "db_name" {
  type = string
  description = "name of database"  
}

variable "db_password" {
  description = "Password for the master DB user"
  type        = string
  sensitive   = true
}

variable "vpc_id" {
  description = "ID of the VPC where the RDS instance will be created"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of subnet IDs where the RDS instance can be created"
  type        = list(string)
}

variable "engine_version" {
  type = string  
}

variable "engine" {
  type = string
  description = "The database engine example is 'postgres' or 'mysql'"  
}