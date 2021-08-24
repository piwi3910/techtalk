In this episode we will look at what is Ansible? Why use it? Why it's so much better then the rest?
and then we will look at installing it. I'll show you how to install it on Redhat based OS (Rocky/Centos) and a Debian based OS (Ubuntu)
via the package manager. I'll show you how to install it via python packages (pip), How to select a specific version and why you would want that. And last how to install it in a "Virtual environment" so that you can have multiple versions next to each other.


# What is Ansible

From Wikipedia:
Ansible is an open-source software provisioning, configuration management, and application-deployment tool enabling infrastructure as code. It runs on many Unix-like systems, like Ubuntu, Redhat, Debian... , and it can configure both Unix/Linux-like systems as well as Microsoft Windows. It includes its own declarative language to describe system configuration. Ansible is agentless, temporarily connecting remotely via SSH or Windows Remote Management (allowing remote PowerShell execution) to do its tasks.

* Software provisioning
* Configuration management
* Application deployment -> for example Docker or Kubernetes
* Enables Infrastructure as Code
* Declaritive code
* Agentless

Other Examples:

* Puppet
* Terraform
* Salt
* Chef
* CFengine


## Infrastructure as Code

From Wikipedia:
Infrastructure as code (IaC) is the process of managing and provisioning computer data centers through machine-readable definition files, rather than physical hardware configuration or interactive configuration tools. The IT infrastructure managed by this process comprises both physical equipment, such as bare-metal servers, as well as virtual machines, and associated configuration resources. The definitions may be in a version control system. It can use either scripts or declarative definitions, rather than manual processes, but the term is more often used to promote declarative approaches.

So Basically, it allows us to describe the configuration of our infrastructure as a configuration file that can be applied to it, to bring it back in the state we requested. Key here is "Declaritive Code"

### Example:

```
---

- hosts: docker
  gather_facts: yes
  become: yes
  roles:
    - common
    - disk
    - docker_install
```
## Declaritive Code

Declarartive code is code where we declare the "endstate" that we would like to have, but we don't really care about the starting state.
The application it self will request the starting state and figure out the steps it needs to take to bring the device to the state we requested.
This compared to imperative code, where we tell the application every single step it needs to take.

### Example:
```
install apache
change a configuration file
```

## Imperative code:

1. apt install apache -y (if Debian derevative)
2. sed -i "s/hostname/myhostname/g" /etc/apache.conf

### Questions:
* What if Apache is already installed?
* What if it's a Centos version and not Ubuntu?
* What if the configfile was changed already and it said "hostname2"

in all those cases our code would fail and this shows the weakness of emparative code.
If you don't provide the exact starting state your script expects it will fail.

## Declaritive code:

```
- name: Install apache
  ansible.builtin.package:
    name: apache
    state: present

- name: replace hostname
  ansible.builtin.replace:
    path: /etc/apache.conf
    regexp: 'hostname'
    replace: 'myhostname'
```

### Questions:
* What if Apache is already installed?

*Ansible will see apache is already installed and skip doing anything. If we change the word "present" to "latest" it will always try to update apache to the latest version if there is any*

* What if it's a Centos version and not Ubuntu?

*Ansible will look at what linux version and flavor we are running and will determin if it needs to use yum, dnf, apt, apk .... and run the correct package manager, all this with the same code*

* What if the configfile was changed already and it said "hostname2"

*Ansible will still fail here, as the function we are using is specifically using the replace function. But smarter ways can be used like search and replacing a line between 2 other known lines, or use Jinja templating to create the whole config file from a template*

As you see, a tool or declarative code does not stop you from writing bad code. It enables you to do better.
One of the key best practices with Ansible is to write idempotent code. This means code that you can run again and again and again, and you don't need to care if it was already run before. It will not break things. But even with the best tool you can use it in a bad way. 
That's why we will have this Beginner series.

# Installing

## Redhat based (Rocky)

```
dnf install epel-release -y
dnf update -y
dnf install ansible -y

ansible --version

ansible 2.9.24
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/root/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3.6/site-packages/ansible
  executable location = /usr/bin/ansible
  python version = 3.6.8 (default, May 19 2021, 03:00:47) [GCC 8.4.1 20200928 (Red Hat 8.4.1-1)]
```

## Debian based (Ubuntu)

```
sudo apt install ansible -y

ansible --version

ansible 2.9.6
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/home/piwi/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  executable location = /usr/bin/ansible
  python version = 3.8.10 (default, Jun  2 2021, 10:49:15) [GCC 9.4.0]

```

## Python Install Packages (pip)

