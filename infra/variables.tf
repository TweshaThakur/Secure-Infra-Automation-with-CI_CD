variable "public_subnet_ids" {
  type = list(string)
  description = "List of public subnet IDs for ALB"
}

variable "alb_security_group_id" {
  type = string
  description = "Security group for ALB"
}
