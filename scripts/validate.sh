# Get longest open reading frames from potential VAP hits in 'Schistosoma mansoni' transcriptome
cd tmp/
TransDecoder.LongOrfs -t potential_VAPs.fasta -m 90

cd ..
makeblastdb -in required/uniprot_sprot.fasta -parse_seqids -dbtype prot -out tmp/sprot.db
blastp -query tmp/potential_VAPs.fasta.transdecoder_dir/longest_orfs.pep -db tmp/sprot.db -max_target_seqs 1 -outfmt 6 -evalue 1e-5 -num_threads 6 > tmp/VAP-sprot_hits.blastp

hmmpress required/Pfam-A.hmm > tmp/.
hmmscan --cpu 6 --domtblout tmp/pfam_hits.domtblout tmp/Pfam-A.hmm tmp/potential_VAPs.fasta.transdecoder_dir/longest_orfs.pep

cd tmp
TransDecoder.Predict -t potential_VAPs.fasta --retain_pfam_hits pfam_hits.domtblout --retain_blastp_hits VAP-sprot_hits.blastp 
# TransDecoder.Predict -t potential_VAPs.fasta --retain_pfam_hits pfam_hits.domtblout --retain_blastp_hits VAP-sprot_hits.blastp --train ../data/query.fasta
# mkdir no-train
# mv potential_VAPs.fasta.transdecoder_dir.* no-train/.
# diff potential_VAPs.fasta.transdecoder.pep no-train/potential_VAPs.fasta.transdecoder.pep 
# NO DIFFERENCE

hmmscan --cpu 6 --domtblout tmp/VAP-validate.domtblout data/Pfam-A.hmm tmp/potential_VAPs.fasta.transdecoder.pep
