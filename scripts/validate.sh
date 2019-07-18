cd ../tmp/

hmmscan --cpu 6 --domtblout pfam-validate_VAPs.domtblout Pfam-A.hmm potential_VAPs.fasta.transdecoder.pep
echo "domain hits found"

# wrap fasta file for proteins
# keep only 'complete' proteins
awk '!/^>/ { printf "%s", $0; n = "\n" } /^>/ { print n $0; n = "" } END { printf "%s", n }' potential_VAPs.fasta.transdecoder.pep > transdecoder_VAPs.pep
echo "did a thing"
grep -A1 "complete" transdecoder_*pep > transdecoder-complete_VAPs.pep
echo "removed all incomplete sequences"
sed -i 's/--//g' transdecoder-complete_VAPs.pep
echo "renaming step 1"
sed -i '/^$/d' transdecoder-complete_VAPs.pep
echo "renaming step 2"

# compare domain hits with transdecoder hits
grep "CAP" pfam-validate_VAPs.domtblout | grep "Cysteine-rich secretory protein family" | awk '{print $4}' | sort | uniq > pfam-CRISP_names.txt 
sed 's/\ .*//' transdecoder-complete_VAPs.pep | grep ">" | sed 's/>//' | sort | uniq > transdecoder-VAP_names.txt 
diff transdecoder-VAP_names.txt pfam-CRISP_names.txt > problematic-VAPs.txt
if [ -s problematic-VAPs.txt ]
then
	echo "Looks like some VAPs may need a closer look. Please check 'tmp/problematic-VAPs.txt' and remove un-validated VAPs from 'transdecoder-complete_VAPs.pep' before continuing."
	exit 1
else
	echo "No problems here! All VAPs successfully validated."
fi

#######################################################
# OPTIONAL: further filter by domain coverage
# Recommended: Keep only the putative proteins that have at least 75% of the CRSIP domain
# If prefer a different cut-off, adjust cut-offs
# This is very specific to CRISP domain, so will need to put in some work to generalize this

# >50%
# awk '($19-$18)>63 {print $4}' s07_redundantRemoved2_557_onlyCRISP.domtblout | uniq > test_moreThan50percentHit_names.txt
# while read LINE; do grep -wA1 --no-group-separator "$LINE" s07_redundantRemoved2_557.pep; done < test_moreThan50percentHit_names.txt > transdecoder-complete_VAPs_75-percent.pep

# >75%
awk '($19-$18)>94 {print $4}' pfam-validate_VAPs.domtblout | uniq > test_moreThan75percentHit_names.txt
while read LINE; do grep -wA1 --no-group-separator "$LINE" transdecoder-complete_VAPs.pep; done < test_moreThan75percentHit_names.txt > transdecoder-complete_VAPs_75-percent.pep
FILE=../tmp/transdecoder-complete_VAPs_75-percent.pep
if [ -f "$FILE"]
then
	echo "You have selected to only keep VAPs with at greater than 75% CRISP domain coverage - no prob"
fi

# >80%
# awk '($19-$18)>100 {print $4}' pfam-validate_VAPs.domtblout | uniq > test_moreThan80percentHit_names.txt
# while read LINE; do grep -wA1 --no-group-separator "$LINE" transdecoder-complete_VAPs.pep; done < test_moreThan80percentHit_names.txt > transdecoder-complete_VAPs_75-percent.pep

# >90%
# awk '($19-$18)>113 {print $4}' pfam-validate_VAPs.domtblout | uniq > test_moreThan90percentHit_names.txt
# while read LINE; do grep -wA1 --no-group-separator "$LINE" transdecoder-complete_VAPs.pep; done < test_moreThan90percentHit_names.txt > transdecoder-complete_VAPs_75-percent.pep

# >95%
# awk '($19-$18)>119 {print $4}' pfam-validate_VAPs.domtblout | uniq > test_moreThan95percentHit_names.txt
# while read LINE; do grep -wA1 --no-group-separator "$LINE" transdecoder-complete_VAPs.pep; done < test_moreThan95percentHit_names.txt > transdecoder-complete_VAPs_75-percent.pep
#######################################################

exit 0