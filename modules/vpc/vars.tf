variable "project_name" {
  default = "project_1"
}

variable "user_name" {
  default = "user_1"
}

variable "user_password" {
  default = ""
  sensitive = true
}
