# global shared

This part of the infrastructure is handled by Ansible and is used to provide configuration for setting up the compute infrastructure. It configures the most essential aspects of managing the following components:

- Networking
  - DHCP
  - DNS records
  - internal name resolution
- Compute
  - Machines
    - KVM hosts
    - Bare metal hosts
  - Virtual Machines
- Storage
  - Volumes

## Providers

- [Cloudlfare](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs)

## Variables

[variables.tf](/giswil/compute/network.tf) is the entrypoint for declaring networks. It provides a mapped approach to approach repeatabiliy and following DRY principles as much as possible. If it can be iterated and allow for the creationg of multiple resources with less code, then it will be implemented as a map or a list/set.

### Required vars

I believe that using defaults should only be used by constant values which should only change when required. variable definitions means that all variables will always be required. The following variables are defined:

| name            | type          | required           | description                                      |
| --------------- | ------------- | ------------------ | ------------------------------------------------ |
| maas_api_url    |  `string`     | `true`             | The url to the maas_api instance                 |
| maas_api_secret |  `string`     | `true (sensitive)` | api secret the user of the maas provider         |
| fabric          |  `string`     | `true`             | fabric is required to manage a network with maas |
| pool            | `object`      | `true`             | resource pool for the region                     |
| subnets         | `map(object)` | `subnets`          | Atleast one subnet must be specified             |

## Networking

The network configuration is managed by using the following terraform resources for reference:

For this instance the network will consist of one single network and may expand if needed. Here a brief overview:

| cidr            | gateway      | upstream_dns       |
| --------------- | ------------ | ------------------ |
| 192.168.10.0/24 | 192.168.10.1 | [1.1.1.1, 8.8.8.8] |

### DHCP

The rackd instance is going to be taking care of dhcp for all clients on this subnet. This way it can pass the desired DHCP-Option for booting over the network. The subnet will serve as the network for all Bare Metal Instances as well as our virtual machines on top the KVM virtualization layer.

### DNS Records

internal DNS Records are going going to be managed by the maas regiond instance. The regiond will be the authoritative domain for this region.

## Machines
