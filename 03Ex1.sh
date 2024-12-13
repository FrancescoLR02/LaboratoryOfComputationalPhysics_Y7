#!/bin/bash 

cd $HOME

directory=students
link="https://www.dropbox.com/scl/fi/bxv17nrbrl83vw6qrkiu9/LCP_22-23_students.csv?rlkey=47fakvatrtif3q3qw4q97p5b7&e=1"
nameLink="StudentsList.csv"
counts=0


if [ ! -d "$directory" ]; then
   echo "$directory does not exist"
   mkdir $directory && cd $directory
   if [ ! -d "$nameLink" ]; then
      wget -O "$nameLink" "$link"
   fi
else 
   echo "$directory already exist"
   if [ -d "$nameLink" ]; then
      echo "file already exist"
   fi
fi

cd "$directory"

grep "PoD" "$nameLink" > "PoDStudents.txt" && grep "Physics" "$nameLink" > "PhysicsStudents.txt"

for i in {A..Z}; do

   singleCount=$(grep -c "$i" "$nameLink")
   echo "$i appears $singleCount times"
   done

