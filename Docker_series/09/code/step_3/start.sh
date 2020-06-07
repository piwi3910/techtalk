#!/bin/bash
# -----------------------------------------------------------------------------
# minecraft /start.sh script
# -----------------------------------------------------------------------------

if [ ! -f /srv/eula.txt ]
then
    echo "eula=true" > /srv/eula.txt
fi

cd /srv/ && java -Xms1024M -Xmx1024M -jar server.jar nogui