cd ../tmp/

hmmscan --cpu 6 --domtblout pfam-validate_VAPs.domtblout Pfam-A.hmm potential_VAPs.fasta.transdecoder.pep

# wrap fasta file for proteins
# keep only 'complete' proteins
awk '!/^>/ { printf "%s", $0; n = "\n" } /^>/ { print n $0; n = "" } END { printf "%s", n }' potential_VAPs.fasta.transdecoder.pep > transdecoder_VAPs.pep
grep -A1 "complete" transdecoder_*pep > transdecoder-complete_VAPs.pep
sed -i 's/--//g' transdecoder-complete_VAPs.pep
sed -i '/^$/d' transdecoder-complete_VAPs.pep

exit 0