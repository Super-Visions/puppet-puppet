#!/bin/bash

# Set up puppet perms

if [ -d /etc/puppet ]
then
  find /etc/puppet -type f -exec chmod 0644 '{}' ';' 
  find /etc/puppet -type d -exec chmod 0755 '{}' ';' 
fi

if [ -d /etc/puppet/rack ]
then
  chown puppet /etc/puppet/rack/config.ru
fi

