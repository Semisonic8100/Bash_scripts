#!/bin/bash
# route_away_tool.sh
#
# Edits [redacted] to remove sipproxy and api entries
#
# Changes:
# 2013-10-12 - JReid.

printf "Warning: This script edits ~/repo/[redacted] to remove all entries for one US site.  Check your diffs before committing!

printf "Which site do you want to route away from? [ORL or LAS]\r\n"
read site
site=$(echo ${site} | tr '[:upper:]' '[:lower:]')
if [ "site" == "orl" ] || [ "site" == "orlando" ]
then
	egrep -v '^;|\-atl\-' voxeo.net | sed -i -e '/[sip-prod|sbc-external]*([redacted IP ranges]|[redacted IP ranges])/ s/^/;/' -e '/(^secureapi.*[redacted IP ranges]|^api.*[redacted IP ranges])/ s/^/;/' [redacted filename]

elif [ "site" == "las" ] || [ "colo" == "las vegas" ]
	egrep -v '^;|\-atl\-' voxeo.net | sed -i -e '/[sip-prod|sbc-external]*([redacted IP ranges]|[redacted IP ranges])/ s/^/;/' -e '/(^secureapi.*[redacted IP ranges]|^api.*[redacted IP ranges])/ s/^/;/' [redacted filename]
else 
	printf "That site is not supported.  Exiting..."
fi
exit
