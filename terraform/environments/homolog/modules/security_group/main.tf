resource "aws_security_group" "main" {
  name_prefix = "${var.name_prefix}-"
  vpc_id      = var.vpc_id
  description = var.description

  tags = {
    Name = var.name_prefix
  }
}

resource "aws_security_group_rule" "ingress" {
  count             = length(var.ingress_rules)
  security_group_id = aws_security_group.main.id
  type              = "ingress"
  protocol          = var.ingress_rules[count.index].protocol
  from_port         = var.ingress_rules[count.index].from_port
  to_port           = var.ingress_rules[count.index].to_port
  cidr_blocks       = try(var.ingress_rules[count.index].cidr_blocks, null)
  ipv6_cidr_blocks  = try(var.ingress_rules[count.index].ipv6_cidr_blocks, null)
  prefix_list_ids   = try(var.ingress_rules[count.index].prefix_list_ids, null)
  source_security_group_id = try(var.ingress_rules[count.index].source_security_group_id, null)
}

resource "aws_security_group_rule" "egress" {
  count             = length(var.egress_rules)
  security_group_id = aws_security_group.main.id
  type              = "egress"
  protocol          = var.egress_rules[count.index].protocol
  from_port         = var.egress_rules[count.index].from_port
  to_port           = var.egress_rules[count.index].to_port
  cidr_blocks       = try(var.egress_rules[count.index].cidr_blocks, ["0.0.0.0/0"])
  ipv6_cidr_blocks  = try(var.egress_rules[count.index].ipv6_cidr_blocks, ["::/0"])
  prefix_list_ids   = try(var.egress_rules[count.index].prefix_list_ids, null)
}
