module "ecs" {
  source = "./modules/ecs"
  samrdaymond_wa_vpcid = module.vpc.samrdaymond_wa_vpcid
  samrdaymond_wa_alb_sgid = module.alb.samrdaymond_wa_alb_sgid
  samrdaymond_wa_aws_alb_tg_arn = module.alb.samrdaymond_wa_aws_alb_tg_arn
  samrdaymond_wa_public_sub_aid = module.vpc.samrdaymond_wa_public_sub_aid
  samrdaymond_wa_public_sub_bid = module.vpc.samrdaymond_wa_public_sub_bid
}

module "alb" {
  source = "./modules/alb"
  samrdaymond_wa_vpcid = module.vpc.samrdaymond_wa_vpcid
  samrdaymond_wa_public_sub_aid = module.vpc.samrdaymond_wa_public_sub_aid
  samrdaymond_wa_public_sub_bid = module.vpc.samrdaymond_wa_public_sub_bid
}