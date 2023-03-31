output "loadbalancer_security_groups" {
  value = aws_security_group.lb.*.id
}

output "loadbalancer_dns_names" {
  value = aws_lb.this.*.dns_name
}

output "loadbalancer_zone_id" {
  value = aws_lb.this.*.zone_id
}
