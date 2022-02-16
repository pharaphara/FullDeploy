
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
}

