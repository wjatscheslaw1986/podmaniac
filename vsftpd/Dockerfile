FROM docker.io/library/debian:latest 

ARG GROUP_ID=9898
ARG USER_ID=9898
ARG USR
ARG PSWRD

RUN if [ -z "$USR" ] || [ -z "$PSWRD" ]; then (echo "Error: both USR and PSWRD parameters must be defined" && exit 1); else echo Username is $USR ; fi

RUN apt update && apt upgrade -y \
    && apt install -y bash vsftpd libpam-pwdfile \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd -g $GROUP_ID $USR \
    && useradd -m --gid $GROUP_ID -u $USER_ID $USR \
    && chown --recursive $USR:$USR /home/$USR

RUN usermod -aG ftp $USR
RUN usermod -aG ftpuser $USR

RUN chown root:root /etc/passwd
RUN chown root:root /etc/shadow
RUN usermod --password $(openssl passwd -1 $PSWRD ) $USR

COPY docker_files/vsftpd.conf /etc/vsftpd.conf

RUN mkdir -p /home/$USR/ftp/ftp && mkdir /home/$USR/ftp/chroot
RUN chmod 550 /home/$USR/ftp
RUN chmod 750 /home/$USR/ftp/ftp
RUN chmod -R 550 /home/$USR/ftp/chroot
RUN chown -R $USR:$USR /home/$USR/ftp

RUN openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout /opt/vsftpd.key -out /opt/vsftpd.crt -subj "/C=RU/ST=Sankt-Peterburg/L=Sankt-Peterburg/O=NA/OU=NA/CN=NA"

RUN chmod 555 /opt/vsftpd.crt
RUN chmod 555 /opt/vsftpd.key
RUN chown -R $USER_ID:ftp /opt

EXPOSE 20/tcp
EXPOSE 21/tcp
EXPOSE 21100-21110/tcp

RUN echo "vsftpd: ALL" | tee -a /etc/hosts.allow

CMD ["/usr/sbin/vsftpd", "/etc/vsftpd.conf"]
