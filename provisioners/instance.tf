# Create an aws key pair using the path to a generated ssh key 
resource "aws_key_pair" "mykey" {
  key_name = "mykey"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}

resource "aws_instance" "example" {
  ami = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.mykey.key_name}"

  # copy script to EC2 under /tmp/
  provisioner "file" {
    source = "script.sh"
    destination = "/tmp/script.sh"
  }
  # execute the script that was copied above
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh"
    ]
  }
  # connection paramaeters
  connection {
    user = "${var.INSTANCE_USERNAME}"
    private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
  }
  # execute locally on your machine
  # will save the VM's private ip @ locally in a file.
  provisioner "local-exec" {
     command = "echo ${aws_instance.example.private_ip} >> private_ips.txt"
  }
}
# outputs to the consol the VM's public IP @
output "ip" {
    value = "${aws_instance.example.public_ip}"
}
