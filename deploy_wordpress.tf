# Terraform file for launching wordpress container on kubernetes in local system


# provider block
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

resource "kubernetes_service" "wordpress_svc" {
metadata {
    name = "expose_wordpress"
}
spec {
    selector = {
        site =        kubernetes_deployment.wps.spec[0].template[0].metadata[0].labels.site
   }
   port {
   node_port   = 30001
   port        = 8080
   target_port = 80
  }
  type = "NodePort"
  }
}
