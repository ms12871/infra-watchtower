variable "github_repository" {
  description = "Name of the target GitHub repository"
  type        = string
  default     = "infra-watchtower"
}

variable "github_owner" {
  description = "GitHub username or organization"
  type        = string
  default     = "ms12871"
}

variable "default_branch" {
  description = "Default repository branch to protect"
  type        = string
  default     = "main"
}