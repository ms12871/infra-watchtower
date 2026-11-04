terraform {
  required_version = ">= 1.5.0"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

provider "github" {
  owner = var.github_owner != "" ? var.github_owner : null
  # Reads token from the GITHUB_TOKEN environment variable in GitHub Actions
}

# 1. Enforce branch protection on main
resource "github_branch_protection" "main_protection" {
  repository_id = var.github_repository
  pattern       = var.default_branch

  enforce_admins = false

  required_status_checks {
    strict   = true
    contexts = ["validate-and-deploy"]
  }

  required_pull_request_reviews {
    dismiss_stale_reviews           = true
    require_code_owner_reviews      = false
    required_approving_review_count = 1
  }
}

# 2. Declarative Issue & PR labels
resource "github_issue_label" "labels" {
  for_each = {
    "infra-drift"  = { color = "d93f0b", desc = "Detected discrepancy between code and state" }
    "pipeline-ops" = { color = "0e8a16", desc = "CI/CD maintenance and automation updates" }
    "security-hot" = { color = "b60205", desc = "Automated policy check or syntax violation" }
  }

  repository  = var.github_repository
  name        = each.key
  color       = each.value.color
  description = each.value.desc
}
