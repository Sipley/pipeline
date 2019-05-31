cd ../tmp/

hmmscan --cpu 6 --domtblout pfam-validate_VAPs.domtblout Pfam-A.hmm potential_VAPs.fasta.transdecoder.pep

# wrap fasta file for proteins
# keep only 'complete' proteins
awk '!/^>/ { printf "%s", $0; n = "\n" } /^>/ { print n $0; n = "" } END { printf "%s", n }' potential_VAPs.fasta.transdecoder.pep > transdecoder_VAPs.pep
grep -A1 "complete" transdecoder_*pep > transdecoder-complete_VAPs.pep
sed -i 's/--//g' transdecoder-complete_VAPs.pep
sed -i '/^$/d' transdecoder-complete_VAPs.pep

# compare domain hits with transdecoder hits
grep "CAP" pfam-validate_VAPs.domtblout | grep "Cysteine-rich secretory protein family" | awk '{print $4}' | sort | uniq > pfam-CRISP_names.txt 
sed 's/\ .*//' transdecoder-complete_VAPs.pep | grep ">" | sed 's/>//' | sort | uniq > transdecoder-VAP_names.txt 
diff transdecoder-VAP_names.txt pfam-CRISP_names.txt > problematic-VAPs.txt
if [ -s /tmp/problematic-VAPs.txt ]
then
	echo "Looks like some VAPs may need a closer look. Please check 'problematic-VAPs.txt' and remove un-validated VAPs from 'transdecoder-comlete_VAPs.pep' before continuing."
	exit 1
else
	echo "No problems here! All VAPs successfully validated."
wc -l *names.txt


exit 0