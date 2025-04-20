resource "aws_security_group" "main" {
  name_prefix = "${var.name_prefix}-"
  vpc_id      = var.vpc_id
  description = var.description
  tags = {
    Name = "${var.name_prefix}"
  }
}

resource "aws_security_group_rule" "ingress" {
  count             = length(var.rules)
  security_group_id = aws_security_group.main.id
  type              = "ingress"
  protocol          = element(var.rules, count.index).protocol
  from_port         = element(var.rules, count.index).from_port
  to_port           = element(var.rules, count.index).to_port
  cidr_blocks       = lookup(element(var.rules, count.index), "cidr_blocks", null)
  ipv6_cidr_blocks  = lookup(element(var.rules, count.index), "ipv6_cidr_blocks", null)
  prefix_list_ids   = lookup(element(var.rules, count.index), "prefix_list_ids", null)
  source_security_group_id = lookup(element(var.rules, count.index), "source_security_group_id", null)
}

resource "aws_security_group_rule" "egress" {
  count             = length(var.rules)
  security_group_id = aws_security_group.main.id
  type              = "egress"
  protocol          = element(var.rules, count.index).protocol
  from_port         = element(var.rules, count.index).from_port
  to_port           = element(var.rules, count.index).to_port
  cidr_blocks       = lookup(element(var.rules, count.index), "cidr_blocks", ["0.0.0.0/0"]) # Default para permitir todo o tráfego de saída
  ipv6_cidr_blocks  = lookup(element(var.rules, count.index), "ipv6_cidr_blocks", ["::/0"]) # Default para permitir todo o tráfego de saída IPv6
  prefix_list_ids   = lookup(element(var.rules, count.index), "prefix_list_ids", null)
  destination_security_group_id = lookup(element(var.rules, count.index), "destination_security_group_id", null)
}