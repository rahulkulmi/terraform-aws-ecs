resource "aws_route53_record" "np-c-record" {
  # provider = aws.dns
  name    = var.record_name
  type    = "CNAME"
  ttl     = var.ttl
  zone_id = var.zone_id
  records = aws_lb.this.*.dns_name
}
