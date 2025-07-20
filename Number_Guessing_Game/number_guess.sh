#!/bin/bash
MAIN_FUNCTION(){
  PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"
  NUMBER=$((($RANDOM%1000)+1))
  NUMBER_OF_GUESSES=0
  echo "Enter your username:"
  read USERNAME
  #VERIFY user from DB
  VERIFY_USER_DB
  
}
VERIFY_USER_DB(){
  USER_ID=$($PSQL "select user_id from userbase where username='$USERNAME';")
  if [[ -z $USER_ID ]]
  then
    CREATE_USER_RESULT=$($PSQL "INSERT INTO userbase(username) values('$USERNAME');")
    USER_ID=$($PSQL "select user_id from userbase where username='$USERNAME';")
    echo Welcome, $USERNAME! It looks like this is your first time here.
  else
    GAMES_PLAYED=$($PSQL "Select count(*) from game_history where user_id=$USER_ID;")
    BEST_GAME_GUESS=$($PSQL "Select min(number_of_guess) from game_history where user_id=$USER_ID;")
    echo Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME_GUESS guesses.
  fi
  echo "Guess the secret number between 1 and 1000:"
  READ_INPUT
}
READ_INPUT(){
  read GUESS
  PROCESS_INPUT
}
PROCESS_INPUT(){
  if [[ ! $GUESS =~ ^[0-9]+$ ]]
  then
     echo "That is not an integer, guess again:"
     ((NUMBER_OF_GUESSES+=1))
     READ_INPUT
  elif [[ $GUESS -lt $NUMBER ]]
  then
    echo "\nIt's higher than that, guess again:"
    ((NUMBER_OF_GUESSES+=1))
    READ_INPUT
  elif [[ $GUESS -gt $NUMBER ]]
  then
    echo "It's lower than that, guess again:"
    ((NUMBER_OF_GUESSES+=1))
    READ_INPUT
  else
    ((NUMBER_OF_GUESSES+=1))
    echo You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $NUMBER. Nice job!
    INSERT_GAME_HIST=$($PSQL "Insert into game_history(number_of_guess,user_id) values($NUMBER_OF_GUESSES,$USER_ID);")
  fi
}
MAIN_FUNCTION