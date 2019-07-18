cd ../tmp

# Remove identical sequences
cd-hit -i transdecoder-complete_VAPs_75-percent.pep -o transdecoder_VAPs_unique.pep -c 1
if [ -s transdecoder_VAPs_unique.pep ]
then
	echo "Redundant sequences removed"
else
	echo "Something is wrong with cd-hit"
fi

# Align sequences
mafft --auto --reorder transdecoder_VAPs_unique.pep > mafft_S-mansoni_VAP.fasta
if [ -s mafft_S-mansoni_VAP.fasta ]
then
	echo "Sequences successfully aligned. Read to build tree..."
else
	echo "Something is wrong with mafft"
fi

sed 's/.* />/' mafft_S-mansoni_VAP.fasta | sed 's/(.)//' | sed 's/:.*//' > mafft_S-mansoni_VAP_clean-names.fasta
if [ -s mafft_S-mansoni_VAP_clean-names.fasta ]
then
        echo "Names all tidied up for tree building..."
else
        echo "You may want to double check your headers"
fi

exit 0
