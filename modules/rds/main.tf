resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_security_group" "rds" {
  name        = "mysql"
  description = "Allow mysql inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "Mysql from VPC"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.selected.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_mysql"
  }
}

resource "aws_db_instance" "default" {
  identifier           = "mydb-${var.environment}"
  engine               = var.engine
  engine_version       = var.engine_version                    #"16.3"
  instance_class       = var.db_instance_class
  allocated_storage    = var.environment == "production" ? 100 : 20
  storage_type         = var.environment == "production" ? "gp2" : "standard"
  db_name              = var.db_name
  username             = var.db_username
  password             = var.db_password
  skip_final_snapshot  = var.environment == "production" ? false : true

  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name   = aws_db_subnet_group.default.name

  backup_retention_period = var.environment == "production" ? 7 : 1
  multi_az               = var.environment == "production" ? true : false

  tags = {
    Environment = var.environment
  }
}

data "aws_vpc" "selected" {
  id = var.vpc_id
}
