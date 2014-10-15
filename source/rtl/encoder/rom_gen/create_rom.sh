#!/bin/sh


infile=$1
outfile="$infile".out.txt
rm -f $outfile
touch $outfile

IFS="
"

i=0
for line in `cat $infile` 
do

  echo "when $i => vROM_tmp <= $line;" >> $outfile
  i=`expr $i + 1`
	
done
