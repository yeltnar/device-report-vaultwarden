#!/bin/bash

PATH="/usr/local/bin:/sbin:/usr/bin:/bin:/snap/bin"

passwordfile="$bashrc_folder/gitignore/passwordfile"
outfile="$bashrc_folder/gitignore/BW_SESSION"
email="$(cat $bashrc_folder/gitignore/email)"

bw logout
bw login $email --passwordfile "$passwordfile" --raw > "$outfile"  

printf "$outfile\n"

