resource "aws_iam_role" "pod_sa" {
  name = "podServiceAccountRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "s3_policy" {
  name        = "PodS3PolicyTest"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "s3:Get*",
          "s3:List*",
          "s3:Put*",
          "s3:Delete*",
        ]
        Resource = "arn:aws:s3:::*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "pod_policy" {
  policy_arn = aws_iam_policy.s3_policy.arn
  role       = aws_iam_role.pod_sa.name
}
