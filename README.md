# freertr-docker
A basic FreerTr docker container

## Prerequisite
0- Install docker on Dockerhost with the method of your choice
1- Make sure that docker the container inherit from docker host DNS configuration
   Check this by issuing: 
   sudo docker run busybox nslookup www.google.com
   
## How to build freerTr container
git clone https://github.com/frederic-loui/freertr-docker.git
cd ./freertr-docker
sudo docker build --tag freertr/freertr:latest .

## How to configure FreerTr before running the container
There are 2 files in ./freertr-docker/run :
./freertr-hw.txt  
./freertr-sw.txt

These files are in the format <freerouter-hostname>-hw.txt and <freerouter-hostname>-sw.txt

As a start use the sample provided and replace eth2 by your NIC device (usually eth0)

freertr-hw.txt:
In this sample file you'll indicate which Dockerhost interface will be bind to FreerTr container.
The line use to attach an interface to FreerTr container is:
int <network-device> eth <mac@> <bind_ip@> <tx_port> <bind_ip@> <rx_port>
...
int eth2 eth 0000.1111.2222 127.0.0.1 22706 127.0.0.1 22705
int eth3 eth 0000.1111.3333 127.0.0.1 20011 127.0.0.1 20010
...

For more detail please refer to FreerTr homepage: http://freerouter.nop.hu/

freertr-sw.txt
is the FreerTr router configuration. 
For more detail please refer to FreerTr homepage: http://freerouter.nop.hu/

## How to run FreerTr container
There is 2 processes that is run inside this container:
1- A "control plane" process: This process is written in Java and can be run in user space
2- A "data plane" process: This process is written in C run in kernel space and need thus more priviledges
=> This explain why we use --privileged flag. In addition

In addition FreerTr will manipulate the network interface attached to it.
=> This explain why we use --network host flag. In addition

sudo docker run --detach --privileged --network host -e "FREERTR_INTF_LIST=eth2/20010/20011" -e "FREERTR_HOSTNAME=freertr" -v "/home/kubeadm/freertr/run:/opt/freertr/run" --name freertr-001 freertr/freertr:latest 

## Acknowledgement
I would like to thank Casba Mate original maintainer of FreerTr for this awesome piece of code. 
If you need to understand networking protocol. Read the source, it is exceptionnally well written. If you like reading IETF RFCs you will enfoy stufying this code. 

Kudos to <a href=http://mc36.nop.hu/cv.html>Csaba</a>, all credits goes to him.
