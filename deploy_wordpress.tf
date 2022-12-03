# Terraform file for launching wordpress container on kubernetes in local system


# provider block for launching wordpress pod
provider "kubernetes" {
    config_context = "minikube"
}


# resource block
resource "kubernetes_deployment" "wps" {
   metadata {
       name = "wordpress"
   }
   spec {
      replicas = 3
      selector {
           match_labels = {
              "env" = "development" 
              "loc" = "IN"
              "site" = "Wordpress"
           }
      } 
   template { 
      metadata {
         labels = {
           "env" = "development"
           "loc" = "IN"
           "site" = "Wordpress"
        }
     }
     spec {
        container {
           image = "wordpress"
           name  = "wp"
       }
     }
   }
 }
}

