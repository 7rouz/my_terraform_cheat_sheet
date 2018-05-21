to configure S3 as a remote backend you need to:

1- create a S3 bucket 

2- configure AWS command line locally:
```
$ aws configure 
AWS Access Key ID [None]: accesskey
AWS Secret Access Key [None]: secretkey
Default region name [None]: us-west-2
Default output format [None]: 
```
3- create a backend.tf file :


```
terraform {
  backend "s3" {
    bucket = "bucket-name"
    key    = "path/to/the/state/file"
  }
}
```

4- run ```terraform init```
