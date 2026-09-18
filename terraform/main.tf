terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  required_version = ">= 1.5.0"
}

provider "aws" {
  region = "eu-north-1"
}

resource "aws_security_group" "app_sg" {
  name        = "aws-cicd-app-sg"
  description = "Security group for CI/CD application"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Flask application"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Jenkins"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "aws-cicd-app-sg"
  }
}

resource "aws_instance" "app_server" {
  ami           = "ami-0dff49db4feb026af"
  instance_type = "m7i-flex.large"
  key_name      = "devops-lab-key"

  vpc_security_group_ids = [
    aws_security_group.app_sg.id
  ]

  user_data = <<-EOF
    #!/bin/bash

    # Update packages
    dnf update -y

    # Install Docker, Git, Java and wget
    dnf install -y docker git java-21-amazon-corretto wget

    # Start Docker
    systemctl start docker
    systemctl enable docker

    # Allow ec2-user to use Docker
    usermod -aG docker ec2-user

    # Add Jenkins repository
    wget -O /etc/yum.repos.d/jenkins.repo \
      https://pkg.jenkins.io/redhat-stable/jenkins.repo

    # Import Jenkins repository key
    rpm --import \
      https://pkg.jenkins.io/redhat-stable/jenkins.io-2026.key

    # Install Jenkins
    dnf install -y jenkins

    # Allow Jenkins to use Docker
    usermod -aG docker jenkins

    # Start Jenkins
    systemctl enable jenkins
    systemctl start jenkins
  EOF

  tags = {
    Name = "AWS-CICD-App-Server"
  }
}

output "server_public_ip" {
  value = aws_instance.app_server.public_ip
}