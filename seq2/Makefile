SHELL:=/bin/bash

SEQ:=seq2
CALIB:=manual
OFFSET:=0.080
OFFSET_MS:=$(shell bc <<< "scale=1;$(OFFSET)*1000/1")
RATE:=1

$(SEQ)-offset-$(OFFSET_MS)ms-$CALIB.seq:
	[ 0 == `ps aux | grep "\(r\)osmaster" | wc -l` ] || (echo "Error: roscore is running!" && false) # hacky way to test if roscore is running
	roslaunch ../config/extract_sequence.launch bag:=recorded.bag rate:=$(RATE) gt_offset:=$(OFFSET) output:=$(SEQ)-offset_$(OFFSET_MS)ms-$(CALIB)_calib.seq
