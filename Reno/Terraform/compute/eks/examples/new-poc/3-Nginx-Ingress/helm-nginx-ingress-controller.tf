resource "helm_release" "nginx-ingress-controller" {
  name       = "controller"
  #repository = "https://kubernetes.github.io/ingress-nginx"
  #chart      = "ingress-nginx"
  repository = "https://helm.nginx.com/stable"
  chart      = "nginx-ingress"

  /*set {
    name  = "service.type"
    #value = "LoadBalancer"
  }*/

  set {
    name  = "controller.admissionWebhooks.enabled"
    value = "false"
  }
}
