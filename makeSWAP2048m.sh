apt-get update -y && apt-get upgrade -y
apt install -y sudo                                                    
sudo swapon -s                                                           #check swap file
free -h                                                                  #check swap file
sudo fallocate -l 2048M /root/swapfile                                   #make swap
ls -lh /root/swapfile                                                    #check file of swap
sudo chmod 600 /root/swapfile                                            #permission
sudo mkswap /root/swapfile                                               #mount in swap
sudo swapon /root/swapfile                                               #connect swap
sudo swapon -s                                                           #check swap
sudo nano /etc/fstab                                                     #add in autorun
echo '/root/swapfile   none    swap    sw    0   0' >> /etc/fstab        #pastle this text
reboot



