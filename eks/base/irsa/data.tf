data "aws_iam_policy_document" "additional_policy" {
  statement {
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetRepositoryPolicy",
      "ecr:DescribeRepositories",
      "ecr:ListImages",
      "ecr:DescribeImages",
      "ecr:BatchGetImage",
      "ecr:GetLifecyclePolicy",
      "ecr:GetLifecyclePolicyPreview",
      "ecr:ListTagsForResource",
      "ecr:DescribeImageScanFindings",
      "ec2:*",
      "elasticfilesystem:*",
      "logs:*",
      "iam:PassRole",
      "logs:*",
      "events:*"
    ]
    effect    = "Allow"
    resources = ["*"]
  }
}