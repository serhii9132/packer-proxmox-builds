variable "sudo_user" {
  type = string
  default = env("SUDO_USER")
}

variable "sudo_user_pass" {
  type = string
  default = env("SUDO_USER_PASSWORD")
}

variable "ssh_public_key" {
  type = string
  default = env("SSH_PUBLIC_KEY")
}

variable "ssh_pivate_key_file" {
  type = string
  default = env("SSH_PRIVATE_KEY_FILE")
}

variable "root_password" {
  type = string
  default = env("ROOT_PASSWORD")
}