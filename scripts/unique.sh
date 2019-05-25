#! /bin/bash

while read line
do 
    hit=`grep --color -B1 --no-group-separator "$line" s06b_putativeVAPs_complete_CRISPdom_unique2_renamed.pep`
    echo $hit
done < phylaSCP_named_237_noGaps_singleLine.fasta 
unique.sh (END) 

