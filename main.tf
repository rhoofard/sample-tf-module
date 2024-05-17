module "source_module2" {
  source = "github.com/rhoofard/sample-tf-module2?ref=v1.3.0"
  bloop = "jibberis"
  bleep = 0
 }

resource "random_integer" "fault" {
  min = 0
  max = 9
  keepers = {
    bloop = var.bloop
  }
}


locals {
  even_odd = tostring(random_integer.fault.result % 2)
}

resource "null_resource" "cluster" {
  triggers = {
    result = random_integer.fault.result
  }

  provisioner "local-exec" {
    command = "sh -c 'exit ${var.bleep}'"
  }
}
