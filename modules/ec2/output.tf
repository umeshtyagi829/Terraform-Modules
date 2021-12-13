output "webserver_ips" {
  value = aws_instance.web_server[*].public_ip
}

output "instance_ids" {
  value = aws_instance.web_server[*].id
}
output "instance_count" {
  value = length(aws_instance.web_server[*].id)
}