 
variable "targets" {
  type = list(object(
  {
    name = string
    port = number
    target = string 
    target_port = number
  }))
  default = [
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
}