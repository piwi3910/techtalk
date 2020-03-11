First make a folder on your synology to hold the portainer_agent data  
make sure you change the path /volume1/docker/portainer_agent in the example to match yours.

got to your existing external portainer server
go to settings -> endpoints
and add a new endpoint

select the edge agent
and fill in a name for your docker on synology

you will see a command like this:

docker run -d -v /var/run/docker.sock:/var/run/docker.sock \
              -v /var/lib/docker/volumes:/var/lib/docker/volumes \
              -v /:/host \
              --restart always \
              -e EDGE=1 \
              -e EDGE_ID=629105b1-5c93-4a79-a92b-885bebcde3cb \
              -e EDGE_KEY=aHR0cDovLzE5Mi4xNjguMTAuMTc6OTAwMHwxOTIuMTY4LjEwLjE3OjgwMDB8YTA6Y2E6YmU6MTE6Y2Q6NTQ6MWI6NWU6YWQ6NjA6YmI6ZDM6NTc6ZGY6MmU6ZmJ8Mw \
              -e CAP_HOST_MANAGEMENT=1 \
              -v portainer_agent_data:/data \
              --name portainer_edge_agent \
              portainer/agent

change the line -v portainer_agent_data:/data \
to
the synology folder you made like:

-v /volume1/docker/portainer_agent:/data \

and change the line -v /var/lib/docker/volumes:/var/lib/docker/volumes \
to
-v /volume1/@docker/volumes:/var/lib/docker/volumes \



and deploy



