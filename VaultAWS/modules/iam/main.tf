data "aws_iam_policy_document" "breakglass_trust" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = [var.admin_principal_arn]
    }
  }
}

resource "aws_iam_role" "breakglass_admin" {
  name               = "${var.project_name}-BreakGlassAdmin"
  assume_role_policy = data.aws_iam_policy_document.breakglass_trust.json
}

resource "aws_iam_role_policy_attachment" "breakglass_admin_attach" {
  role       = aws_iam_role.breakglass_admin.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_role" "terraform_deploy" {
  name = "${var.project_name}-TerraformDeploy"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = "sts:AssumeRole"
      Principal = { AWS = var.admin_principal_arn }
    }]
  })
}

resource "aws_iam_policy" "terraform_minimal" {
  name = "${var.project_name}-TerraformPolicy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = "*"
      Resource = "*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "terraform_policy_attach" {
  role       = aws_iam_role.terraform_deploy.name
  policy_arn = aws_iam_policy.terraform_minimal.arn
}

resource "aws_iam_role" "audit_readonly" {
  name = "${var.project_name}-AuditReadOnly"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = "sts:AssumeRole"
      Principal = { AWS = var.admin_principal_arn }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "audit_readonly_attach" {
  role       = aws_iam_role.audit_readonly.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}
