output "dns_ALB" {
    description = "DNS pública del load balancer"
    value = module.loadbalancer.dns_ALB
}