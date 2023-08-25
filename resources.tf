resource "aws_security_group" "battlebit" {
  description = "for battlebit"
  egress = [
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    },
  ]
  ingress = [
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 8080
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 8080
    }
  ]
  name                   = "Battlebit"
  revoke_rules_on_delete = false
}

resource "aws_launch_template" "battlebit" {
  description                          = null
  disable_api_stop                     = false
  disable_api_termination              = false
  ebs_optimized                        = "true"
  image_id                             = "ami-010394ab667fbb251"
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "t3.small"
  kernel_id                            = null
  key_name                             = "Battlebit"
  name                                 = "Battlebit"
  name_prefix                          = null
  ram_disk_id                          = null
  tags                                 = {}
  tags_all                             = {}
  update_default_version               = true
  user_data                            = base64encode(templatefile("${path.module}/user-data", {}))
  block_device_mappings {
    device_name  = "/dev/sda1"
    no_device    = null
    virtual_name = null
    ebs {
      delete_on_termination = "true"
      encrypted             = "false"
      iops                  = 3000
      kms_key_id            = null
      snapshot_id           = null
      throughput            = 125
      volume_size           = 30
      volume_type           = "gp3"
    }
  }
  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }
  credit_specification {
    cpu_credits = "unlimited"
  }
  hibernation_options {
    configured = false
  }
  maintenance_options {
    auto_recovery = "default"
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "optional"
    instance_metadata_tags      = "disabled"
  }
  monitoring {
    enabled = false
  }
  network_interfaces {
    associate_carrier_ip_address = null
    associate_public_ip_address  = "false"
    delete_on_termination        = "true"
    description                  = null
    device_index                 = 0
    interface_type               = null
    ipv4_address_count           = 0
    ipv4_addresses               = []
    ipv4_prefix_count            = 0
    ipv4_prefixes                = []
    ipv6_address_count           = 0
    ipv6_addresses               = []
    ipv6_prefix_count            = 0
    ipv6_prefixes                = []
    network_card_index           = 0
    network_interface_id         = null
    private_ip_address           = null
    security_groups              = [aws_security_group.battlebit.id]
    subnet_id                    = "subnet-009fdc076a938b32f"
  }
  placement {
    affinity                = null
    availability_zone       = null
    group_name              = null
    host_id                 = null
    host_resource_group_arn = null
    partition_number        = 0
    spread_domain           = null
    tenancy                 = "default"
  }
  private_dns_name_options {
    enable_resource_name_dns_a_record    = true
    enable_resource_name_dns_aaaa_record = false
    hostname_type                        = "ip-name"
  }
}

resource "aws_instance" "battlebit" {
  launch_template {
    id      = aws_launch_template.battlebit.id
    version = "$Latest"
  }
}

resource "aws_eip_association" "battlebit" {
  instance_id   = aws_instance.battlebit.id
  #replace with your own EIP
  allocation_id = "eipalloc-073745f62edf3f34e"
}
