#!/bin/bash

set -x

# read usersInfo.sh file
export SSH_USER="manohar"
export authorised_keys="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDPC9jQrUGBVIartv4KTWGtMONIeDYEqv3B7XU531+ebyyasn6Gy9S8mekLWBPA4xmeBO1Uhm7NpqkJbe17O47wUyx6IQgTacfK5zg+DU9iZMKLDU0rL8FKyFr33zJlVBg4fCXKkH212Km/vsSIZCJsbW9gul19tAiQoxf+sv+teSfxz7arSciUF2AfFROrqx9JkjrrkLPdSMaoB6AVbIZa7cXuOGTkkHhyWl0PNEQY46Hy0LvTwhZ96yqreokIeU40h0mY44gCLKYKhiP7EYDozCTtaV1Q7ZReaKSSunqTHTncdNuJDQ3pCmTsWot3KOJqilEURlqGc8mufIIwFkJDlL6nDEB5UXeuZsiwt//1/1daWUqPbO0xyJXEiR4li+OSPVmb4oY7fsuIRmh61UjJlEzuNNVtyhXwGC05j30A/7GBdcpdA7ixq//SxEvESpNczTbh7KqcQdTvkyJlcTTKISfKvc+CTI5Ex4N+Ch7R1RzT4HiWvs1N43137ozJnMM= manohar@manohars-MacBook-Pro.local"
export USER_ID=1117
export SSH_PASSWORD="reset123"

service ssh start

# adduser $SSH_USER --disabled-password
useradd -rm -d /home/$SSH_USER -s /bin/bash -g root -G sudo -u $USER_ID $SSH_USER
echo $SSH_USER:$SSH_PASSWORD | chpasswd
su - $SSH_USER

NEW_USER_HOME=$(grep "${SSH_USER}" /etc/passwd | awk -F: '{print $6}')
mkdir -p ${NEW_USER_HOME}/.ssh
chmod 700 ${NEW_USER_HOME}/.ssh
chown -R ${SSH_USER}:root /home/${SSH_USER}

touch ${NEW_USER_HOME}/.ssh/authorized_keys

# chmod 600 .ssh/authorized_keys
echo $authorised_keys >> ${NEW_USER_HOME}/.ssh/authorized_keys

echo "tailing ssh logs"
tail -f /var/log/alternatives.log
