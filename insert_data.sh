#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $WINNER != "winner" ]]
  then
    TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    # if not found
    if [[ -z $TEAM_ID ]]
    then
      INSERT_WINNER_ID=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
      if [[ $INSERT_WINNER_ID == "INSERT 0 1" ]]
      then
      echo Inserted into name, $WINNER
      fi
      TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    fi
    fi
    if [[ $OPPONENT != "opponent" ]]
  then
    TEAM_ID2=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
    if [[ -z $TEAM_ID2 ]]
    then
      INSERT_WINNER_ID2=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
      if [[ $INSERT_WINNER_ID2 == "INSERT 0 1" ]]
    then
      echo Inserted into name, $OPPONENT
    fi
      TEAM_ID2=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
    fi
    fi
    if [[ $YEAR != "year" ]]
    then
     INSERT_GAMES=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES('$YEAR', '$ROUND', $TEAM_ID, $TEAM_ID2, $WINNER_GOALS, $OPPONENT_GOALS)")
     if [[ $INSERT_GAMES == "INSERT 0 1" ]]
      then
      echo Inserted into games, $YEAR, $Round
      fi
      fi
  done
