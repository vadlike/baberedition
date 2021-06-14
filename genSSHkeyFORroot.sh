cd

cd .ssh

rm authorized_keys

ssh-keygen -t rsa -b 4096

cat id_rsa.pub >> authorized_keys

chmod 0600 authorized_keys

rm -f id_rsa.pub && rm -f genSSHkeyFORroot.sh


