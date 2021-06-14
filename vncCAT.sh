#disable systemd-logind и getty

systemctl disable getty@tty1

systemctl disable getty-static

#add only this text
echo "NAutoVTs=0
ReserveVT=0" > /etc/systemd/logind.conf

#add Nyan cat

apt-get install nyancat -y


echo "[Unit]
Description=nyancat on tty1
After=graphical.target

[Service]
Type=simple
ExecStartPre=/bin/sleep 5
ExecStart=/usr/bin/nyancat -snI
ExecStop=/bin/kill -HUP ${MAINPID}
StandardInput=tty
StandardOutput=tty
TTYPath=/dev/tty1
Restart=always
RestartSec=2

[Install]
WantedBy=graphical.target" > /etc/systemd/system/nyancat-tty.service

systemctl enable nyancat-tty.service

# additional 
# create service from isden hubr
systemctl mask getty\@tty1

#replase
sed -i 's/ACTIVE/#ACTIVE/' /etc/default/console-setup 

#add text
echo 'ACTIVE_CONSOLES="/dev/tty1"' >> /etc/default/console-setup 

#add text
echo '-:ALL:tty1' >> /etc/security/access.conf

#add text
echo 'account  required       pam_access.so' >> /etc/pam.d/login

reboot
