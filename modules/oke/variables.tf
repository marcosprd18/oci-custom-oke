variable "compartment_id" {
  default = "ocid1.compartment.oc1......."
}

variable "oke_oracle_linux_8" {
  default = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaa5wpgbx3zndwgb4rxmrus4rnwuf3u22k57srp2qdhf3sz76ruve5q"
}

variable "node_shape" {
  default = "VM.Standard.E4.Flex" ##AMD Shape
}

variable "vcn_nprod_id" {
  default = "ocid1.vcn.oc1.sa-saopaulo-1......."
}

variable "subnet_public_id" {
  default = "ocid1.subnet.oc1.sa-saopaulo-1......."
}

variable "subnet_private_id" {
  default = "ocid1.subnet.oc1.sa-saopaulo-1......."
}