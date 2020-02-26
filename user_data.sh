#/bin/#!/usr/bin/env bash
NEWUSER="<YOUR_USER>"
NEWUSERKEY="<YOUR_SSH_PUBLIC_KEY>"
adduser $NEWUSER
echo "$NEWUSER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
mkdir -p /home/$NEWUSER/.ssh
echo $NEWUSERKEY >> /home/$NEWUSER/.ssh/authorized_keys
chown -R $NEWUSER:$NEWUSER /home/$NEWUSER/.ssh
chmod 0700 /home/$NEWUSER/.ssh
chmod 0600 /home/$NEWUSER/.ssh/authorized_keys
