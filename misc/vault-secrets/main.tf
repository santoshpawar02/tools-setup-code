terraform {
  backend "s3" {
    bucket = "testtfbuc"
    key = "vault-secrets/state"
    region = "us-east-1"
    }
}

provider "vault" {
  address = "http://vault-internal.santoshpawar.site:8200"
  token = var.vault_token
}

variable "vault_token" {}

resource "vault_mount" "ssh" {
  path = "infra"
  type = "kv"
  options = { version = "2" }
  description = "Infra secrets"
}

resource "vault_generic_secret" "ssh" {
  path = "${vault_mount.ssh.path}/ssh"

  data_json = <<EOT
{
  "username": "ec2-user",
  "password": "DevOps321"
}
EOT
}

resource "vault_mount" "roboshop-dev" {
  path        = "roboshop-dev"
  type        = "kv"
  options     = { version = "2" }
  description = "Roboshop Dev secrets"
}

resource "vault_generic_secret" "roboshop-dev-cart" {
  path = "${vault_mount.roboshop-dev.path}/cart"

  data_json = <<EOT
{
"REDIS_HOST":   "redis-dev.santoshpawar.site",
"CATALOGUE_HOST": "catalogue-dev.santoshpawar.site",
"CATALOGUE_PORT": "8080"
}
EOT
}

resource "vault_generic_secret" "roboshop-dev-catalogue" {
  path = "${vault_mount.roboshop-dev.path}/catalogue"

  data_json = <<EOT
{
"MONGO":   "true",
"MONGO_URL": "mongodb://mongo-dev.santoshpawar.site:27017/catalogue"
}
EOT
}

resource "vault_generic_secret" "roboshop-dev-frontend" {
  path = "${vault_mount.roboshop-dev.path}/frontend"

  data_json = <<EOT
{
"catalogue":   "http://catalogue-dev.santoshpawar.site:8080/",
"user":   "http://user-dev.santoshpawar.site:8080/",
"cart":   "http://cart-dev.santoshpawar.site:8080/",
"shipping":   "http://shipping-dev.santoshpawar.site:8080/"
}
EOT
}

# "payment":   "http://payment-dev.santoshpawar.site:8080/" ## remove from above block

# resource "vault_generic_secret" "roboshop-dev-payment" {
#   path = "${vault_mount.roboshop-dev.path}/payment"

#   data_json = <<EOT
# {
# "CART_HOST" : "cart-dev.santoshpawar.site",
# "CART_PORT" : 8080,
# "USER_HOST" : "user-dev.santoshpawar.site",
# "USER_PORT" : 8080,
# "AMQP_HOST" : "rabbitmq-dev.santoshpawar.site",
# "AMQP_USER" : "roboshop",
# "AMQP_PASS" : "roboshop123"
# }
# EOT
# }

resource "vault_generic_secret" "roboshop-dev-shipping" {
  path = "${vault_mount.roboshop-dev.path}/shipping"

  data_json = <<EOT
{
"CART_ENDPOINT" : "cart-dev.santoshpawar.site:8080",
"DB_HOST" : "mysql-dev.santoshpawar.site"
}
EOT
}

resource "vault_generic_secret" "roboshop-dev-user" {
  path = "${vault_mount.roboshop-dev.path}/user"

  data_json = <<EOT
{
"MONGO" : "true",
"REDIS_URL" : "redis://redis-dev.santoshpawar.site:6379",
"MONGO_URL" : "mongodb://mongo-dev.santoshpawar.site:27017/users"
}
EOT
}