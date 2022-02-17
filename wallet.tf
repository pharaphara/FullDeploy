resource "aws_elastic_beanstalk_application" "walletapp" {
  name        = "walletapp"
 
  lifecycle {
    prevent_destroy = false
  }
 
}
resource "aws_elastic_beanstalk_environment" "walletapp-env" {
  name                = "walletapp-env"
  application         = aws_elastic_beanstalk_application.walletapp.name
  solution_stack_name = "64bit Amazon Linux 2 v3.2.11 running Corretto 11"
  
  lifecycle {
    prevent_destroy = false
  }

setting {
        namespace = "aws:autoscaling:launchconfiguration"
        name      = "IamInstanceProfile"
        value     = "aws-elasticbeanstalk-ec2-role"
}
setting  {
        namespace   = "aws:elasticbeanstalk:application:environment"
        name        = "SPRING_PROFILES_ACTIVE"
        value       = "prod"
}
setting  {
        namespace   = "aws:elasticbeanstalk:application:environment"
        name        = "SQL_URL"
        value       = aws_db_instance.default.endpoint
}
setting  {
        namespace   = "aws:elasticbeanstalk:application:environment"
        name        = "SQL_USER"
        value       = aws_db_instance.default.username
}
setting  {
        namespace   = "aws:elasticbeanstalk:application:environment"
        name        = "SQL_PWD"
        value       = aws_db_instance.default.password
}   
  
    
}

output "walletapp_URL" {  
  description = "walletapp URL"  
  value       = aws_elastic_beanstalk_environment.walletapp-env.endpoint_url
  }