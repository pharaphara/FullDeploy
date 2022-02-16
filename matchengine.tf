
resource "aws_elastic_beanstalk_application" "matchengine" {
  name        = "matchengine"

 
}
resource "aws_elastic_beanstalk_environment" "matchengine-env" {
  name                = "matchengine-env"
  application         = aws_elastic_beanstalk_application.matchengine.name
  solution_stack_name = "64bit Amazon Linux 2 v3.2.11 running Corretto 11"

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
        name        = "WALLET_URL"
        value       = aws_elastic_beanstalk_environment.walletapp-env.endpoint_url
    }
    
}

output "matchengine_URL" {  
  description = "matchengine URL"  
  value       = aws_elastic_beanstalk_environment.matchengine-env.endpoint_url
  }