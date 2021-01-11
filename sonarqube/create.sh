#!/bin/bash

trace() {
    echo -e "\n>>> $@ ...\n"
}

error() {
    echo "Error: $@" 1>&2
}

# get the default runner script path to execute first before adding custom stuff
SCRIPT="$(find /docker-runner.d -maxdepth 1 -iname "$(basename "$0")")"

# isolate task script execution in sub shell  
( exec "$SCRIPT"; exit $? ) || exit $?

SQHOSTNAME="$(az webapp list --subscription $ComponentSubscription -g "$ComponentResourceGroup" --query "[0].defaultHostName" -o tsv)"

trace "Initializing SonarQube database"
while [ "$(curl -s https://$SQHOSTNAME/api/system/status | jq '.status' | tr -d '"')" != "UP" ]; do
    SQHOSTSTATUS="$(curl -s https://$SQHOSTNAME/api/system/status | jq '.status' | tr -d '"')"
    [ "$SQHOSTSTATUR" == "UP" ] && { echo -e '\n'; break } || { echo -n '.'; sleep 5 }
done

SQADMINUSERNAME="admin"
SQADMINPASSWORD="$( echo "$ComponentTemplateParameters" | jq --raw-output '.adminPassword' )"
SQADMINTOKEN=$(curl -s -u $SONARQUBE_ADMIN_USER:$SONARQUBE_ADMIN_USER -X POST "https://$SQHOSTNAME/api/user_tokens/generate?name=Configure" | jq .token | tr -d '"')

trace "Configuring SonarQube users"
curl -s -u $SQADMINTOKEN: --data-urlencode "password=$SQADMINPASSWORD" -X POST "http://localhost:9000/api/users/change_password?login=$SQADMINUSERNAME&previousPassword=$SQADMINUSERNAME"
curl -s -u $SQADMINTOKEN: -X POST 'http://localhost:9000/api/settings/set?key=sonar.forceAuthentication&value=true'
