#!/bin/bash
setfacl -R -m u:100007:rwx /opt/chromium
setfacl -R -m u:100007:rwx /home/$1/Downloads
setfacl -R -m u:100010:rwx /opt/okular
setfacl -R -m u:100013:rwx /home/$1/Pictures
setfacl -R -m u:100013:rwx /home/$1/Downloads
setfacl -R -m u:100013:rwx /opt/gwenview
setfacl -R -m u:100015:rwx /opt/filezilla
setfacl -R -m u:100019:rwx /opt/vs
setfacl -R -m u:100019:rwx /home/$1/Code
setfacl -R -m u:100021:rwx /home/$1/Downloads
setfacl -R -m u:100021:rwx /opt/tg
setfacl -R -m u:100027:rwx /opt/yt
setfacl -R -m u:100119:rwx /opt/keepass
setfacl -R -m u:1000:rwx /opt/
#setfacl -R -m u:100200:rwx /home/$1/mysql
chown -R 100200:100200 /home/$1/mysql

