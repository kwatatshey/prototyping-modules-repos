module "eks_managed_node_groups" {
  source               = "terraform-aws-modules/eks/aws//modules/eks-managed-node-group"
  version              = "20.8.5"
  subnet_ids           = var.subnet_ids
  name                 = var.name
  cluster_name         = var.cluster_name
  cluster_service_cidr = var.cluster_service_cidr
  cluster_version      = var.cluster_version
  ami_type             = var.ami_type
  min_size             = var.min_size
  max_size             = var.max_size
  desired_size         = var.desired_size
  instance_types       = var.instance_types
  capacity_type        = var.capacity_type
  # use_custom_launch_template      = var.use_custom_launch_template
  # launch_template_use_name_prefix = true
  tag_specifications = var.tag_specifications
  # disk_size                       = var.disk_size
  # launch_template_tags = {
  #   # enable discovery of autoscaling groups by cluster-autoscaler
  #   "Name" = var.name
  #   "k8s.io/cluster-autoscaler/enabled" : true,
  #   "k8s.io/cluster-autoscaler/${var.cluster_name}" : "owned",
  # }
  # tags = var.tags

  tags = {
    ExtraTag = "EKS managed node group complete example"
  }

  # tags = var.tags

  create_iam_role = true
  # iam_role_arn         = aws_iam_role.node.arn
  iam_role_name                     = "${var.resource_prefix}-${var.environment}-${var.app_name}-node-group-role"
  iam_role_attach_cni_policy        = true
  iam_role_additional_policies      = merge({ "additional_policy" = module.additional_policy.arn }, var.iam_role_nodes_additional_policies)
  network_interfaces                = var.network_interfaces
  cluster_primary_security_group_id = var.cluster_primary_security_group_id
  #   vpc_security_group_ids = [
  #     aws_security_group.node_security_group.id,
  #     aws_security_group.alb.id
  #   ]
  #   vpc_security_group_ids = [
  #     aws_security_group.eks_security_groups["node"].id,
  #     aws_security_group.eks_security_groups["alb"].id
  #   ]

  #   vpc_security_group_ids = concat(
  #     var.create_node_security_group ? [aws_security_group.main[1].id] : [], # node_security_group
  #     [aws_security_group.main[0].id]                                        # alb_security_group
  #   )
  enable_monitoring = true
  block_device_mappings = {
    xvda = {
      device_name = "/dev/xvda"
      ebs = {
        volume_size           = 300
        volume_type           = "gp3"
        iops                  = 3000
        throughput            = 150
        encrypted             = true
        kms_key_id            = var.ebs_kms_key_arn
        delete_on_termination = true
      }
    }
  }

  metadata_options = {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
    instance_metadata_tags      = "enabled"
  }
  #Description: Path to a local, custom user data template file to use when rendering user data
  user_data_template_path = ""

  vpc_security_group_ids = var.vpc_security_group_ids
  # taints = {
  #   # This Taint aims to keep just EKS Addons and Karpenter running on this MNG
  #   # The pods that do not tolerate this taint should run on nodes created by Karpenter
  #   addons = {
  #     key    = "CriticalAddonsOnly"
  #     value  = "true"
  #     effect = "NO_SCHEDULE"
  #   },
  # }
}





resource "aws_autoscaling_policy" "eks_autoscaling_policy" {
  count                  = length(var.eks_managed_node_groups)
  name                   = "${element(module.eks_managed_node_groups.node_group_autoscaling_group_names, count.index)}-autoscaling-policy"
  autoscaling_group_name = element(module.eks_managed_node_groups.node_group_autoscaling_group_names, count.index)
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = var.autoscaling_average_cpu
  }
}

module "additional_policy" {
  source        = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version       = "5.39.0"
  create_policy = true
  name          = "${var.resource_prefix}-${var.environment}-${var.app_name}-additional-policy-${random_id.additional_id.hex}"
  path          = "/"
  description   = "Additional policy for eks node group"
  policy        = data.aws_iam_policy_document.additional_policy.json

  tags = {
    PolicyDescription = "Policy created using example from data source"
  }
}

resource "random_id" "additional_id" {
  byte_length = 8
}




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





# module "iam_iam-assumable-role" {
#   source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
#   version = "5.39.1"
# }

# data "aws_iam_policy_document" "assume_role" {
#   statement {
#     sid     = "EKSNodeAssumeRole"
#     actions = ["sts:AssumeRole"]
#     principals {
#       type        = "Service"
#       identifiers = ["ec2.amazonaws.com"]
#     }
#   }
# }

# resource "aws_iam_role" "node" {
#   name               = "${var.resource_prefix}-${var.environment}-${var.app_name}-node-group-role"
#   assume_role_policy = data.aws_iam_policy_document.assume_role.json
# }


