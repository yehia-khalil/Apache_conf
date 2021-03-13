#!bin/bash
ROOTDIRECTORY="/var/www/html/websites"
APACHECONF="/etc/apache2/sites-available"


function createFiles {
	echo $( mkdir ${ROOTDIRECTORY}/${1})
	echo $( echo ${1} >> ${ROOTDIRECTORY}/${1}/index.html)
}

function addConfFile {
	echo $(echo <enter password> | sudo -S echo "<VirtualHost *:80>" >> ${APACHECONF}/${1}.conf)
	echo $(echo <enter password> | sudo -S echo "	DocumentRoot ${ROOTDIRECTORY}/${1}" >>  ${APACHECONF}/${1}.conf)
	echo $(echo <enter password> | sudo -S echo "	ServerName ${1}" >> ${APACHECONF}/${1}.conf)
	echo $( echo <enter password> | sudo -S echo "</VirtualHost>" >> ${APACHECONF}/${1}.conf)

	echo $(echo <enter password> | sudo -S echo "<Directory ${ROOTDIRECTORY}/${1}>" >> ${APACHECONF}/${1}.conf)
	echo $(echo <enter password> | sudo -S echo "	Options ALL" >> ${APACHECONF}/${1}.conf)
	echo $(echo <enter password> | sudo -S echo "	AllowOverride All" >> ${APACHECONF}/${1}.conf)
	echo $(echo <enter password> | sudo -S echo "</Directory>" >> ${APACHECONF}/${1}.conf)
}

function addToHosts {

	echo $(echo <enter password> | sudo -S echo "127.0.0.1	${1}" >> /etc/hosts)
	echo $(echo "127.0.0.1        ${1}" >> /mnt/c/windows/system32/drivers/etc/hosts)

}

function enableSite {
	echo $(echo <enter password> | sudo -S a2ensite ${1})
	echo $(echo <enter password> | sudo -S service apache2 restart)
}
function disableSite {
	echo $(echo <enter password> | sudo -S a2dissite ${1})
	echo $(echo <enter password> | sudo -S service apache2 restart)
}

function deleteSite {
	echo $(echo <enter password> | sudo -S rm -R ${ROOTDIRECTORY}/${1})
	echo $(echo <enter password> | sudo -S rm ${APACHECONF}/${1}.conf)
	echo $(echo <enter password> | sudo -S sed -i "/${1}/d" /etc/hosts)
	echo $(sed -i "/${1}/d" /mnt/c/windows/system32/drivers/etc/hosts)

}
function addAuth {
	echo $(echo <enter password> | sudo -S htpasswd -b /etc/.htpasswd ${1} ${2})
}

function addRequireAllGranted {
	echo $( echo "Require all granted" >> ${ROOTDIRECTORY}/${1}/.htaccess)
}

function addRestriction {
	echo $( echo "AuthType Basic" >> ${ROOTDIRECTORY}/${1}/.htaccess)
	echo $( echo "AuthName 'WELCOME USER'" >> ${ROOTDIRECTORY}/${1}/.htaccess)
	echo $( echo "AuthUserFile /etc/.htpasswd" >> ${ROOTDIRECTORY}/${1}/.htaccess)
	echo $( echo "Require valid-user" >> ${ROOTDIRECTORY}/${1}/.htaccess)
}
