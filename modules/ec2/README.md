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
| [aws_autoscaling_group.asg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_launch_configuration.launch_config](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_configuration) | resource |
| [aws_security_group.webserver_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_sg_id"></a> [alb\_sg\_id](#input\_alb\_sg\_id) | n/a | `list(string)` | n/a | yes |
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | AMI id for the instance. | `string` | n/a | yes |
| <a name="input_autoscaling_group_name"></a> [autoscaling\_group\_name](#input\_autoscaling\_group\_name) | Auto Scaling Group Name | `string` | `"aws-asg"` | no |
| <a name="input_desire_size"></a> [desire\_size](#input\_desire\_size) | n/a | `string` | n/a | yes |
| <a name="input_health_check_grace_period"></a> [health\_check\_grace\_period](#input\_health\_check\_grace\_period) | health\_check\_grace\_period value | `string` | `"300"` | no |
| <a name="input_health_check_type"></a> [health\_check\_type](#input\_health\_check\_type) | n/a | `string` | `"EC2"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Intance type to run | `string` | n/a | yes |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | key for the instance to SSH | `string` | n/a | yes |
| <a name="input_launch_config_name"></a> [launch\_config\_name](#input\_launch\_config\_name) | n/a | `string` | `"aws-cf"` | no |
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | n/a | `string` | n/a | yes |
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | n/a | `string` | n/a | yes |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | Name of security group for EC2 istance. | `string` | `"security-group-tf"` | no |
| <a name="input_sg_description"></a> [sg\_description](#input\_sg\_description) | n/a | `string` | `"security group for instance"` | no |
| <a name="input_subnets_ids"></a> [subnets\_ids](#input\_subnets\_ids) | subnet ids in which instances are to be launched. | `list(string)` | n/a | yes |
| <a name="input_tag_prefix"></a> [tag\_prefix](#input\_tag\_prefix) | tag prefix | `string` | `""` | no |
| <a name="input_target_group_arn"></a> [target\_group\_arn](#input\_target\_group\_arn) | target group arn | `list(string)` | n/a | yes |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | user-data for ec2. | `string` | `""` | no |
| <a name="input_volume_size"></a> [volume\_size](#input\_volume\_size) | n/a | `number` | `10` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC id of security group | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_webserver_sg_id"></a> [webserver\_sg\_id](#output\_webserver\_sg\_id) | n/a |
<!-- END_TF_DOCS -->