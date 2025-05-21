module "sample-qs" {
  source = "./modules/sample-module"

  path_to_build_spec = "../amplify.yml"

  cognito_groups = {
    Admin = {
      name        = "Admin"
      description = "Admin users"
    }
    Standard = {
      name        = "Standard"
      description = "Standard users"
    }
  }

  cognito_users = {
    NarutoUzumaki = {
      username         = "nuzumaki"
      given_name       = "Naruto"
      family_name      = "Uzumaki"
      email            = "naruto@rasengan.com"
      email_verified   = true
      group_membership = ["Admin", "Standard"]
    }

    SasukeUchiha = {
      username         = "suchiha"
      given_name       = "Sasuke"
      family_name      = "Uchiha"
      email            = "sasuke@chidori.com"
      email_verified   = true
      group_membership = ["Standard"]
    }
  }
}
