#!/bin/bash

function genlist() {
    todo=$1
    n=$2
    split=","
    for ((i=0;i<$n;i++));
    do
        ((l=$n - $i - 1))
        # echo "l =$l"
        ((mask=$((1<<$l))))
        # echo "mask =$mask"
        ((x=($(($todo & $mask)) >> $l)+3))
        # echo "todo = $todo"
        # echo "x =$x"
        if (($l == 0));then
        string="$string $x"
        else
        string="$string $x$split"
        fi
    done
}

n=6
#todo = 0
#mask = ~((-1) >> 6 << 6)

srcfile=./src/main/scala/Multiplier/Topology.scala
genfile=./generated/Multiplier.v
# ttt=./hahah.txt
tochangehead="val cTypesCustom: Seq[Int] = Seq("
tochangetail=")"
# string=""
if [[ ! -d "FPGA/scr/verilog/" ]];then
mkdir ./FPGA/scr/verilog/
# else
# echo "Floder is existing"
fi
# sed -i "6s/.*/  val cTypesCustom: Seq[Int] = Seq(4, 2, 0, 3, 4)/" $ttt
# sed -n '6p' $ttt
((c=((1<<$n))-1))
for k in $(seq 0 $c);
do
string=""
genlist $k $n
# echo $string
tochange="  $tochangehead$string$tochangetail"
# echo $tochange
sed -i "34s/.*/$tochange/" $srcfile
# sed -n '6p' $ttt
cTypes=`sbt test | grep "List"`
echo "the cTypes of $k is $cTypes"
ml=`grep -n "module Multiplier"  $genfile | head -1 | cut -d ":" -f 1`
clk=`grep -n "ifdef"  $genfile | head -1 | cut -d ":" -f 1`
# ((clk=$clk-1))
sed -i "1i // cTypes = $cTypes" $genfile
sed -i "$clk r clk.txt" $genfile
((ml=$ml+1))
sed -i "$ml s/.*/module Multiplier$k(/" $genfile
((ml=$ml+1))
sed -i "$ml s/.*/  input          clk_in1_p,/" $genfile
# ((ml=$ml+1))
sed -i "$ml a\  input          clk_in1_n," $genfile
cp ./generated/Multiplier.v ./FPGA/scr/verilog/Multiplier$k.v

# sbt test
done
