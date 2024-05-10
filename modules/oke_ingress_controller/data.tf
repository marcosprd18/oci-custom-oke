data "terraform_remote_state" "data_tf_state" {
  backend = "local"
  config = {
    path = "./terraform.tfstate"
  }
}
