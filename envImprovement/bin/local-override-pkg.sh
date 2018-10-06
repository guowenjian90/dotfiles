file=$1
host=$2
pkg=$3

ssh $host "mkdir -p /home/wenjian/local-overrides/$pkg; rm -rf /home/wenjian/local-overrides/$pkg/*"
scp $file $host:/home/wenjian/local-overrides/$pkg/
ssh $host "cd /home/wenjian/local-overrides/$pkg; tar xvf $file; rm $file"
