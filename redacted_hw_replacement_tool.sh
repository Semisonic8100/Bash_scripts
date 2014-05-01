#!/bin/bash
# hw_replacement_tool.sh
#
# Creates, populates, and closes a Hardware Replacement ticket based on user input.
# See Voxeo #2014641 for the manual template.
#
# Changes:
# 2013-07-26 - JReid.  Added username check, cleaned up BBC formatting, and added auto-close.
# 2013-07-30 - Jreid.  Expanded comments.
# 2013-09-20 - JReid.  Added login over HTTPS using Evo creds.  Cleaned up code.

## ROOT_UID=0  Not necessary with root check disabled.

printf "Evolution account login: "
read account
printf "Evolution account password: "
read -s pass
printf "\r\nEnter Device Serial and press [Enter]: "  ## read -s doesn't automatically newline after input + enter.  Inserted \r\n here to compensate.
read device
printf "Component that needs replacement: "
read component
printf "Component model or serial number: "
read model_num
printf "In-service hours [if known]: "
read service_hours
printf "Associated ticket number: "
read ticket_num
## The following checks if user is root.  If not root, uses $USER variable to sign this form.  If root, prompts for first initial + last name.
##if [ "$UID" -eq "$ROOT_UID" ]
##then
##  printf "Enter your first initial and last name: "
##  read name
##else
##  printf "Signing form with user name for this account."
##  name=$USER
##fi
printf "\n"
##  The following printf gives the user a preview before posting and asks if the preview is correct.  Any response other than "yes" or "y" aborts the script.
printf "Is the following correct? \n ===================================== \n Device Serial: $device \n Component needing replacement: $component \n Component model number: $model_num \n In service hours: $service_hours \n Associated ticket number: $ticket_num \n Your name: $account \n ===================================== \n Enter \"yes\" to post, \"no\" to exit: "
read correct
printf "\r\n"
if [ "$correct" == "yes" ] || [ "$correct" == "y" ]  ## Checks $correct.  "yes" or "y" to proceed, anything else exits.
then
## The following places variables into formatted BBC code and saves in variable "post", which is then urlencoded and sent to the Evo API at [redacted] with flags that set the title and close the ticket.
	printf -v post "[h4]Hardware Subcomponent Replacement Tracking[/h4]\r\n[table][b]Device Serial:[/b],$device\r\n[b]Component that needs replacement:[/b],$component\r\n[b]Component model number:[/b],$model_num \r\n[b]Uptime/in-service hours:[/b],$service_hours \r\n[b]Associated ticket:[/b],[link=#$ticket_num]#$ticket_num[/link]\r\n[b]Completed by:[/b],$account\r\n[/table] \r\n"
	curl -XPOST "[redacted]" -d "username=$account&password=$pass&action=post-and-close&subject=Hardware+Subcomponent+Replacement+Tracking" --data-urlencode "message=$post" -d "ownerAccountID=[redacted]&categoryID=[redacted]"
else
	printf "\r\nAborting script.  Thank you, come again.\r\n\r\n"
fi
exit