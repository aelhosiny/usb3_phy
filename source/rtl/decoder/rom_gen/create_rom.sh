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

  echo "when $line => vROM_tmp <= std_logic_vector(to_unsigned($i, 9));" >> $outfile
  i=`expr $i + 1`
	
done
