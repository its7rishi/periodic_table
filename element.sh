#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table --tuples-only -c"

MAIN_MENU() {
  if [[ $1 ]]
  then
    echo -e"\n$1"
  fi

  echo -e "\nPlease provide an element as an argument."
  read USER_INPUT

  # CHECK WHETHER INPUT IS A NUMBER 
  if [[ ! $USER_INPUT =~ ^[0-9]+$ ]]

  then
    # IF INPUT IS NOT A NUBMBER
    ELEMENT=$($PSQL "SELECT atomic_number, name, symbol, atomic_mass, melting_point_celsius, boiling_point_celsius, type
FROM elements INNER JOIN properties USING(atomic_number)
INNER JOIN types USING(type_id) WHERE name = '$USER_INPUT' OR symbol = '$USER_INPUT';")
    
    # IF NOT ELEMENT IS NOT FOUND
    if [[ -z $ELEMENT ]]

    then
      # GIVE RESPONSE AND GO BACK TO MAIN
      MAIN_MENU "I could not find that element in the database."

    else
      # IF ELEMENT IS FOUND THEN GIVE ELEMENT INFO
      echo "$ELEMENT" | while read ATOMIC_NUMBER BAR NAME BAR SYMBOL BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT BAR TYPE
      do
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
      done
    fi
  else

  # IF INPUT IS A NUMBER
  echo "You typed: $USER_INPUT"

  fi

}

MAIN_MENU