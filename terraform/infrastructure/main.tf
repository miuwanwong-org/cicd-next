terraform {
  backend "s3" {
    bucket = "miu-g-cicd-terraform-state"
    key    = "global/s3/terraform.tfstate"
    region = "ap-southeast-1"

    dynamodb_table = "miu-g-cicd-terraform-locks"
    encrypt        = true
  }

  required_providers {
    github = {
      source  = "integrations/github"
      version = "5.13.0"
    }
  }

}

provider "github" {
  # Configuration options
  token = var.token
}

resource "github_repository" "test_repo" {

  for_each = { for name in var.repository_names : name => name }

  name        = each.value
  description = "Test repo from Terraform"
  visibility  = "public"
}

# resource "github_branch" "main" {
#   repository = github_repository.test_repo.name
#   branch     = "main"
# }

# resource "github_branch_default" "default" {
#   repository = github_repository.test_repo.name
#   branch     = github_branch.main.branch
# }

# resource "github_branch_protection_v3" "test_repo" {
#   repository = github_repository.test_repo.name
#   branch     = "main"

#   required_pull_request_reviews {
#     dismiss_stale_reviews           = true
#     required_approving_review_count = 1
#   }
# }
