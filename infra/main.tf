provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("/home/rose/.ssh/deployer-key.pub")
}

resource "aws_security_group" "todo_sg" {
  name        = "todo-sg"
  description = "Allow SSH and app access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "todo_instance" {
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI in us-east-1
  instance_type = "t2.micro"
  key_name      = aws_key_pair.deployer.key_name
  security_groups = [aws_security_group.todo_sg.name]

  user_data = file("${path.module}/user_data.sh")

  tags = {
    Name = "ToDo-App-EC2"
  }
}
