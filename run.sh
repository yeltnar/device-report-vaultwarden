#!/bin/bash

PATH="/usr/local/bin:/sbin:/usr/bin:/bin:/snap/bin"

pub_ip=$(curl https://digitalocean.andbrant.com);
lan_ip="$(ifconfig | awk '/192\.168/{print $2}')";
nebula_ip=$(ifconfig | awk '/10\.10\.10/{print $2}');
git_branch=$(git rev-parse HEAD)

date="$(date)"

new_content="{ \
    \"pub_ip\":\"$pub_ip\", \
    \"lan_ip\":\"$lan_ip\", \
    \"nebula_ip\":\"$nebula_ip\", \
    \"date\":\"$date\", \
    \"git_branch\":\"$git_branch\" \
}"

echo $new_content | jq

note_name="$(cat $bashrc_folder/gitignore/note_name)";
email="$(cat $bashrc_folder/gitignore/email)"
passwordfile="$bashrc_folder/gitignore/passwordfile"
organizationid="$(cat $bashrc_folder/gitignore/organizationid)"

export BW_SESSION="$(cat $bashrc_folder/gitignore/BW_SESSION)"

json=$(bw get item $note_name --organizationid $organizationid) 

#echo $json | jq

item_id=$(echo $json | jq .id -r)
revisionDate=$(echo $json | jq .revisionDate -r)

json=$(echo $json | jq --arg new_content "$new_content" '.notes =  $new_content')

echo $json | base64 | bw edit item $item_id --organizationid $organizationid | jq .revisionDate

echo "upload done"
