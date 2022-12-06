provider "aws" {
  region = "ap-south-1"
  profile = "jenkins"    #<---- type your aws profile_name inside double cote
}

resource "aws_db_instance" "default" {
   allocated_storage = 20
   db_name = "mydb"
   engine = "mysql"
   engine_version = "5.7"
   instance_class = "db.t2.micro"
   username = "root" 
   password = "blabla#2022"
   storage_type = "gp2"
   port = 3306
   parameter_group_name = "default.mysql5.7"
   skip_final_snapshot= true
   auto_minor_version_upgrade = true
   publicly_accessible = true   
}

output "db" {
   value = aws_db_instance.new.name
}

output "username" { 
   value = aws_db_instance.new.username
}

output "password" { 
   value = aws_db_instance.new.password
   sensitive = true
}

output "RDS" {
   value = aws_db_instance.new.endpoint
}
