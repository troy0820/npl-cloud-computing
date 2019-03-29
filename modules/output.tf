output "user_data" {
  value = "${data.template_file.init.rendered}"
}

output "ssh_ip_address" {
  value = "${aws_instance.npl-instance.*.public_ip}"
}

output "is_complete" {
  value = "${null_resource.is_complete.id}"
}
