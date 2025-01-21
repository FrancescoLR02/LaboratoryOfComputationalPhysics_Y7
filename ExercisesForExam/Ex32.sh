#!/bin/bash 

fileName="data.csv"
NewFileName="data.txt"


#Delete the commas and metadata:

grep -v "^#" "$fileName" | tr -d "," > "$NewFileName"

#How many even numbers:

isEven=0

awk '{ for(i=1; i <= NF; ++i) if ($i % 2 == 0) isEven++} END {print isEven}' "$NewFileName"

#Distinguish the entries on the basis:

count=$(grep -c -v "^#" "$fileName")

grater=0
smaller=0
sqrt=$(echo "scale=4; sqrt(3/2)" | bc)
variable=100
Th=$(echo "$variable * $sqrt" | bc )

X=$(cut -d "," -f1 "$fileName" | tail -n +5)
Y=$(cut -d "," -f2 "$fileName" | tail -n +5)
Z=$(cut -d "," -f3 "$fileName" | tail -n +5)

for i in $(seq 1 $count); do

   X_i=$(echo "$X" | sed -n "${i}p")
   Y_i=$(echo "$Y" | sed -n "${i}p")
   Z_i=$(echo "$Z" | sed -n "${i}p")

   Value=$(echo "scale=4; sqrt($X_i^2 + $Y_i^2 + $Z_i^2)" | bc )

   if (( $(echo "$Value > $Th" | bc) )); then
      grater=$(( grater + 1 ))
   
   else  
      smaller=$(( smaller + 1))

   fi
done

echo "The total number of value that are grater then 100*sqrt(3/2) is: $grater"
echo "The total number of value that are less then 100*sqrt(3/2) is: $smaller"


#Make n copies

read -p "Number of copies: " n

for i in $(seq 1 $n); do 

   awk -v div="${i}" '{for(j=1; j<=NF; ++j) $j = $j / div }1' $NewFileName > "data_$i.txt"

done 




