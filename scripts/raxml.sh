 raxmlHPC-AVX2 -f a -m PROTGAMMAAUTO -p 12345 -x 12345 -# 100 -s mafft_S-mansoni_VAP_clean-names.fasta -n AUTO.20-ML-search.1000rbtsp

# nums=`seq 10 10 1000`
# for COUNT in ${nums}
# do
# 	touch tmp/raxml-test/bootstraps/bootstraps_${COUNT}.sh
# 	echo "raxmlHPC-PTHREADS-AVX2 -T 10 -m PROTGAMMAAUTO -s mafft_S-mansoni_VAP_clean-names.fasta -# 10 -p $RANDOM -x $RANDOM -n rapidBootstraps_${COUNT} -w tmp/raxml-test/bootstraps/" > tmp/raxml-test/bootstraps/bootstraps_${COUNT}.sh
# done