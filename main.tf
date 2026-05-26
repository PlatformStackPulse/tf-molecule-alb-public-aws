module "alb" {
  source = "git::https://github.com/PlatformStackPulse/tf-atom-lb-aws.git?ref=v1.1.0"

  enabled   = module.this.enabled
  namespace = var.namespace
  name      = var.name
  stage     = var.stage
  tags      = var.tags

  internal           = false
  load_balancer_type = "application"
  security_group_ids = var.security_group_ids
  subnet_ids         = var.subnet_ids
}

module "target_group" {
  source = "git::https://github.com/PlatformStackPulse/tf-atom-lb-target-group-aws.git?ref=v1.1.0"

  enabled   = module.this.enabled
  namespace = var.namespace
  name      = "${var.name}-tg"
  stage     = var.stage
  tags      = var.tags

  port                 = var.target_port
  protocol             = "HTTP"
  vpc_id               = var.vpc_id
  target_type          = var.target_type
  health_check_path    = var.health_check_path
  health_check_matcher = var.health_check_matcher
  deregistration_delay = var.deregistration_delay
}

module "https_listener" {
  source = "git::https://github.com/PlatformStackPulse/tf-atom-lb-listener-aws.git?ref=v1.1.0"

  enabled   = module.this.enabled
  namespace = var.namespace
  name      = "${var.name}-https"
  stage     = var.stage
  tags      = var.tags

  load_balancer_arn = module.alb.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = var.certificate_arn
  target_group_arn  = module.target_group.arn
}

module "http_redirect_listener" {
  source = "git::https://github.com/PlatformStackPulse/tf-atom-lb-listener-aws.git?ref=v1.1.0"

  enabled   = module.this.enabled
  namespace = var.namespace
  name      = "${var.name}-http-redirect"
  stage     = var.stage
  tags      = var.tags

  load_balancer_arn    = module.alb.arn
  port                 = 80
  protocol             = "HTTP"
  default_action_type  = "redirect"
  redirect_port        = "443"
  redirect_protocol    = "HTTPS"
  redirect_status_code = "HTTP_301"
}
