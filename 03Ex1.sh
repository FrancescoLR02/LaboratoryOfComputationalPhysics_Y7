#!/bin/bash 

cd $HOME

directory=students
secondDirectory=GroupStudents
link="https://www.dropbox.com/scl/fi/bxv17nrbrl83vw6qrkiu9/LCP_22-23_students.csv?rlkey=47fakvatrtif3q3qw4q97p5b7&e=1"
nameLink="StudentsList.csv"
counts=0
letter=0
numberOfStudents=0



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

   #tail -n +2 prints from the second line to the last, ignoring the metadata
   singleCount=$(cut -d "," -f1 "$nameLink" | tail -n +2 |grep -c "^$i")

   if [ $singleCount -gt $counts ]; then
      counts=$singleCount
      letter=$i

   fi

   numberOfStudents=$((numberOfStudents + $singleCount))

   echo "The surname with the letter $i appears $singleCount times"
   done

echo "The letter with most counts is: '$letter' and appears $counts' times" 



if [ ! -d "$secondDirectory" ]; then
   echo "$secondDirectory does not exist"
   mkdir $secondDirectory && cd $secondDirectory
else
   echo "$secondDirectory already exist"
   cd $secondDirectory
fi 









