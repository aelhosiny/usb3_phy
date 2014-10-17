#!/bin/sh

## Clean old compilation results
## Keep the reports only

export toplevel=$1

export ROOT_DIR=`echo $PWD | sed 's_/scripts/synthesis__'`
echo "root dir is $ROOT_DIR"
export scr_dir=$ROOT_DIR/scripts/synthesis
export synth_dir=$ROOT_DIR/synthesis/$toplevel

mkdir -p $synth_dir
cd $synth_dir

xst -ifn $scr_dir/settings.xst -ofn $toplevel".srp"



  echo "===============================================" > $synth_dir/Warnings.txt
  echo "============ Unused signals report ============" >> $synth_dir/Warnings.txt
  echo "===============================================" >> $synth_dir/Warnings.txt
  
  grep "since the identifier is never used" $toplevel".srp" | grep --color "WARNING" >> $synth_dir/Warnings.txt
  
  echo "============================================" >>  $synth_dir/Warnings.txt
  echo "============ Unused input ports ============" >> $synth_dir/Warnings.txt
  echo "============================================" >> $synth_dir/Warnings.txt
  
  grep "This port will be preserved and left unconnected" ${toplevel}.srp | grep "Input"  | grep --color "WARNING"  >> $synth_dir/Warnings.txt
  
  
  echo "==========================================" >>  $synth_dir/Warnings.txt
  echo "============ Undriven Signals ============" >> $synth_dir/Warnings.txt
  echo "==========================================" >> $synth_dir/Warnings.txt
  
  grep "WARNING" ${toplevel}.srp | grep "does not have a driver" >> $synth_dir/Warnings.txt
  
  #### Get error Report
  
  grep "ERROR" ${toplevel}.srp > $synth_dir/errors.txt
  
  
  #### Get all Warnings
  
  grep "WARNING" ${toplevel}.srp > $synth_dir/all_warnings.txt

