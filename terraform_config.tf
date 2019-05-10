terraform {
  required_version = "0.11.3"

  backend "s3" {
    # dynamodb_table  = "terraform-state-sydney"
    bucket          = "terraform-state-sydney"
    region          = "ap-southeast-2"
    key             = "terraform-state-files/automation-test/terraform.tfstate"
  }
}