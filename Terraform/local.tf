locals {
  build_environment = var.environment == "Test" ? "test" : "production"
}