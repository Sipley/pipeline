# Get longest open reading frames from potential VAP hits in 'Schistosoma mansoni' transcriptome
cd tmp/
TransDecoder.LongOrfs -t potential_VAPs.fasta -m 90

cd ..
makeblastdb -in data/uniprot_sprot.fasta -parse_seqids -dbtype prot -out tmp/sprot.db
blastp -query tmp/potential_VAPs.fasta.transdecoder_dir/longest_orfs.pep -db tmp/sprot.db -max_target_seqs 1 -outfmt 6 -evalue 1e-5 -num_threads 6 > tmp/VAP-sprot_hits.blastp

hmmpress data/Pfam-A.hmm
hmmscan --cpu 6 --domtblout tmp/pfam_hits.domtblout data/Pfam-A.hmm tmp/potential_VAPs.fasta.transdecoder_dir/longest_orfs.pep

cd tmp
TransDecoder.Predict -t potential_VAPs.fasta --retain_pfam_hits pfam_hits.domtblout --retain_blastp_hits VAP-sprot_hits.blastp 
TransDecoder.Predict -t tmp/TransDecoder/longest_orfs.pep --retain_pfam_hits tmp/pfam_hits.domtblout --retain_blastp_hits tmp/VAP-sprot_hits.blastp --train data/query.fasta

hmmscan --cpu 6 --domtblout train/s07_redundantRemoved2_557.domtblout bait/Pfam-A.hmm \
train/s07_redundantRemoved2_557.pep
