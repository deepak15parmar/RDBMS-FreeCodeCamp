#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
NOT_FOUND(){
  echo I could not find that element in the database.
}
if [[ -z $1 ]]
then
  echo Please provide an element as an argument.
elif [[ $1 =~ ^[0-9]+$ ]]
then
  ELEMENT_DETAIL=$($PSQL "select symbol, name, atomic_mass, melting_point_celsius, boiling_point_celsius, type from elements inner join properties using(atomic_number) inner
 join types using(type_id) where atomic_number=$1;")
 if [[ -z $ELEMENT_DETAIL ]]
 then
   NOT_FOUND
 else
   echo $ELEMENT_DETAIL | while IFS="|" read SYMBOL NAME ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE
  do
   echo "The element with atomic number $1 is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  done
  fi
elif [[ $1 =~ ^[a-zA-Z]{1,2}$ ]]
then
  ELEMENT_DETAIL=$($PSQL "select atomic_number, symbol, name, atomic_mass, melting_point_celsius, boiling_point_celsius, type from elements inner join properties using(atomic_number) inner
 join types using(type_id) where symbol='$1';")
  if [[ -z $ELEMENT_DETAIL ]]
 then
   NOT_FOUND
 else 
  echo $ELEMENT_DETAIL | while IFS="|" read ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE
  do
   echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  done
  fi
elif [[ $1 =~ ^[a-zA-Z]+$ ]]
then
    ELEMENT_DETAIL=$($PSQL "select atomic_number, symbol, name, atomic_mass, melting_point_celsius, boiling_point_celsius, type from elements inner join properties using(atomic_number) inner
 join types using(type_id) where name='$1';")
  if [[ -z $ELEMENT_DETAIL ]]
 then
   NOT_FOUND
 else
  echo $ELEMENT_DETAIL | while IFS="|" read ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE
  do
   echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  done
  fi
else
  echo -e "Please provide an element as an argument. Examples:-\n\n[1] ./element.sh 1\n[2] ./element.sh H\n[3] ./element.sh Hydrogen\n"
fi