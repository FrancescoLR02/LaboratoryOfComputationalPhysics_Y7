#!/bin/bash

filename='data.csv'
newFilename='data.txt'
evenNumber=0

#Deleting metadata, sub the comma and saving the file
grep -v "^#" $filename | tr -d "," > $newFilename


#counting even number:
IsEven=0

awk '{ for(i=1; i<=NF; i++) if ($i % 2 == 0) IsEven++ } END {print IsEven}' $newFilename


#X, Y, Z in module less or grater than 100*sqrt(3/2)

grater=0
lesser=0
counts=$(grep -c -v "^#" $filename)

sqrt=$(echo "scale=4; sqrt(3/2)" | bc)
variable=100
th=$(echo "$variable * $sqrt" | bc)


X=$(cut -d "," -f1 "$filename" | tail -n +5)
Y=$(cut -d "," -f2 "$filename" | tail -n +5)
Z=$(cut -d "," -f3 "$filename" | tail -n +5)

for i in $(seq 1 $counts); do
   X_i=$(echo "$X" | sed -n "${i}p")
   Y_i=$(echo "$Y" | sed -n "${i}p")
   Z_i=$(echo "$Z" | sed -n "${i}p")

   Square_i=$(echo "scale=4; sqrt($X_i^2 + $Y_i^2 + $Z_i^2)" | bc)

   #echo "Square_i: $Square_i, th: '$th'"

   if (( $(echo "$Square_i > $th" | bc ) )); then
      grater=$((grater + 1))  
   else
      lesser=$((lesser + 1))  
   fi

done

echo "The total number of value that are grater then 100*sqrt(3/2) is: $grater"
echo "The total number of value that are less then 100*sqrt(3/2) is: $lesser"

#D: Make `n` copies of data.txt (with `n` an input parameter of the script), where the i-th copy has all the numbers divided by i (with `1<=i<=n`).

read -p "Number of copies: " n 

for i in $(seq 1 $n); do
  awk -v div="$i" '{ for(j=1; j<=NF; j++) $j = $j / div }1' "$newFilename" > "data_${i}.txt"
done

