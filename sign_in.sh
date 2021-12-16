#!/bin/bash

passwordfile="gitignore/passwordfile"
outfile="./gitignore/BW_SESSION"

bw login $email --passwordfile "$passwordfile" --raw > "$outfile" 

printf "$outfile\n"

