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

module "front-engineer-role" {
  source  = "tf-mod/rbac-role/aws"
  version = "1.0.0"

  name        = "front-engineer-role"
  stack       = "dev-qa-prod"
  policy_arn  = ["arn:aws:iam::aws:policy/AmazonRedshiftFullAccess"]
}

module "back-engineer-role" {
  source  = "tf-mod/rbac-role/aws"
  version = "1.0.0"

  name        = "back_engineer_role"
  stack       = "dev-qa-prod"
  policy_arn  = [aws_iam_policy.eks_admin_policy.arn]
}

module "data-engineer-role" {
  source  = "tf-mod/rbac-role/aws"
  version = "1.0.0"

  name        = "data_engineer_role"
  stack       = "dev-qa-prod"
  policy_arn  = ["arn:aws:iam::aws:policy/AmazonRedshiftFullAccess"]
}

module "site-reliability-engineer-role" {
  source  = "tf-mod/rbac-role/aws"
  version = "1.0.0"

  name        = "site_reliability_engineer_role"
  stack       = "dev-qa-prod"
  policy_arn  = ["arn:aws:iam::aws:policy/AdministratorAccess", "arn:aws:iam::aws:policy/PowerUserAccess"]
}
