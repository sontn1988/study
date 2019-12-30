provider "aws" {
  region = "us-west-1"
}

module "vpc" {
    source = "terraform-aws-modules/vpc/aws"
    
    name = "sontn-vpc"
    cidr = "10.0.0.0/16"

    azs             = ["us-west-1a","us-west-1b","us-west-1c"]
    private_subnets = ["10.0.1.0/24","10.0.2.0/24"]
    public_subnets  = ["10.0.100.0/24","10.0.101.0/24"]

    enable_nat_gateway = true
    enable_vpn_gateway = false

    enable_s3_enpoint  = true

    tags = {
        Owner       = "Sontn"
        Environment = "staging"
        Name        = "sontn-vpc"
    }
}


