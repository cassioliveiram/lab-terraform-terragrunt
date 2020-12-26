variable "name" {
  description = "The name of resource"
  type = string
  default = "moreira-lab"
}

variable "image_id" {
  description = "The image of your instance"
  type = string
  default = ""
}

variable "tags" {
  description = "Map containing tags to associate to AWS resources."
  default     = {}
  type        = map(string)
}

variable "ebs_optimized" {
  description = "Definition if ebs volume is true or false"
  type = bool
  default = true
}

variable "instance_type" {
  description = "Define instance type"
  type = string
  default = "t3.micro"
}

variable "key_name" {
  description = "The key used to access the instance using ssh"
  type = string
  default = "moreira-lab"
}

variable "user_data" {
  description = "An script to run at boot of instance. You can customize values and set default things you want run at launch of instance"
  type = string
  default = null
}

variable "enable_monitoring" {
  description = "This value enables a lot of monitoring on aws side, you can see this values in cloudwatch"
  type = bool
  default = true
}

variable "root_block_device" {
  description = "Customize details about the root block device of the instance."
  default = [{
    volume_type           = "gp2"
    volume_size           = 8
    encrypted             = true
    iops                  = 0
    delete_on_termination = true
  }]

  type = list(
    object(
      {
        volume_type           = string,
        volume_size           = number,
        encrypted             = bool,
        iops                  = number,
        delete_on_termination = bool
      }
    )
  )
}

variable "ebs_block_device" {
  description = "Additional EBS block devices to attach to the instance."
  default     = []

  type = list(
    object(
      {
        volume_type           = string,
        volume_size           = number,
        encrypted             = bool,
        iops                  = number,
        delete_on_termination = bool,
        device_name           = string
      }
    )
  )
}