resource "random_password" "pwd" {
  length           = 18
  special          = true
  override_special = "_!%@"
}
