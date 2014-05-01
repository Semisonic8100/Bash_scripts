#!/bin/bash
# platops_ticketgen.sh
#
# Creates a PlatOps ticket and populates it with user input via the command line.  CURLs to Evo API to and posts ticket in BBC format.
# See Voxeo ticket [redacted] for the manual template.
#
# Changes:
# 2013-07-27 - JReid.  Added $UID check, cleaned up code, started testing.
# 2013-07-31 - JReid.  Prompts for Evo login creds and passes them over https.  title variable now sets thread title.
# 2013-09-20 - JReid.  Cleaned up code.

##ROOT_UID=0  Deprecated in favor of Evo login.
printf "Evolution account login: "
read account
printf "Evolution account password: "
read -s pass
printf "\r\nTitle of your issue: "
read title
printf "What is the issue?  What steps have you taken to resolve the issue?: "
read text
printf "Customers impacted?: "
read impact
printf "Customer Monthly Recurring Revenue Ranking, if known: "
read revenue
printf "Customer Priority [Urgent, high, medium, low, informational]: "
read priority
##  Evo API doesn't support setting actual ticket priority on initial post.  May be possible via looping through a second CURL that uses update parameters to add the necessary tags.  See [redacted] for details.
printf "Customer dates or expectations, if any: "
read date
printf "Servers impacted: "
read server
printf "Was it working prior to this ticket? [Yes/No]: "
read working
printf "Specific alert or error that prompted this ticket: "
read alert
printf "Timestamp when issue occurred: "
read timestamp
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
printf "Is the following correct? \n ===================================== \n Issue: $text\nCustomers impacted: $impact\nCustomer monthly recurring revenue ranking: $revenue\nCustomer Priority: $priority\nCustomer dates or expectations: $date\nServers impacted: $server\nWas it working prior to this ticket?: $working\nSpecific alert or error that prompted this ticket: $alert\nTimestamp when issue occurred: $timestamp\n ===================================== \n Enter \"yes\" to post, \"no\" to exit: "
read correct
if [ "$correct" == "yes" ] || [ "$correct" == "y" ]  ## Checks value of $correct.  "yes" or "y" to proceed, else exits.
then
	printf -v post "[h1]$title[/h1]\r\n$text\r\n\r\n[b]Customers impacted:[/b] $impact\r\n[b]Customer monthly recurring revenue ranking:[/b] $revenue\r\n[b]Customer dates or expectations:[/b] $date\n[b]Servers impacted:[/b] $server\r\n[b]Was it working prior to this ticket?:[/b] $working\r\n[b]Specific alert or error that prompted this ticket:[/b] $alert\r\n[b]Timestamp when issue occurred:[/b] $timestamp\r\n\r\n"
	curl -XPOST "[redacted]" -d "username=$account&password=$pass&action=post&subject=$title" --data-urlencode "message=$post" -d "ownerAccountID=[redacted]&categoryID=[redacted]"
else
	printf "\r\nAborting script.  Thank you, come again.\r\n"
fi
exit