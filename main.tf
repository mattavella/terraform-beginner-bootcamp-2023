terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
  
  cloud {
    organization = "mattavella"
    workspaces {
      name = "terra-house-1"
    }
  }

}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
}

module "home_ribeye_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  bucket_name = var.bucket_name
  public_path = var.ribeye.public_path
  content_version = var.ribeye.content_version
}

resource "terratowns_home" "home" {
  name = "How to cook the perfect ribeye steak"
  description = <<DESCRIPTION
This rib eye steak recipe is tender and juicy beef seared to golden brown perfection, and topped with garlic butter and herbs. A simple steak preparation that tastes like it came from a fancy restaurant!
DESCRIPTION
  domain_name = module.home_ribeye_hosting.domain_name
  town = "missingo"
  content_version = var.ribeye.content_version
}


#module "home_brisket_hosting" {
#  source = "./modules/terrahome_aws"
#  user_uuid = var.teacherseat_user_uuid
#  public_path = var.brisket.public_path
#  content_version = var.brisket.content_version
#
#}
#
#resource "terratowns_home" "home" {
#  name = "How to cook the perfect brisket"
#  description = <<DESCRIPTION
#This brisket recipe is will make the best, tender and juicy briskit you've ever had. 
#DESCRIPTION
#  domain_name = module.home_brisket_hosting.domain_name
#  town = "missingo"
#    content_version = var.brisket.content_version
#}