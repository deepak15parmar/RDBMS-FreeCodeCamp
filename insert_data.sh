#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo $($PSQL "truncate table games,teams;")
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
 if [[ $WINNER != winner ]]
  then
   TEAM_ID=$($PSQL "Select team_id from teams where name='$WINNER';")
   if [[ -z $TEAM_ID ]]
    then
     TEAM_INSERT_RESULT=$($PSQL "INSERT INTO TEAMS(name) values('$WINNER');")
     if [[ $TEAM_INSERT_RESULT == "INSERT 0 1" ]]
      then
       echo Inserted into teams, $WINNER.
     fi
   fi
 fi
 if [[ $OPPONENT != opponent ]]
   then
    TEAM_ID=$($PSQL "Select team_id from teams where name='$OPPONENT';")
   if [[ -z $TEAM_ID ]]
    then
     TEAM_INSERT_RESULT=$($PSQL "INSERT INTO TEAMS(name) values('$OPPONENT');")
     if [[ $TEAM_INSERT_RESULT == "INSERT 0 1" ]]
      then
       echo Inserted into teams, $OPPONENT.
     fi
   fi
 fi
done

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
if [[ $YEAR != year ]]
then
 WINNER_ID=$($PSQL "Select team_id from teams where name='$WINNER';")
 OPPONENT_ID=$($PSQL "Select team_id from teams where name='$OPPONENT';")
 echo -e "\nINSERT INTO GAMES(year,round,winner_id,opponent_id,winner_goals,opponent_goals) VALUES($YEAR,'$ROUND',$WINNER_ID,$OPPONENT_ID,$WINNER_GOALS,$OPPONENT_GOALS);"
 INSERT_RESULT=$($PSQL "INSERT INTO GAMES(year,round,winner_id,opponent_id,winner_goals,opponent_goals) VALUES($YEAR,'$ROUND',$WINNER_ID,$OPPONENT_ID,$WINNER_GOALS,$OPPONENT_GOALS);")
 if [[ $INSERT_RESULT == "INSERT 0 1" ]]
 then
  echo Inserted into games, $YEAR $ROUND $WINNER $OPPONENT
 fi
fi
done