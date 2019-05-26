cd ../

# make BLAST+ database (what you want to BLAST+ your query to)
# BLAST+ your query against your BLAST+ database
makeblastdb -in data/*fa -parse_seqids -dbtype nucl -out tmp/blast.db
tblastn -query data/query.fasta -db tmp/blast.db -evalue 1e-3 -out tmp/blast.tblastn -num_threads 6 -outfmt 6

# Use BLAST+ output to determine IDs of BLAST+ hits
# Pull out the sequences for your BLAST+ hits
# Tidy up FASTA file output (wrap seq lines)
awk -F "\t" '{print $2}' tmp/blast.tblastn | sort | uniq > tmp/contigLure.txt
perl scripts/select_contigs.pl -n tmp/contigLure.txt data/*.fa tmp/blast_hits.fasta