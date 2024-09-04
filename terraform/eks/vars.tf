variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public Subnet CIDR values"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "azs" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}



variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "vpc_name" {
  default = "Lime-VPC"
}

variable "internet_gateway_name" {
  default = "Lime-IGW"
}

variable "nat_gateway_name" {
  default = "Lime-nat-gw"
}

variable "route_table_name" {
  default = "public-access-rt"
}

variable "public_subnets_name" {
  default = "Lime-Public-subnet"
}


variable "destination_cidr_block" {
  default = "0.0.0.0/0"
}


variable "eks_cluster_name" {
  default = "my-eks-cluster"
}

variable "eks_node_group_name" {
  default = "my-node-group"
}


variable "eks_iam_role_arn" {
  type = string
}
variable "eks_node_group_role_arn" {
  type = string
}

