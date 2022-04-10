variable "github_owner" {
  type        = string
  description = "github owner"
}

variable "github_token" {
  type        = string
  description = "github token"
}

variable "repository_name" {
  type        = string
  default     = "flux2_devopsdo"
  description = "github repository name"
}

variable "repository_visibility" {
  type        = string
  default     = "private"
  description = "How visible is the github repo"
}

variable "branch" {
  type        = string
  default     = "main"
  description = "branch name"
}

variable "target_path" {
  type        = string
  default     = "dev_cluster"
  description = "flux sync target path"
}

variable "token" {
  description = "Yandex.Cloud Token"
  type = string
}

variable "cloud_id" {
  description = "Cloud Id"
  type = string
}

variable "folder_id" {
  description = "Folder Id"
  type = string
}

variable "dependencies" {
  # Do the following in the module declaration:
  # dependencies = ["${some_resource.resource_alias.id}"]
  default     = []
  type        = any
  description = "Resources/modules that this module depends on. Regular `depends_on` block do not work for this module."
}
