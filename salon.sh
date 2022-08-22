#!/bin/bash
# Script to make an appointment at beauty salon

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"

MAIN_MENU() {
  if [[ $1  ]]
  then 
    echo -e "\n$1"
  fi
  echo -e "\nWelcome to My Salon, how can I help you?"
  echo -e "\n1) Cut\n2) Color\n3) Style\n4) Trim"
  read SERVICE_ID_SELECTED
  case $SERVICE_ID_SELECTED in
    1) CUT ;;
    2) COLOR ;;
    3) STYLE ;;
    4) TRIM ;;
    *) MAIN_MENU "I could not find that service. What would you like today?" ;;
  esac
}

CUT() {
  # get service name
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE name='Cut'")
  # format service name
  SERVICE_NAME_FORMATTED=$(echo $SERVICE_NAME | sed 's/ |/"/')
  # get phone number
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE
  # check if phone exists in database
  LOOK_FOR_PHONE=$($PSQL "SELECT * FROM customers WHERE phone='$CUSTOMER_PHONE'")
  # if not
  if [[ -z $LOOK_FOR_PHONE ]]
  then
    # read customer name
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME
    # insert customer name in database
    INSERT_CLIENT=$($PSQL "INSERT INTO customers(phone,name) VALUES('$CUSTOMER_PHONE','$CUSTOMER_NAME')")
    # get service time
    echo -e "\nWhat time would you like your $SERVICE_NAME_FORMATTED, $CUSTOMER_NAME?"
    read SERVICE_TIME
    # get customer ID
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE name='$CUSTOMER_NAME' AND phone='$CUSTOMER_PHONE'")
    # get service ID
    SERVICE_ID_SELECTED=$($PSQL "SELECT service_id FROM services WHERE name='$SERVICE_NAME_FORMATTED'")
    # Insert appointment in database
    CREATE_APP=$($PSQL "INSERT INTO appointments(customer_id,service_id,time) VALUES($CUSTOMER_ID,$SERVICE_ID_SELECTED,'$SERVICE_TIME')")
    echo -e "\nI have put you down for a $SERVICE_NAME_FORMATTED at $SERVICE_TIME, $CUSTOMER_NAME."
  else
    # get customer name
    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
    # format customer name
    CUSTOMER_NAME_FORMATTED=$(echo $CUSTOMER_NAME | sed -E 's/^ *| *$//g')
    # get customer ID
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE' AND name='$CUSTOMER_NAME_FORMATTED'")
    # get service time
    echo -e "\nWhat time would you like your $SERVICE_NAME_FORMATTED, $(echo $CUSTOMER_NAME | sed -E 's/^ *| *$//g')?"
    read SERVICE_TIME
    # get service ID
    SERVICE_ID_SELECTED=$($PSQL "SELECT service_id FROM services WHERE name='$SERVICE_NAME_FORMATTED'")
    # check if appointment exists already
    APP_CHECK=$($PSQL "SELECT appointment_id FROM appointments WHERE customer_id=$CUSTOMER_ID AND service_id=$SERVICE_ID_SELECTED AND time='$SERVICE_TIME'")
    # if not
    if [[ -z $APP_CHECK ]]
    then
      CREATE_APP=$($PSQL "INSERT INTO appointments(customer_id,service_id,time) VALUES($CUSTOMER_ID,$SERVICE_ID_SELECTED,'$SERVICE_TIME')")
      if [[ $CREATE_APP == "INSERT 0 1" ]]
      then
        echo -e "\nI have put you down for a $SERVICE_NAME_FORMATTED at $SERVICE_TIME, $(echo $CUSTOMER_NAME | sed -E 's/^ *| *$//g')."
      fi
    else
    echo -e "\nYou already have an appointment in that time."
    fi
  fi
}

