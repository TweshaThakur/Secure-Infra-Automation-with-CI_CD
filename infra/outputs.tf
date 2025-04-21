output "ec2_public_ip" {
  value = aws_instance.todo_instance.public_ip
}
