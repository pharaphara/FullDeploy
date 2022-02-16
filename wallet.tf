resource "aws_elastic_beanstalk_application" "walletapp" {
  name        = "walletapp"
}
resource "aws_elastic_beanstalk_environment" "walletapp-env" {
  name                = "walletapp-env"
  application         = aws_elastic_beanstalk_application.walletapp.name
  solution_stack_name = "64bit Amazon Linux 2 v3.2.11 running Corretto 11"

setting {
        namespace = "aws:autoscaling:launchconfiguration"
        name      = "IamInstanceProfile"
        value     = "aws-elasticbeanstalk-ec2-role"
      }
}

