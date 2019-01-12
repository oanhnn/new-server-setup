#!/usr/bin/env bash

####################################################################
# Date: 08/16/2018
# Last Updated: 08/21/2018
#
# Linode stack script to configure and install a LEMP stack on a
# Debian based server.
#
# Compatible with:
#    - Ubuntu 18.04 LTS
#    - Debian 9
#
# Monitor progress by: tail -f /root/stackscript.log
##################################################################

# Redirect output of this script to our logfile
exec &> /root/stackscript.log

curl -o /root/debian-includes.sh -L https://raw.githubusercontent.com/rawilk/new-server-setup/master/stack-scripts/functions/debian-based/includes.sh

. /root/debian-includes.sh

print_info "Install Start"

basic_setup
harden_server
setup_ftp
install_nginx
setup_database
setup_php
setup_site

if [[ $SSL = 'yes' ]]; then
    install_ssl_cert
fi

install_utils
configure_firewall
cleanup
reboot_system