#!/bin/bash

cd $HOME

folderName="students2"
link="https://www.dropbox.com/scl/fi/bxv17nrbrl83vw6qrkiu9/LCP_22-23_students.csv?rlkey=47fakvatrtif3q3qw4q97p5b7"
fileName="StudentsList.csv"
newFolder="StudentsFolder"

letter=0
counts=0



if [ ! -d $folderName ]; then
   echo "Creating the new folder $folderName"
   mkdir $folderName && cd $folderName

   if [ ! -d $fileName ]; then 
      echo "Obtaining the file from the source: "
      wget -O "$fileName" "$link"

   else
      echo "$fileName is already in $folderName"
   fi 

fi 

cd $folderName

grep "PoD" "$fileName" > "PoD_Students.txt" && grep "Physics" "$fileName" > "Physics_Students.txt"



for i in {A..Z}; do 

   singleCount=$(cut -d "," -f1 "$fileName" | tail -n +2 | grep -c "^$i")

   if [ $singleCount -gt $counts ]; then
      letter=$i
      counts=$singleCount
   fi

   echo "The letter $i appears $singleCount times"

done

echo "The most common surname letter is $letter which appears $counts times"


lines=$(wc -l < "$fileName")

mkdir $newFolder 

for (( i=0; i<$lines; ++i )); do 

   mod=$(( ($i) % 19 ))

   sed "${i}q;d" "$fileName" >> "$newFolder/StudentGroup_$mod.txt"

done


