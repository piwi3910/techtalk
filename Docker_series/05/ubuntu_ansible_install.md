#Readme
In this series we will be installing ansible and connecting to our vCenter Server and clone a template


###install Prerequirements

sudo apt install python3-pip -y
sudo pip3 install ansible ||true
sudo pip3 install pyvmomi || true

ansible --version

``ansible 2.9.6
  config file = None
  configured module search path = ['/home/piwi/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/local/lib/python3.6/dist-packages/ansible
  executable location = /usr/local/bin/ansible
  python version = 3.6.9 (default, Nov  7 2019, 10:44:02) [GCC 8.3.0]``

### ssh keys

Ansible uses ssh and ssh keys to authenticate and connect to all the machines that we will be deploying
lets generate a ssh key for our local user

```ssh-keygen -t rsa```

