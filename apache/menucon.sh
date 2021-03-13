#!/bin/bash
function displayMenu {
echo " "
echo "----------"
echo "1-New host"
echo "2-Display hosts"
echo "3-Delete Hosts"
echo "4-Disable Host"
echo "5-Enable Host"
echo "6-Exit"
echo " "
echo "Choose an action"

}

function runmenu {
local num
local FLAG=1
while [ ${FLAG} -eq 1 ]
do
read num
case ${num} in
	"1")
		read -p "Please enter the desired website name: " WEBSITE

		read -p "Do you want to add Authentication to ur website? [y/n]" ANS
			if [[ -d ${ROOTDIRECTORY}/${WEBSITE} && -f ${ROOTDIRECTORY}/${WEBSITE}/index.html ]]
			then
				echo "Name already taken"
			else
				{
					if [ ${ANS} == "y" ]
					then
						read -p "Please enter your UserName: " USRNAME
						read -p "Please enter your Password: " PASSWD
						read -p "Please re-enter your Password: " REPASSWD
							if [ ${PASSWD} == ${REPASSWD} ]
								then
									echo "Passwords Match"
									addAuth ${USRNAME} ${PASSWD}
									createFiles ${WEBSITE}
									addRestriction ${WEBSITE}
                                					if [ ! -f ${APACHECONF}/${WEBSITE}.conf ]
                                        				then
                                        					addConfFile ${WEBSITE}
                                        				else
                                        					echo "Conf File already exists"
                                					fi
                                        				enableSite ${WEBSITE}
                                        				addToHosts ${WEBSITE}
                                        				echo "Created Successfully"

								else
									echo "Passwords dont match"
							fi

					else

					createFiles ${WEBSITE}
					addRequireAllGranted ${WEBSITE}
				if [ ! -f ${APACHECONF}/${WEBSITE}.conf ]
					then
					addConfFile ${WEBSITE}
					else
					echo "Conf File already exists"
				fi
					enableSite ${WEBSITE}
					addToHosts ${WEBSITE}
					echo "Created Successfully"
					fi
				}
			fi
				;;
	"2")
		VAL=$(ls /var/www/html/websites | grep "\.com$" | wc -w )
		if [ ${VAL} -eq 0 ]
		then
			echo "No hosts found"
		else
			echo "There are ${VAL} hosts available "
			echo $(ls /var/www/html/websites | grep "\.com$")
		fi
		;;
	"3")
		read -p "Please enter the site name you want to delete: " WEBSITE
		VAL=$(ls /var/www/html/websites | grep "${WEBSITE}$" | wc -w )
                if [ ${VAL} -eq 0 ]
                then
                        echo "Website doesnt exist"
                else
			deleteSite ${WEBSITE}
			echo "Successfully deleted"
		fi
		;;
	"4")
		read -p "Please enter the name of the website you want to disable: " WEBSITE
		VAL=$(ls /var/www/html/websites | grep "${WEBSITE}$" | wc -w )
		if [ ${VAL} -eq 0 ]
		then
			echo "Website doesnt exist"
		else
			disableSite ${WEBSITE}
			echo "Website disabled Successfuly"
		fi
		;;
	"5")
		read -p "Please enter the name of the website you want to enable: " WEBSITE
		VAL=$(ls /var/www/html/websites | grep "${WEBSITE}$" | wc -w )
                if [ ${VAL} -eq 0 ]
                then
                        echo "Website doesnt exist"
                else
			enableSite ${WEBSITE}
		fi
		;;
	"6")
		echo "Bye."
		FLAG=0
		echo ${FLAG}
		;;
	*)
		echo "Please choose a valid option"
		;;
esac
if [ ${FLAG} -eq 1 ]
	then
		displayMenu
	fi
done


}
