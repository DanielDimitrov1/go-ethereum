
# VPC and networking resources
resource "aws_vpc" "eks_vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.eks_vpc.id

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_subnet" "eks_subnets" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = element(var.public_subnet_cidrs, count.index)
  availability_zone       = element(var.azs, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "Lime-Public-subnet-${count.index + 1}"
  }

}

resource "aws_internet_gateway" "eks_igw" {
  vpc_id = aws_vpc.eks_vpc.id
  tags = {
    Name = var.internet_gateway_name
  }
}

resource "aws_eip" "eip" {
  depends_on = [aws_internet_gateway.eks_igw]
  tags = {
    Name = "eip-Lime"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  subnet_id     = aws_subnet.eks_subnets[1].id
  allocation_id = aws_eip.eip.id

  tags = {
    Name = var.nat_gateway_name
  }
  depends_on = [aws_internet_gateway.eks_igw]
}


resource "aws_route_table" "eks_rt" {
  vpc_id = aws_vpc.eks_vpc.id
  tags = {
    Name = var.route_table_name
  }
}

resource "aws_route" "eks_internet_access" {
  route_table_id         = aws_route_table.eks_rt.id
  destination_cidr_block = var.destination_cidr_block
  gateway_id             = aws_internet_gateway.eks_igw.id
}

resource "aws_route_table_association" "eks_rta" {
  count          = length(aws_subnet.eks_subnets)
  subnet_id      = element(aws_subnet.eks_subnets[*].id, count.index)
  route_table_id = aws_route_table.eks_rt.id
}

# EKS cluster

resource "aws_eks_cluster" "main" {
  name     = var.eks_cluster_name
  role_arn = var.eks_iam_role_arn

  vpc_config {
    subnet_ids         = aws_subnet.eks_subnets[*].id
    security_group_ids = aws_default_security_group.default[*].id
  }


}

# EKS node group
resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = var.eks_node_group_name
  node_role_arn   = var.eks_node_group_role_arn
  subnet_ids      = aws_subnet.eks_subnets[*].id

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  instance_types = ["t3.medium"]


}




resource "null_resource" "deploy_to_k8s" {
  provisioner "local-exec" {
    command = <<EOF
      aws eks get-token --cluster-name ${aws_eks_cluster.main.name} | jq -r '.status.token' > /mnt/d/project/go-ethereum/terraform/eks/token.txt
      kubectl create secret docker-registry regcred \
        --docker-server=hub.docker.com/u/danieldim12 \
        --docker-username=danieldim12 \
        --docker-password=****** \
        --docker-email=dimitrovdannniel@yahoo.com
      kubectl apply -f deployment.yaml

      
    EOF
  }

  depends_on = [
    aws_eks_node_group.main,
  ]
}
