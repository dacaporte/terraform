resource "aws_security_group" "hmsg" {
  vpc_id      = aws_vpc.hmpc.id
  name        = "hmcloud-sg"
  description = "hmcloud-sg"
}

resource "aws_security_group_rule" "sginbound" {
  type              = "ingress"
  from_port         = 0
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.hmsg.id
}

resource "aws_security_group_rule" "sgoutbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.hmsg.id
}
