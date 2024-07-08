variable "owner" {
  type        = string
  description = "user principal name of the owner of the Github service principal"
}

variable "tags" {
  type        = map(string)
  description = "values of the tags to be assigned to the service principal"
}

variable "subscription_ids" {
  type        = set(string)
  description = "ids of the subscriptions to assign the service principal to"
}
