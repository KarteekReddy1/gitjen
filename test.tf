terraform {
  backend "s3" {
    bucket       = "gitjen"
    key          = "terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true


  }
}
resource "aws_s3_bucket_versioning" "state_versioning" {
  bucket = "gitjen"

  versioning_configuration {
    status = "Enabled"
  }
}

provider "aws" {
  region = "us-east-1"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "default" {
  vpc_id            = data.aws_vpc.default.id
  default_for_az    = true
  availability_zone = "us-east-1a"
}
data "aws_security_group" "default" {
  name   = "default"
  vpc_id = data.aws_vpc.default.id

}
resource "aws_instance" "instance2" {
  ami                    = "ami-098e39bafa7e7303d"
  instance_type          = "t3.micro"
  subnet_id              = data.aws_subnet.default.id
  vpc_security_group_ids = [data.aws_security_group.default.id]
  key_name               = "test"


  tags = {
    Name = "MyInstance"
  }
}
