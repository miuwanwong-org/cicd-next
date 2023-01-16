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
  owner = "miuwanwong-org"
}

resource "github_repository" "test_repo" {
  name        = "test-repo"
  description = "Test repo from Terraform"
  visibility  = "public"
  auto_init   = true
}

resource "github_branch_protection" "test_protection" {
  repository_id = github_repository.test_repo.name
  pattern       = "main"
  lock_branch   = true

  required_pull_request_reviews {
    dismiss_stale_reviews           = true
    required_approving_review_count = 1
  }
}
