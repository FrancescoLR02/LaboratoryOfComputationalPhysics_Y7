#!/bin/bash

fileName="data.csv"
newFileName="data.txt"

grep -v "^#" "$fileName" | tr -d "," > "$newFileName"

#2)

IsEven=0

awk '{ for(i=1; i <=NF; ++i ) if ($i%2 == 0) IsEven++} END {print IsEven }' "$newFileName"


counts=$(grep -c -v "^#" "$fileName")
greater=0
smaller=0

sqrt=$( echo "scale=4; sqrt(3/2)" | bc)
number=100

th=$(echo "$number * $sqrt" |bc )


X=$(cut -d "," -f1 "$fileName" | tail -n +5)
Y=$(cut -d "," -f2 "$fileName" | tail -n +5)
Z=$(cut -d "," -f3 "$fileName" | tail -n +5)


for i in $(seq 1 $counts); do

   X_i=$(echo "$X" |sed -n "${i}p")
   Y_i=$(echo "$Y" |sed -n "${i}p")
   Z_i=$(echo "$Z" |sed -n "${i}p")

   EuclideanDistance=$(echo "scale=4; sqrt($X_i^2 + $Y_i^2 + $Z_i^2)" | bc)

   if (( $(echo "$EuclideanDistance > $th" | bc) )); then
      greater=$((greater + 1))

   else
      smaller=$((smaller + 1))

   fi
   
done

echo "The number of numbers for which the euclidean distance is grater than sqrt(3/2)*100 is: $greater"
echo "The number of numbers for which the euclidean distance is smaller than sqrt(3/2)*100 is: $smaller"


read -p "Number of copies: " n

for i in $(seq 1 $n); do 

   awk -v div="$i" '{for (j=1; j<=NF; ++j) $j = $j /div}1' "$newFileName" > "data_${i}.txt"

done