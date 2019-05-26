# Get longest open reading frames from potential VAP hits in 'Schistosoma mansoni' transcriptome
cd ../tmp/
TransDecoder.LongOrfs -t potential_VAPs.fasta -m 90

makeblastdb -in uniprot_sprot.fasta -parse_seqids -dbtype prot -out sprot.db
blastp -query potential_VAPs.fasta.transdecoder_dir/longest_orfs.pep -db sprot.db -max_target_seqs 1 -outfmt 6 -evalue 1e-5 -num_threads 6 > sprot-hits_VAPs.blastp

hmmpress Pfam-A.hmm
hmmscan --cpu 6 --domtblout pfam-hits_VAPs.domtblout Pfam-A.hmm potential_VAPs.fasta.transdecoder_dir/longest_orfs.pep

TransDecoder.Predict -t potential_VAPs.fasta --retain_pfam_hits pfam-hits_VAPs.domtblout --retain_blastp_hits sprot-hits_VAPs.blastp 
# TransDecoder.Predict -t potential_VAPs.fasta --retain_pfam_hits pfam_hits.domtblout --retain_blastp_hits VAP-sprot_hits.blastp --train ../data/query.fasta
# mkdir no-train
# mv potential_VAPs.fasta.transdecoder_dir.* no-train/.
# diff potential_VAPs.fasta.transdecoder.pep no-train/potential_VAPs.fasta.transdecoder.pep 
# NO DIFFERENCE

exit 0