#!/bin/bash

SHIFT=${1:-1}
NUMBER=10#${2:00000}

number=$(($NUMBER))
number_shifted=$(($SHIFT+$number))

ours=`printf 'image_%05d.xml' $number_shifted`
theirs=`printf 'image_%05d.xml' $number`

diff $ours ../../../seq2-original.seq/$theirs

if [ 0 == `diff $ours ../../../seq2-original.seq/$theirs | grep 13c13 | wc -l` ] ; then
    printf "\033[1;32m%05d : ok\n" $number
else
    printf "\033[1;31m%05d : nope\n" $number
fi

ours=`printf 'image_%05d.pgm' $number_shifted`
theirs=`printf 'image_%05d.pgm' $number`

SUM_OURS=`md5sum -b $ours | cut -b-32`
SUM_THEIRS=`md5sum -b ../../../seq2-original.seq/$theirs | cut -b-32`

if [ $SUM_OURS == $SUM_THEIRS ] ; then
    printf "\033[1;32m%05d : sum ok ($SUM_OURS)\n" $number
else
    printf "\033[1;31m%05d : sum fail ($SUM_OURS)\n" $number
fi
