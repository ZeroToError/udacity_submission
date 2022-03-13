# TODO: Designate a cloud provider, region, and credentials
provider "aws" {
  region = "us-east-1"
}


# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2
resource "aws_instance" "Udacity_T2" {
  count = "4"
  ami = "ami-0e1d30f2c40c4c701"
  instance_type = "t2.micro"
  subnet_id = "subnet-035f11b47268d8d80"
  vpc_security_group_ids = ["sg-0aa5a99aab7a9ba65"]
  tags = {
    Name = "Udacity T2"
  }
}  

# TODO: provision 2 m4.large EC2 instances named Udacity M4

resource "aws_instance" "Udacity_M4" {
  count = "2"
  ami = "ami-0e1d30f2c40c4c701"
  instance_type = "m4.large"
  subnet_id = "subnet-01ac4d4f8cc7193d2"
  vpc_security_group_ids = ["sg-0aa5a99aab7a9ba65"]
  tags = {
    Name = "Udacity M4"
  }
}  