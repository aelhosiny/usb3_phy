
proc parse_cmd2 {argname default_value} {
  set arg_value $default_value
  set k 1
  foreach  i  $::argv  {
      #puts "arg $k is $i"
      incr k
      set parsed_arg [lindex [split $i "="] 0]; 
      if {[string equal $parsed_arg $argname]} {
      	 set arg_value [lindex [split $i "="] 1]; 
	 puts "====$argname is set to $arg_value===="
	 #puts "successfully parsed $argname argument"
      }      
  }
  return $arg_value
}


set toplevel multiplier_top_tb
set toplevel [parse_cmd2 -gtop $toplevel]



set scr_dir [exec pwd]

set ROOT_DIR [regsub /scripts/sim $scr_dir ""]

set list_file $ROOT_DIR/source/tb/vhdl_src.f
set simdir $ROOT_DIR/sim
set INPATH $ROOT_DIR/source/tb/$toplevel
set OUTPATH $simdir/$toplevel
set tcdir $INPATH

set env(INPATH) $INPATH
set env(OUTPATH) $OUTPATH
set env(ROOT_DIR) $ROOT_DIR

if { [file exists $simdir] == 0} {
	puts "==== create compile directory ===="
	exec mkdir -p $simdir
} else {
	puts "==== cleanup simulation directory ===="
	exec rm -fr $simdir/work
   exec rm -fr $simdir/$toplevel
	exec mkdir -p $simdir/$toplevel
}

vlib $simdir/work
vmap work $simdir/work


vcom -f $list_file

vsim -t ns ${toplevel} -wlf $simdir/$toplevel/${toplevel}.wlf
do $tcdir/wave.do
do $tcdir/tc_cfg.do
