first limitation: overlay network is limited to /24
if trying to make a network with a bigger subnet:

root@docker01:~# docker network create --driver overlay --gateway=10.0.0.1 --subnet=10.0.0.0/8 test
uifs7aobhoezthusq3pdjgz70

network doesn't show any driver:


root@docker01:~# docker network ls
NETWORK ID          NAME                DRIVER              SCOPE
2cdb5e3658e8        bridge              bridge              local
6f06bf049404        docker_gwbridge     bridge              local
bb5931c4ff6f        host                host                local
tka0l3fsi8sz        ingress             overlay             swarm
57a2a1fb9a0a        none                null                local
uifs7aobhoez        test                                    swarm

limitation reference:
https://docs.docker.com/engine/reference/commandline/network_create/
(overlay network limitations section)

``You should create overlay networks with /24 blocks (the default), which limits you to 256 IP addresses, when you create networks using the default VIP-based endpoint-mode. This recommendation addresses limitations with swarm mode. If you need more than 256 IP addresses, do not increase the IP block size. You can either use dnsrr endpoint mode with an external load balancer, or use multiple smaller overlay networks. See Configure service discovery for more information about different endpoint modes.``

