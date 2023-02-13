resource "aws_iam_policy" "eks_admin_policy" {
  name        = "eks_admin_policy"
  path        = "/"
  description = "eks admin policy"

  policy = jsonencode({
    Version: "2012-10-17",
    Statement: [
        {
            "Effect": "Allow",
            "Action": "eks:*",
            "Resource": "*"
        }
    ]
  })
}
