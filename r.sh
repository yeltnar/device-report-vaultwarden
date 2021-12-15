bw logout

export BW_SESSION="$(bw login work-mac@andbrant.com --passwordfile ~/tmp/vaultwarden-playin/passwordfile --raw)"

json=$(bw get item test --organizationid 096ae60e-71c4-4497-a0c1-d399e6d4d696) 

echo $json

item_id=$(echo $json | jq .id -r)
echo $item_id

new_content="new_content"

json=$(echo $json | jq --arg new_content $new_content '.notes =  $new_content')

echo $json | base64 
echo $json | base64 | bw edit item $item_id --organizationid 096ae60e-71c4-4497-a0c1-d399e6d4d696  

