data "template_file" "userdata" {
  template = file("${path.module}/server.tpl")
  vars = {
    listen_port = each.value.port
    target = each.value.target
    target_port = each.value.target_port
  }

  for_each =  {
    for obj in var.targets : 
      obj.name => obj
    }
}