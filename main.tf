
resource "local_file" "saved-manifesto" {
  content = data.template_file.userdata[each.key].rendered
  filename = "./rendered_template/${each.key}"

  for_each =  {
    for obj in var.targets : 
      obj.name => obj
    }
}

resource "null_resource" "concatenate_my_files" {

  triggers = {
    template = timestamp()
  }
  provisioner "local-exec" {
    working_dir = "./rendered_template"
    command = <<EOF
now=$(date +"%Y-%m-%d-%H-%M-%S")
truncate -s 0 $(ls -1 | grep -E "^stream.*.conf$")
awk 'FNR==1{print ""}1' * > stream_$now.conf
ls | grep -v stream_$now.conf | xargs rm -rf
EOF
  }
      depends_on = [
    local_file.saved-manifesto
  ]
}
