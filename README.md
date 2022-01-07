<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 3.68.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.68.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alb"></a> [alb](#module\_alb) | ./modules/alb | n/a |
| <a name="module_ec2"></a> [ec2](#module\_ec2) | ./modules/ec2 | n/a |
| <a name="module_rds"></a> [rds](#module\_rds) | ./modules/rds | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ./modules/vpc | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_ami.amazon_linux](https://registry.terraform.io/providers/hashicorp/aws/3.68.0/docs/data-sources/ami) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_name"></a> [alb\_name](#input\_alb\_name) | application load balancer name | `string` | n/a | yes |
| <a name="input_azs"></a> [azs](#input\_azs) | availability zones for subnets | `list(string)` | n/a | yes |
| <a name="input_cidr_blocks"></a> [cidr\_blocks](#input\_cidr\_blocks) | n/a | `list(string)` | n/a | yes |
| <a name="input_db_instance_class"></a> [db\_instance\_class](#input\_db\_instance\_class) | n/a | `string` | n/a | yes |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | Database name | `string` | n/a | yes |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | Database password | `string` | n/a | yes |
| <a name="input_db_username"></a> [db\_username](#input\_db\_username) | Database username | `string` | n/a | yes |
| <a name="input_desire_size"></a> [desire\_size](#input\_desire\_size) | n/a | `string` | n/a | yes |
| <a name="input_enable_deletion_protection"></a> [enable\_deletion\_protection](#input\_enable\_deletion\_protection) | n/a | `bool` | n/a | yes |
| <a name="input_health_check_grace_period"></a> [health\_check\_grace\_period](#input\_health\_check\_grace\_period) | health\_check\_grace\_period value | `string` | n/a | yes |
| <a name="input_heath_check_healthy_threshold"></a> [heath\_check\_healthy\_threshold](#input\_heath\_check\_healthy\_threshold) | n/a | `string` | n/a | yes |
| <a name="input_heath_check_interval"></a> [heath\_check\_interval](#input\_heath\_check\_interval) | n/a | `string` | n/a | yes |
| <a name="input_heath_check_matcher"></a> [heath\_check\_matcher](#input\_heath\_check\_matcher) | n/a | `string` | n/a | yes |
| <a name="input_heath_check_path"></a> [heath\_check\_path](#input\_heath\_check\_path) | n/a | `string` | n/a | yes |
| <a name="input_heath_check_port"></a> [heath\_check\_port](#input\_heath\_check\_port) | n/a | `string` | n/a | yes |
| <a name="input_heath_check_timeout"></a> [heath\_check\_timeout](#input\_heath\_check\_timeout) | n/a | `string` | n/a | yes |
| <a name="input_heath_check_unhealthy_threshold"></a> [heath\_check\_unhealthy\_threshold](#input\_heath\_check\_unhealthy\_threshold) | n/a | `string` | n/a | yes |
| <a name="input_ingress_ports"></a> [ingress\_ports](#input\_ingress\_ports) | alb security group ingress port | `list(string)` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | instance type | `string` | n/a | yes |
| <a name="input_internal"></a> [internal](#input\_internal) | n/a | `bool` | n/a | yes |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | key name | `string` | n/a | yes |
| <a name="input_launch_config_name"></a> [launch\_config\_name](#input\_launch\_config\_name) | n/a | `string` | n/a | yes |
| <a name="input_load_balancer_type"></a> [load\_balancer\_type](#input\_load\_balancer\_type) | choose load\_balancer\_type | `string` | n/a | yes |
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | n/a | `string` | n/a | yes |
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | n/a | `string` | n/a | yes |
| <a name="input_multi_az"></a> [multi\_az](#input\_multi\_az) | multi\_az | `bool` | n/a | yes |
| <a name="input_private_subnet_cidr"></a> [private\_subnet\_cidr](#input\_private\_subnet\_cidr) | private subnet cidr | `list(any)` | n/a | yes |
| <a name="input_protocol"></a> [protocol](#input\_protocol) | n/a | `string` | n/a | yes |
| <a name="input_public_subnet_cidr"></a> [public\_subnet\_cidr](#input\_public\_subnet\_cidr) | public subnet cidr | `list(any)` | n/a | yes |
| <a name="input_rds_instance_name"></a> [rds\_instance\_name](#input\_rds\_instance\_name) | rds instance name | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | aws credentials | `string` | n/a | yes |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | database security group name | `string` | n/a | yes |
| <a name="input_subnet_group_name"></a> [subnet\_group\_name](#input\_subnet\_group\_name) | database subnet group name | `string` | n/a | yes |
| <a name="input_tag_prefix"></a> [tag\_prefix](#input\_tag\_prefix) | tag prefix | `string` | n/a | yes |
| <a name="input_target_group_name"></a> [target\_group\_name](#input\_target\_group\_name) | application load balancer target group name | `string` | n/a | yes |
| <a name="input_target_group_port"></a> [target\_group\_port](#input\_target\_group\_port) | n/a | `string` | n/a | yes |
| <a name="input_target_group_protocol"></a> [target\_group\_protocol](#input\_target\_group\_protocol) | n/a | `string` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | custom vpc | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_dns"></a> [alb\_dns](#output\_alb\_dns) | alb dns name |
| <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids) | } publict subnet ids |
| <a name="output_rds_endoint"></a> [rds\_endoint](#output\_rds\_endoint) | rds endpoint |
<!-- END_TF_DOCS -->