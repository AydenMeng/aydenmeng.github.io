mkdir -p ../../../static/img/cs/$2/$1
grep png -rn $1.md  | grep -o  "http.*png" | xargs -I N wget N -P ../../../static/img/cs/$2/$1
sed -i "s/https:\/\/gitee.*\//\/img\/cs\/$2\/$1\//g" $1.md
