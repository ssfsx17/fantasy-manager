

// https://aws.amazon.com/amazon-linux-ami
resource "aws_launch_template" "ssh_bastion" {
  name_prefix   = "ssh_bastion"
  ebs_optimized = true
  image_id      = var.ami_ids[var.region]
  instance_type = "t3.micro"
  key_name      = "admin_ssh"

  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true
    security_groups             = [aws_security_group.public.id]
  }
}

resource "aws_autoscaling_group" "ssh_bastion" {
  name_prefix         = "ssh_bastion"
  vpc_zone_identifier = aws_subnet.public.*.id

  min_size         = 1
  desired_capacity = 1
  max_size         = 2

  launch_template {
    id      = aws_launch_template.ssh_bastion.id
    version = "$Latest"
  }
}
