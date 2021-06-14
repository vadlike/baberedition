#disable systemd-logind и getty

systemctl disable getty@tty1

systemctl disable getty-static

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

reboot
