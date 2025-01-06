#!/bin/bash

filename='data.csv'
newFilename='data.txt'
evenNumber=0

#! important!! 

#Deleting metadata, sub the comma and saving the file
grep -v "^#" $filename | tr -d "," > $newFilename

#counting even number:

#TODO


#X, Y, Z in module less or grater than 100*sqrt(3/2)
grater=0
lesser=0
#th=100*sqrt(3/2)



X=$(cut -d "," -f1 "$filename" | tail -n +5)
Y=$(cut -d "," -f2 "$filename" | tail -n +5)
Z=$(cut -d "," -f3 "$filename" | tail -n +5)





