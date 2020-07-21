# Intro
For this episode i'll show you how to run "pi-hole" the ad blocker on docker on Synology.
However i'll be doing a few things different from what you may or may not have seen online already.
There are a few ways of running pi-hole on docker and/or synology but they all have certain drawbacks,
i did not want to live with.

### pi-hole on a docker bridge
* port 80 and 443 will clash with Synology webinterface and Webstation if installed.

```There are some workarounds here by using a reverse proxy and mapping to other ports```

But for me the biggest draw back is that on the dashboard all traffic always seems to come from 1 single private ip
the docker network GW due to the NAT translation that docker does.

### pi-hole on docker 'host' network
This again clashes with Synology ports and now you can't remap the ports as all will be bound to the synology's host network

```This can be workaround by modifing the service ports on synology```

But this means i'm always running a non standard deployment, with the chance of breaking at any update.
But hey at least it fixes not seeing the real client ip's

# Solution

We can create s special 'MacVlan' network, this will allow the pi-hole container to get a dedicated ip on our network.
This will solve:

* no port clashes with Synology as all ports will run only on dedicated ip
* Client ip's visible as we are part of the real network
* pi-hole has it's own ip we can reach -> almost like a VM but still a container
* Even dhcp would work, but i'm not using that.

## Persistent data
Let's start with creating our 2 folders with data that we need, mine will be called:

* /volume1/docker/pi-hole/config
* /volume1/docker/pi-hole/dnsmasq

make them via the file manager or putty with:

c
```mkdir -p /volume1/docker/pi-hole/dnsmasq```

## networking
Lets start with finding out what the network card is called in our Synology that we connected to our network 
As i'm also using virtualization station and ovs switches and bonding, this name can vary for everyone, 
so use the following command via putty to find out yours

```ip route |grep default```

the output will looks like this:

default via 192.168.0.1 dev ```ovs_bond2```  src 192.168.0.35

so in my case ```ovs_bond2``` is what i will use.

now lets create the macvlan network, you need the know the following items:
* gateway of your network
* subnet of your network
* one free ip in your network -> not part of your dhcp range

in my case the command looks like this:

```docker network create --driver=macvlan --gateway=192.168.0.1 --subnet=192.168.0.0/24 --ip-range=192.168.0.254/32 -o parent=ovs_bond2 VLAN1_pi-hole```

you can replace this "VLAN1_pi-hole" with any name you want

## starting pi-hole
execute the command, replacing the ip you selected for pi-hole and password

```
docker run --detach \
           --name pi-hole \
           --restart always \
           --volume /etc/localtime:/etc/localtime:ro \
           --volume /volume1/docker/pi-hole/config:/etc/pihole \
           --volume /volume1/docker/pi-hole/dnsmasq:/etc/dnsmasq.d \
           --cap-add NET_ADMIN \
           --dns=1.0.0.1 \
           --dns=1.1.1.1 \
           --env "DNS1=1.1.1.1" \
           --env "DNS2=1.0.0.1" \
           --env "ServerIP=192.168.0.254" \
           --env "DNSMASQ_LISTENING=local" \
           --env "WEBPASSWORD=somepassword" \
           --env "TZ=Asia/Dubai" \
           --network VLAN1_pi-hole \
           --ip "192.168.0.254" \
           --mac-address "02:42:c0:a8:01:d7" \
           pihole/pihole:latest
```

## run Pi-hole (if you have multiple networks/vlans)
Change 

--env "DNSMASQ_LISTENING=local"
 
 to

--env "DNSMASQ_LISTENING=```all```"
