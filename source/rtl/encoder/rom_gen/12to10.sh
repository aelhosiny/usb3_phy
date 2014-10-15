#!/bin/sh

infile=$1

sed -i 's/^1\([0-9a-z][0-9a-z]\)/"01" x"\1"/' $infile
sed -i 's/^2\([0-9a-z][0-9a-z]\)/"10" x"\1"/' $infile
sed -i 's/^3\([0-9a-z][0-9a-z]\)/"11" x"\1"/' $infile
sed -i 's/^0\([0-9a-z][0-9a-z]\)/"00" x"\1"/' $infile
sed -i 's/x/\& x/' $infile

