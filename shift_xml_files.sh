#!/bin/bash

SHIFT=${1:-1}

for f in *.xml
do
    expr=`echo "$f" | sed -r -e "s/image_([0-9]+)\.xml/$SHIFT+10#\1/g"`
    number=$(($expr))
    new1=`printf 'image_%05d.tmp1' $number`
    new2=`printf 'image_%05d.tmp2' $number`
    echo $new1
    mv $f $new1
    mv ${f/.xml/.pgm} $new2
done

rename 's/tmp1$/xml/' *
rename 's/tmp2$/pgm/' *

