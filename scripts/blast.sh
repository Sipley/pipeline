cd ../

# make BLAST+ database (what you want to BLAST+ your query to)
makeblastdb -in data/*fa -parse_seqids -dbtype nucl -out tmp/blast.db

# BLAST+ your query against your BLAST+ database
tblastn -query data/query.fasta -db tmp/blast.db -evalue 1e-3 -out tmp/blast.tblastn -num_threads 6 -outfmt 6

# Use BLAST+ output to determine IDs of BLAST+ hits
awk -F "\t" '{print $2}' tmp/blast.tblastn | sort | uniq > tmp/contigLure.txt

# Pull out the sequences for your BLAST+ hits
perl scripts/select_contigs.pl -n tmp/contigLure.txt data/*.fa tmp/blast_hits.fasta

# Tidy up FASTA file output (wrap seq lines)
awk '!/^>/ { printf "%s", $0; n = "\n" } /^>/ { print n $0; n = "" } END { printf "%s", n }' tmp/blast_hits.fasta > tmp/potential_VAPs.fasta