resource "kubernetes_service_account" "pod_sa" {
  metadata {
    name      = "pod-assume-role-account"
    namespace = "default"
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.pod_sa.arn
    }
  }
}