COLOR() {
  # get service name
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE name='Color'")
  # format service name
  SERVICE_NAME_FORMATTED=$(echo $SERVICE_NAME | sed 's/ |/"/')
  # get phone number
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE
  # check if phone exists in database
  LOOK_FOR_PHONE=$($PSQL "SELECT * FROM customers WHERE phone='$CUSTOMER_PHONE'")
  # if not
  if [[ -z $LOOK_FOR_PHONE ]]
  then
    # read customer name
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME
    # insert customer name in database
    INSERT_CLIENT=$($PSQL "INSERT INTO customers(phone,name) VALUES('$CUSTOMER_PHONE','$CUSTOMER_NAME')")
    # get service time
    echo -e "\nWhat time would you like your $SERVICE_NAME_FORMATTED, $CUSTOMER_NAME?"
    read SERVICE_TIME
    # get customer ID
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE name='$CUSTOMER_NAME' AND phone='$CUSTOMER_PHONE'")
    # get service ID
    SERVICE_ID_SELECTED=$($PSQL "SELECT service_id FROM services WHERE name='$SERVICE_NAME_FORMATTED'")
    # Insert appointment in database
    CREATE_APP=$($PSQL "INSERT INTO appointments(customer_id,service_id,time) VALUES($CUSTOMER_ID,$SERVICE_ID_SELECTED,'$SERVICE_TIME')")
    echo -e "\nI have put you down for a $SERVICE_NAME_FORMATTED at $SERVICE_TIME, $CUSTOMER_NAME."
  else
    # get customer name
    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
    # format customer name
    CUSTOMER_NAME_FORMATTED=$(echo $CUSTOMER_NAME | sed -E 's/^ *| *$//g')
    # get customer ID
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE' AND name='$CUSTOMER_NAME_FORMATTED'")
    # get service time
    echo -e "\nWhat time would you like your $SERVICE_NAME_FORMATTED, $(echo $CUSTOMER_NAME | sed -E 's/^ *| *$//g')?"
    read SERVICE_TIME
    # get service ID
    SERVICE_ID_SELECTED=$($PSQL "SELECT service_id FROM services WHERE name='$SERVICE_NAME_FORMATTED'")
    # check if appointment exists already
    APP_CHECK=$($PSQL "SELECT appointment_id FROM appointments WHERE customer_id=$CUSTOMER_ID AND service_id=$SERVICE_ID_SELECTED AND time='$SERVICE_TIME'")
    # if not
    if [[ -z $APP_CHECK ]]
    then
      CREATE_APP=$($PSQL "INSERT INTO appointments(customer_id,service_id,time) VALUES($CUSTOMER_ID,$SERVICE_ID_SELECTED,'$SERVICE_TIME')")
      if [[ $CREATE_APP == "INSERT 0 1" ]]
      then
        echo -e "\nI have put you down for a $SERVICE_NAME_FORMATTED at $SERVICE_TIME, $(echo $CUSTOMER_NAME | sed -E 's/^ *| *$//g')."
      fi
    else
    echo -e "\nYou already have an appointment in that time."
    fi
  fi
}

STYLE() {
  # get service name
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE name='Style'")
  # format service name
  SERVICE_NAME_FORMATTED=$(echo $SERVICE_NAME | sed 's/ |/"/')
  # get phone number
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE
  # check if phone exists in database
  LOOK_FOR_PHONE=$($PSQL "SELECT * FROM customers WHERE phone='$CUSTOMER_PHONE'")
  # if not
  if [[ -z $LOOK_FOR_PHONE ]]
  then
    # read customer name
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME
    # insert customer name in database
    INSERT_CLIENT=$($PSQL "INSERT INTO customers(phone,name) VALUES('$CUSTOMER_PHONE','$CUSTOMER_NAME')")
    # get service time
    echo -e "\nWhat time would you like your $SERVICE_NAME_FORMATTED, $CUSTOMER_NAME?"
    read SERVICE_TIME
    # get customer ID
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE name='$CUSTOMER_NAME' AND phone='$CUSTOMER_PHONE'")
    # get service ID
    SERVICE_ID_SELECTED=$($PSQL "SELECT service_id FROM services WHERE name='$SERVICE_NAME_FORMATTED'")
    # Insert appointment in database
    CREATE_APP=$($PSQL "INSERT INTO appointments(customer_id,service_id,time) VALUES($CUSTOMER_ID,$SERVICE_ID_SELECTED,'$SERVICE_TIME')")
    echo -e "\nI have put you down for a $SERVICE_NAME_FORMATTED at $SERVICE_TIME, $CUSTOMER_NAME."
  else
    # get customer name
    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
    # format customer name
    CUSTOMER_NAME_FORMATTED=$(echo $CUSTOMER_NAME | sed -E 's/^ *| *$//g')
    # get customer ID
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE' AND name='$CUSTOMER_NAME_FORMATTED'")
    # get service time
    echo -e "\nWhat time would you like your $SERVICE_NAME_FORMATTED, $(echo $CUSTOMER_NAME | sed -E 's/^ *| *$//g')?"
    read SERVICE_TIME
    # get service ID
    SERVICE_ID_SELECTED=$($PSQL "SELECT service_id FROM services WHERE name='$SERVICE_NAME_FORMATTED'")
    # check if appointment exists already
    APP_CHECK=$($PSQL "SELECT appointment_id FROM appointments WHERE customer_id=$CUSTOMER_ID AND service_id=$SERVICE_ID_SELECTED AND time='$SERVICE_TIME'")
    # if not
    if [[ -z $APP_CHECK ]]
    then
      CREATE_APP=$($PSQL "INSERT INTO appointments(customer_id,service_id,time) VALUES($CUSTOMER_ID,$SERVICE_ID_SELECTED,'$SERVICE_TIME')")
      if [[ $CREATE_APP == "INSERT 0 1" ]]
      then
        echo -e "\nI have put you down for a $SERVICE_NAME_FORMATTED at $SERVICE_TIME, $(echo $CUSTOMER_NAME | sed -E 's/^ *| *$//g')."
      fi
    else
    echo -e "\nYou already have an appointment in that time."
    fi
  fi
}

