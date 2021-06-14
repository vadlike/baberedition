cd

mkdir1 .ssh

chmod 700 .ssh

cd .ssh

rm authorized_keys

ssh-keygen -t rsa -b 4096

wait 2

cat id_rsa.pub > authorized_keys

chmod 0600 authorized_keys

rm -f id_rsa.pub && rm -f genSSHkey.sh

mv id_rsa movemetoyourspcpls

chmod 0664 movemetoyourspcpls
