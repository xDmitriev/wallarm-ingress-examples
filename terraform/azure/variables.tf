# Set default name prefix
variable "name_prefix" {
  default = "devops-test"
}

# Set default location
variable "location" {
  default = "East Asia"
}

variable "node_count" {
  default = 2
}

variable "kubernetes_version" {
  default = "1.24"
}