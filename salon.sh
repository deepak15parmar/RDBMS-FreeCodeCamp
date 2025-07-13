#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"
echo -e "\n~~~~Billu Barber Salon~~~~"
MAIN_MENU() {

  #check for function argument
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi
  # Display the menu for user input
  echo -e "\nWelcome! How may I help you?\n"
  SERVICES_OFFERED=$($PSQL "select * from services;")
  echo "$SERVICES_OFFERED" | while read SERVICE_ID BAR SERVICE
  do
   echo "$SERVICE_ID) $SERVICE"
  done
  read SERVICE_ID_SELECTED
  # Validate input
  if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]
  then
    # Invalid input, redirect to main menu
    MAIN_MENU "Please enter a valid service number."
  else
      SCHEDULER
  fi
}
SCHEDULER(){
  # validate the selected service_id
  SELECTED_SERVICE=$($PSQL "select name from services where service_id=$SERVICE_ID_SELECTED;")
  if [[ -z $SELECTED_SERVICE ]]
  then
    MAIN_MENU "Please enter a valid service number."
  else
    # Valid input, redirect to scheduler
      echo -e "\nWhat's your phone number?"
      read CUSTOMER_PHONE

      # check if customer exists
      CUSTOMER_NAME=$($PSQL "Select name from customers where phone='$CUSTOMER_PHONE';")
      # if customer does not exist
      if [[ -z $CUSTOMER_NAME ]]
      then
        # Create new customer record
        echo "Sorry, I don't have a record for that phone number. What's your name?"
        read CUSTOMER_NAME
        INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO CUSTOMERS(name,phone) values('$CUSTOMER_NAME','$CUSTOMER_PHONE');")
      fi  
      CUSTOMER_ID=$($PSQL "Select customer_id from customers where phone='$CUSTOMER_PHONE';")
      echo "At what time would you like your $SELECTED_SERVICE, $CUSTOMER_NAME?"
      read SERVICE_TIME
      CREATE_APPOINTMENT=$($PSQL "INSERT INTO APPOINTMENTS(customer_id,service_id,time) values ($CUSTOMER_ID,$SERVICE_ID_SELECTED,'$SERVICE_TIME'); ")
      echo "I have put you down for a $SELECTED_SERVICE at $SERVICE_TIME, $CUSTOMER_NAME."
  fi
}
MAIN_MENU