# terraform-template-merge-files

If you want to generate a configuration file which includes repeated block config like Nginx or ansible inventory file, this approach can help you create a single config file using terraform template.
This mini project describes how you create Nginx stream configuration using template and redirect rendered files in to a single file using null_resource.

# How it works
you create the custom config values in your variables.tf
```
targets= [
      {
        name = "serverA"  
        port = 8888
        target = "myfirst-server.com"
        target_port = 1522
      },
     {
        name = "serverB"     
        port = 5555
        target = "mysecond-server.com"
        target_port = 5432
     } 
    ]
``` 

And you want to render following template for each server:
``` 
server {
   listen ${listen_port};
   proxy_pass        ${target}:${target_port};
   proxy_connect_timeout 100s;
}
``` 

After terraform apply the above code block executed 2 times and redirected the contents to one single stream_<timestamp>.conf file. The generated file is stored on your local machine under rendered_template/ directory

