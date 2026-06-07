terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.45.0"
  }
  random = {                           #it use terraform registry provider for create random id
    source  = "hashicorp/random"
    version = "3.5.1"
}
}
}



# define cloud provider and region

provider "aws" {
    region="ap-south-1" 
}



# main work start from here for creating aws s3 bucket and upload file into it.

resource "random_id" "rand_id" {       #it will create random id and return using terraform output.tf 
                                            # then i am using this id in bucket name for unique bucket name
  byte_length = 6
}


resource "aws_s3_bucket" "mybucket" {
  bucket = "mybucketname${random_id.rand_id.hex}" #bucket name should be unique across all aws accounts

}

resource "aws_s3_object" "bucket_data" {
  bucket = aws_s3_bucket.mybucket.bucket  #where s3 bucket to upload into
  source = "./myfile.txt"                #local file which we want to upload to s3 bucket
  key = "mydata.txt"                  #file name inside s3 bucket
  
}