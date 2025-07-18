#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

echo -e "\nTotal number of goals in all games from both teams combined:"
echo "$($PSQL "SELECT SUM(winner_goals)+SUM(opponent_goals) from games")"

echo -e "\nAverage number of goals in all games from the winning teams:"
echo "$($PSQL "SELECT round(AVG(WINNER_GOALS),16) from games")"

echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo "$($PSQL "SELECT Round(AVG(WINNER_GOALS),2) from games")"

echo -e "\nAverage number of goals in all games from both teams:"
echo "$($PSQL "SELECT round(AVG(winner_goals)+AVG(opponent_goals),16) FROM GAMES")"

echo -e "\nMost goals scored in a single game by one team:"
echo "$($PSQL "Select MAX(winner_goals) from games")"

echo -e "\nNumber of games where the winning team scored more than two goals:"
echo "$($PSQL "select count(*) from games where winner_goals>2")"

echo -e "\nWinner of the 2018 tournament team name:"
echo "$($PSQL "Select name from teams where team_id=(Select winner_id from games where round='Final' and year=2018)")"

echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo "$($PSQL "Select distinct(teams.name) from teams inner join games on (teams.team_id=games.winner_id OR teams.team_id=games.opponent_id) where year=2014 AND round='Eighth-Final' order by teams.name")"

echo -e "\nList of unique winning team names in the whole data set:"
echo "$($PSQL "select distinct(teams.name) from teams inner join games on teams.team_id=games.winner_id order by teams.name")"

echo -e "\nYear and team name of all the champions:"
echo "$($PSQL "select games.year, teams.name from teams inner join games on teams.team_id=games.winner_id where round='Final' order by year")"

echo -e "\nList of teams that start with 'Co':"
echo "$($PSQL "Select name from teams where name like 'Co%'")"
