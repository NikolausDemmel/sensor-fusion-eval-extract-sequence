#!/bin/bash

SHIFT=${1:-1}

c=0
c_ok=0
c_oksum=0

for f in *.xml
do
    let c+=1

    expr=`echo "$f" | sed -r -e "s/image_([0-9]+)\.xml/10#\1/g"`
    number=$(($expr))
    number_shifted=$(($SHIFT+$number))

    ours=`printf 'image_%05d.xml' $number_shifted`
    theirs=`printf 'image_%05d.xml' $number`

    if [ 0 == `diff $ours ../../../seq2-original.seq/$theirs | grep 13c13 | wc -l` ] ; then
        let c_ok+=1
        printf "\033[1;32m%05d : ok\n" $number
    else
        printf "\033[1;31m%05d : nope\n" $number
    fi

    ours=${ours/.xml/.pgm}
    theirs=${theirs/.xml/.pgm}

    SUM_OURS=`md5sum -b $ours | cut -b-32`
    SUM_THEIRS=`md5sum -b ../../../seq2-original.seq/$theirs | cut -b-32`

    if [ $SUM_OURS == $SUM_THEIRS ] ; then
        let c_oksum+=1
        printf "\033[1;32m%05d : sum ok ($SUM_OURS)\n" $number
    else
        printf "\033[1;31m%05d : sum fail ($SUM_OURS\n" $number
    fi

done

echo "count $c"
echo "ok $c_ok"
echo "ok-sum $c_oksum"
