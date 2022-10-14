#!/bin/bash

genlist() {
    todo=$1
    n=$2
    split=","
    for ((i=0;i<$n;i++));
    do
        ((l=$n - $i - 1))
        # echo "l =$l"
        ((mask=1<<$l))
        # echo "mask =$mask"
        ((x=(($todo & $mask) >> $l)+3))
        # echo "todo = $todo"
        # echo "x =$x"
        if (($l == 0));then
        string="$string$x"
        else
        string="$string$x$split "
        fi
    done
}

n=8
counter=0

srcfile=./src/main/scala/Multiplier/Topology.scala
genfile=./generated/Multiplier.v

autoline=`grep -n "  val autoGenArray"  $srcfile | head -1 | cut -d ":" -f 1`
sed -i "${autoline}s/false/true/" $srcfile

tochangehead="val cTypesCustom: Seq[Int] = Seq("
tochangetail=")"

if [[ ! -d "FPGA/src/verilog/" ]];then
    mkdir ./FPGA/scr/verilog/
fi

touch list.txt

((c=(1<<$n)-1))

for k in $(seq 0 $c);
do
    string=""
    genlist $k $n
    # echo $string
    tochange="  $tochangehead$string$tochangetail"
    # echo $tochange
    line=`grep -n "  val cTypesCustom"  $srcfile | head -1 | cut -d ":" -f 1`
    # echo $line
    sed -i "${line}s/.*/$tochange/" $srcfile
    # sed -n '6p' $ttt
    cTypes=`sbt test | grep "List"`

    isrepeat=`grep -o "$cTypes" list.txt | wc -l`

    if ((${isrepeat} != 0));then
        continue;
    fi

    echo "the cTypes of $counter is $cTypes"
    echo "$cTypes" >> list.txt
    # echo "jajaj" >> list.txt

    sed -i "1i // cTypes = $cTypes" $genfile
    ml=`grep -n "module Multiplier"  $genfile | head -1 | cut -d ":" -f 1`
    clk=`grep -n "ifdef"  $genfile | head -1 | cut -d ":" -f 1`
    # ((clk=$clk-1))
    sed -i "${ml}i (*use_dsp = ""yes""*)" $genfile
    sed -i "$clk r clk.txt" $genfile
    ((ml=$ml+1))
    sed -i "$ml s/.*/module Multiplier$counter(/" $genfile
    ((ml=$ml+1))
    sed -i "$ml s/.*/  input          clk_in1_p,/" $genfile
    sed -i "$ml a\  input          clk_in1_n," $genfile
    cp ./generated/Multiplier.v ./FPGA/src/verilog/Multiplier${counter}.v
    ((counter=counter+1))

done
rm -f list.txt