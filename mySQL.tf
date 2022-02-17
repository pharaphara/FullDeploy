resource "aws_db_instance" "default" {
  allocated_storage = 20
  engine               = "mysql"
  engine_version       = "8.0.27"
  instance_class       = "db.t2.micro"
  name                 = "db_production"
  username             = "admindelaprod"
  password             = "motdepassedelaprod"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  
  vpc_security_group_ids = [ "${aws_security_group.webserver-sg.id}" ]
}

resource "aws_security_group" "webserver-sg" {
  
  name = "terra-access-ssh-http"
  ingress = [ {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "ssh access"
    from_port = 22
    ipv6_cidr_blocks = [ ]
    prefix_list_ids = [ ]
    protocol = "tcp"
    security_groups = [ ]
    self = false
    to_port = 22
  },
  {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "http access"
    from_port = 80
    ipv6_cidr_blocks = [ ]
    prefix_list_ids = [ ]
    protocol = "tcp"
    security_groups = [ ]
    self = false
    to_port = 80
  },
  {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "MYSQL"
    from_port = 3306
    ipv6_cidr_blocks = [ ]
    prefix_list_ids = [ ]
    protocol = "tcp"
    security_groups = [ ]
    self = false
    to_port = 3306
  }
   ]

  
}


output "prodDB_URL" {  
  
  value       = aws_db_instance.default.endpoint
  }
output "prodDB_USER" {  
  
  value       = aws_db_instance.default.username
  }
  output "prodDB_PWD" {  
  sensitive = true
  value       = aws_db_instance.default.password 
  }

  