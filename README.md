# dev.zakwest.tech
A vagrant setup for development of www.zakwest.tech


## Tools
You need these tools installed to be able to use this project. 
* GIT: http://git-scm.com/downloads
* Virtual Box: https://www.virtualbox.org/wiki/Downloads
* Vagrant: http://vagrantup.com

## Downloading
### dev.zakwest.tech
This repo contains the configs needed to create and provision a vagrant VM.
```bash
    git clone https://github.com/zwrawr/dev.zakwest.tech.git dev.zakwest.tech
```
### www.zakwest.tech
Fork the [www.zakwest.tech](https://github.com/zwrawr/www.zakwest.tech.git) repo, which contains 
```bash
    cd dev.zakwest.tech/
    git clone https://github.com/<your-username>/www.zakwest.tech.git www.zakwest.tech
```

## Using vagrant
It's important to do this from a git-bash shell running as admin if your on windows.
### Starting the VM
This starts and provisions a new VM for you to use when testing. The first time you do this it'll take a while.
```bash
    vagrant up
```
### Stoping the VM
To stop the VM when your done working on the project do
```bash
    vagrant halt
```

### SSHing into the VM
The vm can be accessed via ssh by using
```bash
    vagrant ssh
```
### Destroying and rerunning the VM
This is only needed if the VM needs to be reprovisioned or if somethings really gone wrong.
```bash
    vagrant destroy
```
The to rebuild and restart the VM do
```bash
    vagrant up
```

