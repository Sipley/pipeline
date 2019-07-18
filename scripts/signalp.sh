cd ../tmp

# Make headers pretty
sed 's/.* />/' transdecoder_VAPs_unique.pep | sed 's/(.)//' | sed 's/:.*//' > VAPs_unique_clean-names.fasta
if [ -s VAPs_unique_clean-names.fasta ]
then
        echo "Names all tidied up for signal peptide predictions..."
else
        echo "You may want to double check your headers"
fi

# Get signal peptide predictions
signalp -t euk -f short VAPs_unique_clean-names.fasta > VAPs.signalp
if [ -s VAPs.signalp ]
then
        echo "Signal peptides successfully predicted! On to annotating tree..."
else
        echo "There was a problem with SignalP"
fi
