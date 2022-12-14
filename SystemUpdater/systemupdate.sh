# Requirements:
#  - Run script as root
#  - /opt directory created
#  - jagubox mirror stored in /opt
#
# e.g. /opt/jagubox
#      /opt/jagubox/AA.new_files
#      /opt/jagubox/Apple.fixes

clear
echo "***********************************************"
echo "*   A/UX 3.1.1 Jagubox System Update Script   *"
echo "***********************************************"
echo ""
echo "This script applies updates and *essential*"
echo "features to your base A/UX 3.1.1 installation."
echo ""
echo "            To Be Installed:"
echo "            ----------------"
echo " * gzip      * traceroute"
echo " * unzip"
echo " * pstree"
echo ""
echo "Would you like to proceed? case-sensitive [y/n]"
read ans

if [ $ans = "y" ]

then
    if [ -d /opt ]

    then
        if [ -d /opt/jagubox ]

        then
            clear
            # Installing Utilities
            # --------------------

            echo "Installing Utilities"
            echo "--------------------"
            echo ""

            # Install gzip
            echo ""
            echo "Installing gzip:"
            echo ""

            mkdir /tmp/gzip
            cp /opt/jagubox/Utilities/gzip-124.bin.tar.Z /tmp/gzip
            cd /tmp/gzip
            zcat /tmp/gzip/gzip-124.bin.tar.Z | tar -xvf -
            rm /tmp/gzip/gzip-124.bin.tar.Z
            cp /tmp/gzip/* /usr/bin
            rm -r /tmp/gzip

            # Install unzip
            echo ""
            echo "Installing unzip"
            echo ""

            mkdir /tmp/unzip
            cp /opt/jagubox/Utilities/unzip.tar.gz /tmp/unzip
            cd /tmp/unzip
            gzip -dc unzip.tar.gz | tar xvfmo -
            cp /tmp/unzip/unzip/unzip /usr/bin
            rm -r /tmp/unzip

            # Install pstree
            echo ""
            echo "Installing pstree:"
            echo ""

            mkdir /tmp/pstree
            cp /opt/jagubox/Utilities/pstree.bin.tar.gz /tmp/pstree
            cd /tmp/pstree
            gzip -dc pstree.bin.tar.gz | tar xvfmo -
            cp /tmp/pstree/pstree /usr/bin
            rm -r /tmp/pstree

            # Installing Sys_stuff
            # --------------------
            echo ""
            echo "Installing Sys_stuff"
            echo "--------------------"

            # Install bash
            echo ""
            echo "Installing Bash 1.14.2"
            echo ""

            mkdir /tmp/bash
            cp /opt/jagubox/GNU_stuff/bash-aux.bin.tar.gz /tmp/bash
            cd /tmp/bash
            gzip -dc bash-aux.bin.tar.gz | tar xvfmo -
            cp /tmp/bash/bash-aux/bash /bin
            rm -r /tmp/bash

            # Install Pico/Nano with symlink for nano because muscle memory is a thing
            echo ""
            echo "Installing Pico/Nano"
            echo ""

            mkdir /tmp/pine
            cp /opt/jagubox/Utilities/pine-3.95-aux.tar.gz /tmp/pine
            cd /tmp/pine
            gzip -dc pine-3.95-aux.bin.tar.gz | tar xvfmo -
            cp /tmp/pine/pine-3.95-aux/bin/pico /usr/bin
            ln -s /usr/bin/pico /usr/bin/nano
            rm -r /tmp/pine

            # Install GNUmake
            echo ""
            echo "Installing GNUmake-3.74"
            echo ""
            mkdir /tmp/GNUmake
            cp /opt/jagubox/GNU_stuff/GNUmake-3.74.tar.gz /tmp/GNUmake/
            cd /tmp/GNUmake
            gzip -dc GNUmake-3.74.tar.gz | tar xvfmo -
            cp /tmp/GNUmake/make-3.74/GNUmake /usr/bin

            # Update Telnet client/server
            echo ""
            echo "Updating telnet client and server"
            echo ""

            mkdir /tmp/telnet
            cp /opt/jagubox/Sys_stuff/telnet-aux.tar.gz /tmp/telnet
            cd /tmp/telnet
            gzip -dc telnet-aux.tar.gz | tar xvfmo -
            mkdir /opt/backups
            mkdir /opt/backups/telnet
            mkdir /opt/backups/telnet/usr
            mkdir /opt/backups/telnet/usr/bin
            mkdir /opt/backups/telnet/usr/etc
            mv /usr/bin/telnet /opt/backups/telnet/usr/bin
            mv /usr/etc/in.telnetd /opt/backups/telnet/usr/etc
            cp /tmp/telnet/telnet_src/AUX-bins/in.telnetd /usr/etc
            cp /tmp/telnet/telnet_src/AUX-bins/telnet /usr/bin
            rm -r /tmp/telnet

            # Update inetd
            echo ""
            echo "Updating inetd to 1.9"
            echo ""

            mkdir /tmp/inetd
            cp /opt/jagubox/AA.new_files/inetd-1.9.tar.gz /tmp/inetd
            cd /tmp/inetd
            gzip -dc inetd-1.9.tar.gz | tar xvfmo -
            # Backup inetd
            mkdir /opt/backups/etc
            mv /etc/inetd /opt/backups/etc
            cp /tmp/inetd/inetd_src/inetd /etc/inetd
            rm -r /tmp/inetd

            # Install traceroute
            echo ""
            echo "Installing traceroute:"
            echo ""

            mkdir /tmp/traceroute
            cp /opt/jagubox/Sys_stuff/traceroute-aux.tar.gz /tmp/traceroute
            cd /tmp/traceroute
            gzip -dc traceroute-aux.tar.gz | tar xvfmo -
            cp /tmp/traceroute/traceroute-aux/traceroute_src/traceroute /usr/bin
            
            # Install Ntraceroute
            echo ""
            echo "Installing Ntraceroute:"
            echo ""

            cp /tmp/traceroute/traceroute-aux/Ntraceroute_src/Ntraceroute /usr/bin
            
            # *************
            # DO THIS LAST!!!!!

            # Update bnet driver
            echo ""
            echo "Updating bnet driver"
            echo ""
            
            # Backup running bnet driver
            
            mkdir /opt/backups/etc/boot.d
            mv /etc/boot.d/bnet /opt/backups/etc/boot.d
            
            # Install new bnet driver
            cp /tmp/traceroute/traceroute-aux/bnet-3.1/bnet /etc/boot.d
            
            # Perform cleanup
            rm -r /tmp/traceroute
            
            # Execute newconfig to rebuild kernel
            newconfig
        else
            echo ""
            echo "ERROR: You have not placed the jagubox files in /opt/jagubox. Exiting"
            exit 1
        fi
    else
        echo ""
        echo "ERROR: You have not created the /opt directory. Exiting"
        exit 1
    fi



    


else
    exit 0
fi