Makes sure you have pip or pip3 installed (pip3 preferred as it's based on python3)

```
sudo apt install python3-pip -y    (Debian Based)

dnf install python3-pip -y    (Redhat Based)
```

pip can install ansible by default in two different ways:

* as root -> this will install ansible for the whole machine and any user including root can use it. This is similar like how the apt or dnf command installs Ansible
* as you user -> this will install ansible in your users path and home folders. This is an advanced install that i would not recommend. If you want an Ansible installation for your user only use a "Virtual env" install as will be demonstrated below. Else some modules could still conflict.

Make sure you are root!

```
sudo su -
```

```
pip3 install ansible

ansible --version

ansible [core 2.11.4]
  config file = None
  configured module search path = ['/root/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/local/lib/python3.8/dist-packages/ansible
  ansible collection location = /root/.ansible/collections:/usr/share/ansible/collections
  executable location = /usr/local/bin/ansible
  python version = 3.8.10 (default, Jun  2 2021, 10:49:15) [GCC 9.4.0]
  jinja version = 3.0.1
  libyaml = True

pip3 list |grep ansible

ansible                4.4.0
ansible-core           2.11.4
```

As you can see, we now have two packages "ansible" and "ansible-core" -> this is because in newer versions, Ansible has split the modules it was packaging from the core functionality. And when you install via pip you always get the latest version.

### Choose a different version

You may want to install a different or older version, as you may have some code that is not yet compatible with the latest version.
Lets find what versions are available

```
pip3 install ansible==

ERROR: Could not find a version that satisfies the requirement ansible== (from versions: 1.0, 1.1, 1.2, 1.2.1, 1.2.2, 1.2.3, 1.3.0, 1.3.1, 1.3.2, 1.3.3, 1.3.4, 1.4, 1.4.1, 1.4.2, 1.4.3, 1.4.4, 1.4.5, 1.5, 1.5.1, 1.5.2, 1.5.3, 1.5.4, 1.5.5, 1.6, 1.6.1, 1.6.2, 1.6.3, 1.6.4, 1.6.5, 1.6.6, 1.6.7, 1.6.8, 1.6.9, 1.6.10, 1.7, 1.7.1, 1.7.2, 1.8, 1.8.1, 1.8.2, 1.8.3, 1.8.4, 1.9.0.1, 1.9.1, 1.9.2, 1.9.3, 1.9.4, 1.9.5, 1.9.6, 2.0.0.0, 2.0.0.1, 2.0.0.2, 2.0.1.0, 2.0.2.0, 2.1.0.0, 2.1.1.0, 2.1.2.0, 2.1.3.0, 2.1.4.0, 2.1.5.0, 2.1.6.0, 2.2.0.0, 2.2.1.0, 2.2.2.0, 2.2.3.0, 2.3.0.0, 2.3.1.0, 2.3.2.0, 2.3.3.0, 2.4.0.0, 2.4.1.0, 2.4.2.0, 2.4.3.0, 2.4.4.0, 2.4.5.0, 2.4.6.0, 2.5.0a1, 2.5.0b1, 2.5.0b2, 2.5.0rc1, 2.5.0rc2, 2.5.0rc3, 2.5.0, 2.5.1, 2.5.2, 2.5.3, 2.5.4, 2.5.5, 2.5.6, 2.5.7, 2.5.8, 2.5.9, 2.5.10, 2.5.11, 2.5.12, 2.5.13, 2.5.14, 2.5.15, 2.6.0a1, 2.6.0a2, 2.6.0rc1, 2.6.0rc2, 2.6.0rc3, 2.6.0rc4, 2.6.0rc5, 2.6.0, 2.6.1, 2.6.2, 2.6.3, 2.6.4, 2.6.5, 2.6.6, 2.6.7, 2.6.8, 2.6.9, 2.6.10, 2.6.11, 2.6.12, 2.6.13, 2.6.14, 2.6.15, 2.6.16, 2.6.17, 2.6.18, 2.6.19, 2.6.20, 2.7.0.dev0, 2.7.0a1, 2.7.0b1, 2.7.0rc1, 2.7.0rc2, 2.7.0rc3, 2.7.0rc4, 2.7.0, 2.7.1, 2.7.2, 2.7.3, 2.7.4, 2.7.5, 2.7.6, 2.7.7, 2.7.8, 2.7.9, 2.7.10, 2.7.11, 2.7.12, 2.7.13, 2.7.14, 2.7.15, 2.7.16, 2.7.17, 2.7.18, 2.8.0a1, 2.8.0b1, 2.8.0rc1, 2.8.0rc2, 2.8.0rc3, 2.8.0, 2.8.1, 2.8.2, 2.8.3, 2.8.4, 2.8.5, 2.8.6, 2.8.7, 2.8.8, 2.8.9, 2.8.10, 2.8.11, 2.8.12, 2.8.13, 2.8.14, 2.8.15, 2.8.16rc1, 2.8.16, 2.8.17rc1, 2.8.17, 2.8.18rc1, 2.8.18, 2.8.19rc1, 2.8.19, 2.8.20rc1, 2.8.20, 2.9.0b1, 2.9.0rc1, 2.9.0rc2, 2.9.0rc3, 2.9.0rc4, 2.9.0rc5, 2.9.0, 2.9.1, 2.9.2, 2.9.3, 2.9.4, 2.9.5, 2.9.6, 2.9.7, 2.9.8, 2.9.9, 2.9.10, 2.9.11, 2.9.12, 2.9.13, 2.9.14rc1, 2.9.14, 2.9.15rc1, 2.9.15, 2.9.16rc1, 2.9.16, 2.9.17rc1, 2.9.17, 2.9.18rc1, 2.9.18, 2.9.19rc1, 2.9.19, 2.9.20rc1, 2.9.20, 2.9.21rc1, 2.9.21, 2.9.22rc1, 2.9.22, 2.9.23rc1, 2.9.23, 2.9.24rc1, 2.9.24, 2.9.25rc1, 2.9.25, 2.10.0a1, 2.10.0a2, 2.10.0a3, 2.10.0a4, 2.10.0a5, 2.10.0a6, 2.10.0a7, 2.10.0a8, 2.10.0a9, 2.10.0b1, 2.10.0b2, 2.10.0rc1, 2.10.0, 2.10.1, 2.10.2, 2.10.3, 2.10.4, 2.10.5, 2.10.6, 2.10.7, 3.0.0b1, 3.0.0rc1, 3.0.0, 3.1.0, 3.2.0, 3.3.0, 3.4.0, 4.0.0a1, 4.0.0a2, 4.0.0a3, 4.0.0a4, 4.0.0b1, 4.0.0b2, 4.0.0rc1, 4.0.0, 4.1.0, 4.2.0, 4.3.0, 4.4.0)
ERROR: No matching distribution found for ansible==
```

Now choose the version you want:

```
pip3 install ansible==2.9.6

ansible --version

ansible 2.9.6
  config file = None
  configured module search path = ['/root/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/local/lib/python3.8/dist-packages/ansible
  executable location = /usr/local/bin/ansible
  python version = 3.8.10 (default, Jun  2 2021, 10:49:15) [GCC 9.4.0]
```

### Install Ansible in a "Virtual" Environment

*Question: What is a "Virtual" Environonment?*

A virtual environment allows you to create an isolated bubble, where you can specificy and run your own python version and python modules without conflicting with the python version and modules of the main system. This is usefull when you OS installs certain python packages with it's package manager (yum, dnf, apt) and you need a newer or older version that is not avaiable via packages or would break your OS system.

*Make sure you are NOT root! Run this as your own user.*

As we may be building specific python versions, it makes sense to install the build tools to do so.

```
sudo apt-get install build-essential libssl-dev libffi-dev python-dev wheel
```

install virtual env support

```
sudo apt-get install -y python3-venv
```

You can now create a directory that will hold your virtual env's. Mostly this is done in your home folder/

```
mkdir directory_env
cd directory_env
```

Now create a new Virtual env -> we will make one based on the current python installed. You can change that version also, but is beyond the scope of this tutorial. As our main focus is isolating Ansible.

```
python3 -m venv environment1

ls environment1

bin  include  lib  lib64  pyvenv.cfg  share
```

Our Virtual env is now create, but to use it, we need to go inside it.
We do this by sourcing / activating our virt env. you will see our prompt change after we activated our virt env.

```
source environment1/bin/activate

(environment1) piwi@ubuntu2004:~/directory_env$
``` 

Now that we are in our virtual env, we can install any ansible version or modules with pip3 without conflicting with our OS install.

lets first install some prerequirements, Don't forget we now have a clean python version, without any of the modules from our OS install.

```
pip3 install wheel
```

and install Ansible as show previously

```
pip3 install ansible
```

When we now call ansible --version we can see the path is inside our virtual env.

```
(environment1) piwi@ubuntu2004:~/directory_env$ ansible --version
ansible [core 2.11.4]
  config file = None
  configured module search path = ['/home/piwi/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /home/piwi/directory_env/environment1/lib/python3.8/site-packages/ansible
  ansible collection location = /home/piwi/.ansible/collections:/usr/share/ansible/collections
  executable location = /home/piwi/directory_env/environment1/bin/ansible
  python version = 3.8.10 (default, Jun  2 2021, 10:49:15) [GCC 9.4.0]
  jinja version = 3.0.1
  libyaml = True
```

In the next episode we will start using Ansible.



