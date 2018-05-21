this an exemple of consul cluster using consul module.

first run :
``` $ terraform get ```
to get consul module.

you need to create a ssh key ``` mykey ``` in the local directory. You can do so by using this command ``` ssh-keygen -t rsa -f mykey ``` 

then run ```$ terraform apply ``` to create consul cluster and the needed resources.
