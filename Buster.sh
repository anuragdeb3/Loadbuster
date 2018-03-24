#!/bin/bash

# Define executeEngine function here

Forg_set_colors()
{
     NORMAL="\033[0m"
     RED="\033[31m"
     GREEN="\033[32m"
     BROWN="\033[33m"
     YELLOW="\033[33;1m"
     BLUE="\033[34m"
     MAGENTA="\033[35m"
     PINK="\033[35;1m"
     CYAN="\033[36m"
     WHITE="\033[37m"
     BOLD="\033[1m"
     UNDERLINE='\033[4m'
}

ExecuteEngine () {
   #wsdl listing
   printf "Store your WSDL file in LoadBuster/wsdl"

   printf "\nEnter your wsdl file name\n"
   read wsdl_name
   if [ -f wsdl/"$wsdl_name" ]; then 
      awk '/<wsdl:operation name/' wsdl/$wsdl_name | grep -v "<!--" | awk -F'"' '$0=$2' > logs/listRequest
      if [ -f logs/listRequest ];then
          sed -n '/<soapenv:Body>/,/<\/soapenv:Body>/p' wsdl/"$wsdl_name" > logs/RequestStore
          switch_options
      fi   
   else
      printf $RED
      printf $BOLD
      printf "Invalid File Name. Copy file to LoadBuster/wsdl and try again\n"
      printf $NORMAL
  fi

}

List (){
printf "Choose your request\n"
printf "Give a pattern like country\n"
cd logs/
read choose_req
grep -i $choose_req listRequest 
printf "Give the name of request you want from above list"
read choice


}


ExitTool(){

exit
}


switch_options ()
{
printf "1. Setup\n"
printf "2. Data Provisioning\n"
printf "3. Load\n"
printf "4. Exit\n"
read option 
case ${option} in 
   1) ExecuteEngine
      
      ExitTool
      ;; 
   2) List
      ;; 
   3) Load
      ;; 
   4) ExitTool
      ;;       
   *) printf $RED
      printf "Invalid Input\n"
      printf $NORMAL
      ;;
esac 
}

#setting colors
Forg_set_colors
# This will clear the screen before displaying the menu.
clear
printf $YELLOW
printf "\n\n*********************************************************\n"
printf "***************"
printf $CYAN 
printf "WELCOME TO LOAD BUSTER TOOL"
printf $YELLOW
printf "***************\n"
printf "*********************************************************\n\n"
printf $NORMAL  

printf "Kindly Choose your Need "
printf $RED
printf "\nInstall through SetUp Option before Provisioning or Load."  
printf $NORMAL  
printf "\n" 
switch_options
