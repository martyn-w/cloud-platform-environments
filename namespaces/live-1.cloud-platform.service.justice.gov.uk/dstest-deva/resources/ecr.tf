module "dstest_deva_ecr_credentials" {
  source    = "github.com/ministryofjustice/cloud-platform-terraform-ecr-credentials?ref=4.0"
  repo_name = "dstest-deva"
  team_name = "webops"

  providers = {
    aws = aws.london
  }
}

resource "kubernetes_secret" "dstest_deva_ecr_credentials" {
  metadata {
    name      = "ecr-credentials-output"
    namespace = "dstest-deva"
  }

  data = {
    access_key_id     = module.dstest_deva_ecr_credentials.access_key_id
    secret_access_key = module.dstest_deva_ecr_credentials.secret_access_key
    repo_arn          = module.dstest_deva_ecr_credentials.repo_arn
    repo_url          = module.dstest_deva_ecr_credentials.repo_url
  }
}