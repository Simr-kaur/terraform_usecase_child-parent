provider "aws" {
  region = "ap-northeast-1"
}

module "jhooq-webserver-1" {
  source = "./module1/"
}

module "jhooq-webserver-2" {
  source = "./module2/"
}
