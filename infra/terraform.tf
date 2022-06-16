terraform {
    backend "s3" {
        endpoint = "http://192.168.1.6:9000"
        bucket = "terraform-state"
        key = "homelab.tfstate"
        region = "main"
        skip_requesting_account_id = true
        skip_credentials_validation = true
        skip_get_ec2_platforms = true
        skip_metadata_api_check = true
        skip_region_validation = true
        force_path_style = true
    }
}