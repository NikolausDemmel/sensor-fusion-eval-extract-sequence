SHELL:=/bin/bash

CALIB:=manual-calib
OFFSET:=0.075
OFFSET_MS:=$(shell bc <<< "scale=1;$(OFFSET)*1000/1")
RATE:=3

seq-offset-$(OFFSET_MS)ms-$CALIB.seq:
	[ 0 == `ps aux | grep "\(r\)osmaster" | wc -l` ] || (echo "Error: roscore is running!" && false) # hacky way to test if roscore is running
	roslaunch ../config/extract_sequence.launch bag:=recorded.bag rate:=$(RATE) gt_offset:=$(OFFSET) output:=seq-offset-$(OFFSET_MS)ms-$CALIB.seq
