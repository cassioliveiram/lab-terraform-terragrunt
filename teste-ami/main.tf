provider "aws" {
  region = "us-west-2"
}

//data "aws_ami" "ubuntu" {
//  most_recent = true
//
//  filter {
//    name   = "name"
//    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
//  }
//
//  filter {
//    name   = "virtualization-type"
//    values = ["hvm"]
//  }
//
//  owners = ["099720109477"] # Canonical
//}

data "aws_ami" "worker_node" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-1.21-*"]
  }

  most_recent = true
  owners      = ["602401143452"] # Owner ID: AWS
}


output "out-aws-ami" {
  value = data.aws_ami.worker_node.image_id
}
