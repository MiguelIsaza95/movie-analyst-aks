variable "location" {
  type        = string
  description = "Location to launch vms"
}
variable "username" {
  type        = string
  description = "Default username for administrate the vm"
}
variable "name" {
  type        = string
  description = "Name of the virtual machine"
}
variable "nic" {
  type        = list(string)
  description = "ID of the network interface"
}
variable "rg_name" {
  type        = string
  description = "Name of the RG to place the virtual machine"
}
variable "vm_size" {
  type        = string
  description = "Size of the disk to use"
}
variable "os_name" {
  type        = string
  description = "Name of the disk to mount"
}
variable "os_caching" {
  type        = string
  description = "Permissions over the disk"
}
variable "storage_account_type" {
  type        = string
  description = "Account type of the storage"
}
variable "ami_offer" {
  type        = string
  description = "Linux distribution of the ami"
}
variable "ami_publisher" {
  type        = string
  description = "The publisher of the ami"
}
variable "ami_sku" {
  type        = string
  description = "Distribution of the ami"
}
variable "ami_version" {
  type        = string
  description = "Version of the ami"
}
variable "computer_name" {
  type        = string
  description = "Name to identify the vm"
}
variable "disable_passwd_auth" {
  type        = bool
  description = "Disable or Enable passwd authentication"
  default     = true
}
variable "ssh_key" {
  default     = ""
  description = "SSH Key"
}
variable "disk_size" {
  type        = number
  default     = 10
  description = "Size of the disk"
}
variable "provision_script" {
  type        = string
  description = "Custom scrip to provision the vm"
}