#!/bin/bash
comma_separated_list=$1
mimeType=".json"
# Creates a JSON file for the Postman Runner service 
# Which significantly cuts down on Syncing content cache for multiple CID's
# Clean the initial comma seperated CID's in your text editor with a find and replace Use the * in the find options 
# and replace the comma with a \n
# The list of values are to be stacked as showen below
# 123
# 1234
# 12345 etc...etc..

function init() {  
  readSyncListFile
}

function readSyncListFile() { 
  totalFileCount=0;
  #Remove the output file if it already exists in the directory
  if [[ -f $comma_separated_list$mimeType ]];
  then
    rm $comma_separated_list$mimeType;
  fi
  #Create the output file
  touch $comma_separated_list$mimeType;
  
  if [[ -f $comma_separated_list ]];
  then
    echo '[' >> $comma_separated_list$mimeType;
    while IFS='' read line;
    do
      echo '{"activity_id":' $line '},' >> $comma_separated_list$mimeType;
      totalFileCount=`expr $totalFileCount + 1`;
    done < $comma_separated_list
    echo ']' >> $comma_separated_list$mimeType;
  fi
  echo "Runner JSON file complete.";
  echo "Total number of CID's: $totalFileCount";
}

init