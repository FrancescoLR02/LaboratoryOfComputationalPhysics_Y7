#!/bin/bash 

cd $HOME
FolderName="Students2"
FileName="Students.csv"
link="https://www.dropbox.com/scl/fi/bxv17nrbrl83vw6qrkiu9/LCP_22-23_students.csv?rlkey=47fakvatrtif3q3qw4q97p5b7&e=1"


if [ ! -d $FolderName ]; then

   echo "Creating the folder..."
   mkdir $FolderName && cd $FolderName
   if [ ! -d $FileName ]; then

      echo "Downloading the file..."
      wget -O "$FileName" "$link"

   fi 

else
   echo "The folder and the file are already present!"

fi 

#Make two file for PoD Students and Physics students
cd $FolderName

grep "PoD" "$FileName" > "PoDStudents.txt" && grep "Physics" "$FileName" > "PhysicsStudents.txt"


counts=0
letter=0

for i in {A..Z}; do

   singleCount=$(cut -d "," -f1 "$FileName" | tail -n +2 | grep -c "$i")

   echo "The letter $i appears $singleCount times"

   if [ $singleCount -gt $counts ]; then
      counts=$singleCount
      letter=$i
   fi 

done

echo "The most frequent surname letter is $letter which appears $counts times"

lines=$(wc -l < "$FileName")

mkdir StudentsGroups

for (( i=0; i<$lines; ++i )); do 

   mod=$(( ($i) % 18 ))

   sed "${i}q;d" "$FileName" >> "StudentsGroups/StudentGroup_$mod.txt"

done






