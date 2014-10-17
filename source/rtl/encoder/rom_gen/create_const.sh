#!/bin/sh


infile=$1
outfile="$infile".const.txt
polarity=$2
rm -f $outfile
touch $outfile

IFS="
"

i=0
k=0
for line in `cat $infile` 
do

  echo "constant  eD"$i"_"$k"_"$polarity" std_logic_vector(9 downto 0) := $line;" >> $outfile
  if [ $i -lt 31 ]  
  then
    i=`expr $i + 1`
  else
    i=0
    k=`expr $k + 1`
  fi
	
done
