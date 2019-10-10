#Define variables
variable "env" {
  description = "env: dev or prod"
}

variable "container_name" {
  type        = "map"
  description = "Name of container"
  default     = {
    dev   = "blog_dev"
    prod  = "blog_prod"
  }
}

variable "image_name" {
  type        = "map"
  description = "Image for container"
  default     = {
    dev   = "ghost:latest"
    prod  = "ghost:alpine"
  }
} 

variable "int_port" {
  description = "Internal port for container"
  default     = "2368"
}

variable "ext_port" {
  type        = "map"
  description = "External port for container"
  default     = {
    dev   = "8080"
    prod  = "80"
  }
}

