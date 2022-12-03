# resource block to expose wordpess service to public

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
