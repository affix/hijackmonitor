from projectdiscovery/pdtm:latest

run pdtm -i nuclei 
run pdtm -i subfinder
run pdtm -i notify
run apk add -U bash

copy entrypoint.sh /entrypoint.sh
run chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]