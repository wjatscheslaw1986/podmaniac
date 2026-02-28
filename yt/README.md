In order to log in to YouTube, you have to provide cookies. You need two folder for this:


sudo rm -R /opt/yt/.mozilla && sudo mkdir -p /opt/yt/.mozilla/firefox && sudo cp -r ~/.mozilla/firefox/* /opt/yt/.mozilla/firefox/ && sudo chown -R pod_yt:pod_yt /opt/yt/.mozilla 

sudo rm -R /opt/yt/.cache/* && sudo mkdir -p /opt/yt/.cache/mozilla/firefox && sudo cp -r .cache/mozilla/firefox/* /opt/yt/.cache/mozilla/firefox && sudo chown -R pod_yt:pod_yt /opt/yt/.cache


Inside the folder you will find you current freshly updated (just after the log out-log in) cache:
$ ls -hal .mozilla/firefox/
drwx------ 14 vaclav vaclav 4.0K Feb  1 21:08  xz4ilrmo.default-esr


Spot the name - it is the name you will fetch as a parameter:
--cookies-from-browser firefox:xz4ilrmo.default-esr
