#!/bin/bash

passwordfile="gitignore/passwordfile"
outfile="./gitignore/BW_SESSION"
email="$(cat ./gitignore/email)"

bw logout
bw login $email --passwordfile "$passwordfile" --raw > "$outfile"  

printf "$outfile\n"

