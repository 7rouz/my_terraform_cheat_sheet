output "address" {
  value = "${aws_instance.py3.public_ip}"
}
