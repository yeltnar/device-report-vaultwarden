#!/bin/bash

PATH="/usr/local/bin:/sbin:/usr/bin:/bin"

pub_ip=$(curl https://digitalocean.andbrant.com);
lan_ip="$(ifconfig | awk '/192\.168/{print}')";
nebula_ip=$(ifconfig | awk '/10\.10\.10/{print $2}');
git_branch=$(git rev-parse HEAD)

date="$(date)"

echo $pub_ip 
echo $lan_ip
echo $nebula_ip

new_content="{ \
    \"pub_ip\":\"$pub_ip\", \
    \"lan_ip\":\"$lan_ip\", \
    \"nebula_ip\":\"$nebula_ip\", \
    \"date\":\"$date\", \
    \"git_branch\":\"$git_branch\" \
}"

echo $new_content | jq

note_name="$(cat gitignore/note_name)";
email="$(cat gitignore/email)"
passwordfile="gitignore/passwordfile"
organizationid="$(cat gitignore/organizationid)"

export BW_SESSION="$(cat ./gitignore/BW_SESSION)"

json=$(bw get item $note_name --organizationid $organizationid) 

echo $json | jq

item_id=$(echo $json | jq .id -r)
revisionDate=$(echo $json | jq .revisionDate -r)
echo $revisionDate


json=$(echo $json | jq --arg new_content "$new_content" '.notes =  $new_content')

echo $json | base64 
echo $json | base64 | bw edit item $item_id --organizationid $organizationid

