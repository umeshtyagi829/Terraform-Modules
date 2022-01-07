<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_alb_listener.alb_listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_listener) | resource |
| [aws_alb_listener_rule.alb_listener_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_listener_rule) | resource |
| [aws_lb.my_alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_target_group.my_tg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_security_group.alb_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_blocks"></a> [cidr\_blocks](#input\_cidr\_blocks) | n/a | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_enable_deletion_protection"></a> [enable\_deletion\_protection](#input\_enable\_deletion\_protection) | n/a | `bool` | `false` | no |
| <a name="input_heath_check_healthy_threshold"></a> [heath\_check\_healthy\_threshold](#input\_heath\_check\_healthy\_threshold) | n/a | `string` | `3` | no |
| <a name="input_heath_check_interval"></a> [heath\_check\_interval](#input\_heath\_check\_interval) | n/a | `string` | `30` | no |
| <a name="input_heath_check_matcher"></a> [heath\_check\_matcher](#input\_heath\_check\_matcher) | n/a | `string` | `"200"` | no |
| <a name="input_heath_check_path"></a> [heath\_check\_path](#input\_heath\_check\_path) | n/a | `string` | `"/"` | no |
| <a name="input_heath_check_port"></a> [heath\_check\_port](#input\_heath\_check\_port) | n/a | `string` | `80` | no |
| <a name="input_heath_check_timeout"></a> [heath\_check\_timeout](#input\_heath\_check\_timeout) | n/a | `string` | `10` | no |
| <a name="input_heath_check_unhealthy_threshold"></a> [heath\_check\_unhealthy\_threshold](#input\_heath\_check\_unhealthy\_threshold) | n/a | `string` | `2` | no |
| <a name="input_ingress_ports"></a> [ingress\_ports](#input\_ingress\_ports) | ingress ports | `list(string)` | <pre>[<br>  80<br>]</pre> | no |
| <a name="input_internal"></a> [internal](#input\_internal) | n/a | `bool` | `false` | no |
| <a name="input_load_balancer_type"></a> [load\_balancer\_type](#input\_load\_balancer\_type) | choose load balancer type | `string` | `"application"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of Application load balancer. | `string` | `""` | no |
| <a name="input_protocol"></a> [protocol](#input\_protocol) | n/a | `string` | `"tcp"` | no |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | ALB SG name. | `string` | `""` | no |
| <a name="input_subnets_ids"></a> [subnets\_ids](#input\_subnets\_ids) | IDs of subnets for ALB. | `list(string)` | n/a | yes |
| <a name="input_tag_prefix"></a> [tag\_prefix](#input\_tag\_prefix) | tag prefix | `string` | `""` | no |
| <a name="input_target_group_name"></a> [target\_group\_name](#input\_target\_group\_name) | target group name. | `string` | `""` | no |
| <a name="input_target_group_port"></a> [target\_group\_port](#input\_target\_group\_port) | n/a | `string` | `80` | no |
| <a name="input_target_group_protocol"></a> [target\_group\_protocol](#input\_target\_group\_protocol) | n/a | `string` | `"HTTP"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC id for TG. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_sg_id"></a> [alb\_sg\_id](#output\_alb\_sg\_id) | application loadbalancer security group id |
| <a name="output_dns_name"></a> [dns\_name](#output\_dns\_name) | Application load balancer dns name. |
| <a name="output_target_group_arn"></a> [target\_group\_arn](#output\_target\_group\_arn) | target group arn |
<!-- END_TF_DOCS -->