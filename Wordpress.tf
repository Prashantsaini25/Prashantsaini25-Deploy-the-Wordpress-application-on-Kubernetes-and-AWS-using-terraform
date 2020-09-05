provider "kubernetes" {
  config_context_cluster   = "minikube"
}

resource "kubernetes_pod" "wp1" {
  metadata {
    name = "wp1"
    labels = {
       app = "wordpress"
    }
  }
 
  spec {
    container {
       image = "wordpress"
       name  = "wp1"
     }
  }
 }


resource "kubernetes_service" "wp_lb" {
  metadata {
    name = "wplb"
  }
  spec {
    selector = {
      app = "${kubernetes_pod.wp1.metadata.0.labels.app}"
    }
    port {
      node_port   = 32123
      port        = 80
      target_port = 80
    }
    type = "NodePort"
}
}

