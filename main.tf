data "aws_ssm_parameter" "vpc_id" {
  name = "samrdaymond/wa/vpc/vpc_id"
}
data "aws_ssm_parameter" "public_sub_a_id" {
  name = "samrdaymond/wa/vpc/public_sub_a_id"
}
data "aws_ssm_parameter" "public_sub_b_id" {
  name = "samrdaymond/wa/vpc/public_sub_b_id"
}

module "ecs" {
  source = "./modules/ecs"
  samrdaymond_wa_vpcid = data.aws_ssm_parameter.vpc_id.value
  samrdaymond_wa_alb_sgid = module.alb.samrdaymond_wa_alb_sgid
  samrdaymond_wa_aws_alb_tg_arn = module.alb.samrdaymond_wa_aws_alb_tg_arn
  samrdaymond_wa_public_sub_aid = data.aws_ssm_parameter.public_sub_a_id.value
  samrdaymond_wa_public_sub_bid = data.aws_ssm_parameter.public_sub_b_id.value
}

module "alb" {
  source = "./modules/alb"
  samrdaymond_wa_vpcid = data.aws_ssm_parameter.vpc_id.value
  samrdaymond_wa_public_sub_aid = data.aws_ssm_parameter.public_sub_a_id.value
  samrdaymond_wa_public_sub_bid = data.aws_ssm_parameter.public_sub_b_id.value
}