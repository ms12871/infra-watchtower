output "managed_labels_count" {
  description = "Number of operational labels managed by Terraform"
  value       = length(github_issue_label.labels)
}

output "protected_branch" {
  description = "Branch protected by Terraform policy"
  value       = github_branch_protection_v3.main_protection.branch
}
