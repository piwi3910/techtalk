First make a folder on your synology to hold the portainer data  
make sure you change the path /volume1/docker/portainer in the example to match yours.

open a putty connection to your synology login with admin user

now become root -> sudo su -

docker run -d -p 8000:8000 -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v /volume1/docker/portainer:/data portainer/portainer

after login open

http://ip_of_your_synology:9000
fill in the admin password that you choose now

select local and connect

go to settings -> endpoints and edit the local endpoint
set the public ip to the ip of your synology

