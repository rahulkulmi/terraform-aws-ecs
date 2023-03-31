resource "aws_route53_record" "np-c-record" {
  zone_id = data.aws_route53_zone.np.zone_id
  name    = var.record_name
  type    = "CNAME"
  ttl     = var.ttl
  records = aws_lb.this.*.dns_name
}
