terraform {
  backend "s3" {
    bucket         = "umesh-tf-remote-backend"
    key            = "terraform.tfsate"
    region         = "us-east-2"
    dynamodb_table = "umesh-tf-remote-backend-table"
  }
}