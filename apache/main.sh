#!/bin/bash

ROOTDIRECTORY="/var/www/html/websites"
APACHECONF="/etc/apache2/sites-available"


#includes
source menucon.sh

source functions.sh

#function calls

displayMenu
runmenu