TRIM() {
  # get service name
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE name='Trim'")
  # format service name
  SERVICE_NAME_FORMATTED=$(echo $SERVICE_NAME | sed 's/ |/"/')
  # get phone number
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE
  # check if phone exists in database
  LOOK_FOR_PHONE=$($PSQL "SELECT * FROM customers WHERE phone='$CUSTOMER_PHONE'")
  # if not
  if [[ -z $LOOK_FOR_PHONE ]]
  then
    # read customer name
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME
    # insert customer name in database
    INSERT_CLIENT=$($PSQL "INSERT INTO customers(phone,name) VALUES('$CUSTOMER_PHONE','$CUSTOMER_NAME')")
    # get service time
    echo -e "\nWhat time would you like your $SERVICE_NAME_FORMATTED, $CUSTOMER_NAME?"
    read SERVICE_TIME
    # get customer ID
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE name='$CUSTOMER_NAME' AND phone='$CUSTOMER_PHONE'")
    # get service ID
    SERVICE_ID_SELECTED=$($PSQL "SELECT service_id FROM services WHERE name='$SERVICE_NAME_FORMATTED'")
    # Insert appointment in database
    CREATE_APP=$($PSQL "INSERT INTO appointments(customer_id,service_id,time) VALUES($CUSTOMER_ID,$SERVICE_ID_SELECTED,'$SERVICE_TIME')")
    echo -e "\nI have put you down for a $SERVICE_NAME_FORMATTED at $SERVICE_TIME, $CUSTOMER_NAME."
  else
    # get customer name
    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
    # format customer name
    CUSTOMER_NAME_FORMATTED=$(echo $CUSTOMER_NAME | sed -E 's/^ *| *$//g')
    # get customer ID
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE' AND name='$CUSTOMER_NAME_FORMATTED'")
    # get service time
    echo -e "\nWhat time would you like your $SERVICE_NAME_FORMATTED, $(echo $CUSTOMER_NAME | sed -E 's/^ *| *$//g')?"
    read SERVICE_TIME
    # get service ID
    SERVICE_ID_SELECTED=$($PSQL "SELECT service_id FROM services WHERE name='$SERVICE_NAME_FORMATTED'")
    # check if appointment exists already
    APP_CHECK=$($PSQL "SELECT appointment_id FROM appointments WHERE customer_id=$CUSTOMER_ID AND service_id=$SERVICE_ID_SELECTED AND time='$SERVICE_TIME'")
    # if not
    if [[ -z $APP_CHECK ]]
    then
      CREATE_APP=$($PSQL "INSERT INTO appointments(customer_id,service_id,time) VALUES($CUSTOMER_ID,$SERVICE_ID_SELECTED,'$SERVICE_TIME')")
      if [[ $CREATE_APP == "INSERT 0 1" ]]
      then
        echo -e "\nI have put you down for a $SERVICE_NAME_FORMATTED at $SERVICE_TIME, $(echo $CUSTOMER_NAME | sed -E 's/^ *| *$//g')."
      fi
    else
    echo -e "\nYou already have an appointment in that time."
    fi
  fi
}

MAIN_MENU