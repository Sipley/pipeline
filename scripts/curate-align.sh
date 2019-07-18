cd tmp

# Filter out any redundant sequences; identity set to 100%, can lower if you'd like
cd-hit -i transdecoder_VAPs.pep -o transdecoder_VAPs_unique.pep -c 1

# Filter additionally by CRISP domain coverage
# Recommended: Keep only the putative proteins that have at least 75% of the CRSIP domain
# If prefer a different cut-off just adjust comments
# This is specific to CRISP domain; unfortunately, so will need to put in some work to generalize this

# >50%
# awk '($19-$18)>63 {print $4}' s07_redundantRemoved2_557_onlyCRISP.domtblout | uniq > test_moreThan50percentHit_names.txt
#  while read LINE; do grep -wA1 --no-group-separator "$LINE" s07_redundantRemoved2_557.pep; done < test_moreThan50percentHit_names.txt > s07_redundantRemoved2_557_onlyCRISP_moreThan50percentHit.fasta

# >75%
awk '($19-$18)>94 {print $4}' s07_redundantRemoved2_557_onlyCRISP.domtblout | uniq > test_moreThan75percentHit_names.txt
 while read LINE; do grep -wA1 --no-group-separator "$LINE" s07_redundantRemoved2_557.pep; done < test_moreThan75percentHit_names.txt > s07_redundantRemoved2_557_onlyCRISP_moreThan75percentHit.fasta

# >80%
# awk '($19-$18)>100 {print $4}' s07_redundantRemoved2_557_onlyCRISP.domtblout | uniq > test_moreThan80percentHit_names.txt
# while read LINE; do grep -wA1 --no-group-separator "$LINE" s07_redundantRemoved2_557.pep; done < test_moreThan80percentHit_names.txt > s07_redundantRemoved2_557_onlyCRISP_moreThan80percentHit.fasta

# >90%
# awk '($19-$18)>113 {print $4}' s07_redundantRemoved2_557_onlyCRISP.domtblout | uniq > test_moreThan90percentHit_names.txt
# while read LINE; do grep -wA1 --no-group-separator "$LINE" s07_redundantRemoved2_557.pep; done < test_moreThan90percentHit_names.txt > s07_redundantRemoved2_557_onlyCRISP_moreThan90percentHit.fasta

# >95%
# awk '($19-$18)>119 {print $4}' s07_redundantRemoved2_557_onlyCRISP.domtblout | uniq > test_moreThan95percentHit_names.txt
# while read LINE; do grep -wA1 --no-group-separator "$LINE" s07_redundantRemoved2_557.pep; done < test_moreThan95percentHit_names.txt > s07_redundantRemoved2_557_onlyCRISP_moreThan95percentHit.fasta



# mafft  --auto --reorder "transdecoder_VAPs_unique.pep" > "mafft_S-mansoni_VAP.fasta"
# sed 's/.* />/' tmp/mafft_S-mansoni_VAP.fasta | sed 's/(.)//' | sed 's/:.*//' > tmp/mafft_S-mansoni_VAP_clean-names.fasta
