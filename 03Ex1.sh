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

#Make two file, one containing the students from PoD and the other to P

grep "PoD" "$nameLink" > "PoDStudents.txt" && grep "Physics" "$nameLink" > "PhysicsStudents.txt"



for i in {A..Z}; do

   #tail -n +2 prints from the second line to the last, ignoring the metadata
   #! VERY IMPORTANT
   singleCount=$(cut -d "," -f1 "$nameLink" | tail -n +2 |grep -c "^$i")

   if [ $singleCount -gt $counts ]; then
      counts=$singleCount
      letter=$i
   fi

   echo "The surname with the letter $i appears $singleCount times"
done

echo "The letter with most counts is: '$letter' and appears $counts' times" 

#E) Assume an obvious numbering of the students in the file (first line is 1, second line is 2, etc.), group students "modulo 18", i.e. 1,19,37,.. 2,20,38,.. etc. and put each group in a separate file  

# Get the number of lines in the file
lines=$(wc -l < "$nameLink")

# Remove the output directory if it exists, then recreate it

# Process the file line by line
for (( i=1; i<=$lines; ++i )); do
  mod=$(( (i - 1) % 19 ))
  
  # Extract the line and append it to the appropriate file
  sed "${i}q;d" "$nameLink" >> "StudentsGroups/StudentsGroup_$mod.txt"
done
