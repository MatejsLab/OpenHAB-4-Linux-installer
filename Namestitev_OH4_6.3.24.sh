#!/bin/bash

#Script for installing openhab 4
echo 'My OH installer 4.0 / 6.3.24'

echo '
Script for installing OpenHAB 4, writen by Matej, based on OpenHAB docs. 
       
 Installing:
            * Java 17 
            * OpenHAB 4 
            * permissions (755) on [/etc/openhab]. 


 DISCLAIMER ! * I don*t take responsibility for issues!

              * Have a BACKUP of your data and system. 

              * First, TEST on non-critical systems like VM or LAB PC.


              * Runs only on APT Linux (Debian/Ubuntu). 
              * Tested on Debian 12. 
'

                                
                                


read -p "Press Enter to continue..."

java -version
lsb_release -a
echo ''
echo 'Installing Java 17'
sleep 2
sudo apt install openjdk-17-jre

echo ''
echo 'You need to select Java 17 now, by typing the selection number'
sleep 2
sudo update-alternatives --config java

echo ''
echo 'Loading OH repository'
sleep 2
sudo apt update
curl -fsSL "https://openhab.jfrog.io/artifactory/api/gpg/key/public" | gpg --dearmor > openhab.gpg
sudo mkdir /usr/share/keyrings
sudo mv openhab.gpg /usr/share/keyrings
sudo chmod u=rw,g=r,o=r /usr/share/keyrings/openhab.gpg
echo 'deb [signed-by=/usr/share/keyrings/openhab.gpg] https://openhab.jfrog.io/artifactory/openhab-linuxpkg stable main' | sudo tee /etc/apt/sources.list.d/openhab.list


sudo apt-get update
echo ''
echo 'OpenHAB is now installing'
sleep 2
sudo apt-get install openhab
sudo apt autoremove

echo ''
echo 'OH config, edit permissions (/etc/openhab)'
sleep 2
cd /etc
echo 'before change'
ls -l | grep "openhab"
sudo chmod -R 755 openhab
echo 'after changed permisions'
ls -l | grep "openhab"
sleep 5

sudo systemctl start openhab.service | head -n 5
timeout 2 sudo systemctl status openhab.service | head -n 5

echo ''
echo 'OH config, enable OH autostart'
sleep 2
sudo systemctl daemon-reload
sudo systemctl enable openhab.service

echo ''
echo 'OH - INSTALL Finished'
sleep 2

echo ''
echo ''

echo "Reminder for OpenHAB CONFIG folder:

  ReApply ownership on copied config files, to be runnable by OpenHAB.
chown -R /etc/openhab openhab openhab  


  For remote VS Code work, set permissions to 755 (rwx,rx,rx) 
chmod -R 755 /etc/openhab   


  Set up Samba Share on folder [/etc/openhab] 
(https://pimylifeup.com/raspberry-pi-samba/).


  Use a strong Samba password to safeguard your system.
Use Samba Share only in a secured local network.


If any commands / informaions are misleading, ya wealcome to improve the script.
"
        
        

#service openhab restart  #- easy for manual restart
#service openhab status

read -p "Press Enter to exit..."


