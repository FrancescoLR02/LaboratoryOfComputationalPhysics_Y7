#!/bin/bash

cd $HOME

folderName="students2"
fileName="StudentsList.csv"
link="https://www.dropbox.com/scl/fi/bxv17nrbrl83vw6qrkiu9/LCP_22-23_students.csv?rlkey=47fakvatrtif3q3qw4q97p5b7&e=1"

letter=0
count=0


if [ ! -d $folderName ]; then
   echo "There is no folder named $folderName"
   mkdir $folderName && cd $folderName

   if [ ! -d $fileName ]; then   
      echo "Downloading the file" 
      wget -O "$fileName" "$link"

   fi 

else
   echo "The folder is already present!" 

fi 

#2)

cd $folderName

echo "Dividing students based on the LM course ..." 
grep "PoD" "$fileName" > "PoD_Students.txt" && grep "Physics" "$fileName" > "Physics_Students.txt" 

#3)

for i in {A..Z}; do 

   singleCount=$(cut -d "," -f1 "$fileName" | tail -n +2 | grep -c "$i" )

   echo "The letter $i appears $singleCount times in the list"

   if [ $singleCount -gt $count ]; then

      count=$singleCount
      letter=$i
   fi 

done

echo "The most frequent letter is $letter which appears $count times" 

#5)

lines=$(wc -l < "$fileName")

mkdir StudentsGroups

for (( i=0; i < $lines; ++i )); do

   mod=$(( ($i) % 19))

   sed "${i}q;d" "$fileName" >> "StudentsGroups/studentGroup_$mod.txt"

done
