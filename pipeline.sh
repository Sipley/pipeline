# Make a data & tmp folder that will hold retrieved data & intermediate files
# Enter 'scripts' directory
mkdir tmp
mkdir data
cd scripts

####################################################################
#### # Download required databases # ###############################  
# Databases current as of 2019-07-17 are incl in 'databases/'      #
# Uncomment below only if these are now out of date                #
#################################################################### 
python3 get_databases.py
# if ls ../databases/*gz &>/dev/null
# then
# 	gunzip ../databases/*
# 	echo 'Done getting current versions of required databases'
# else
# 	echo 'There was an issue retrieving required databases. Exiting...'
# 	exit 1
# fi
####################################################################
# If you uncommented the box above, then comment the box below     #
####################################################################
# gunzip ../databases/*
####################################################################
####################################################################

# # Download query sequence of interest from GenBank
# python3 get_query.py

# # Download transcriptome(s)/genome(s) of interest from wormbase ParaSite
# # wormbase ParaSite (WBPS) is the largest, most current database of all things parasitic worms
# python3 get_transcriptome.py
# if ls ../data/*gz &>/dev/null
# then
# 	gunzip ../data/*
# 	echo 'Done getting transcriptome of interest'
# else
# 	echo 'There was an issue retrieving transcriptome. Exiting...'
# 	exit 1
# fi

# # BLAST query against transcriptomes(s)/genome(s) of interest
# bash blast.sh
# FILE=../tmp/potential_VAPs.fasta
# if [ -f "$FILE" ]
# then
# 	echo 'BLAST+ successfully completed'
# else
# 	echo 'There was an issue with BLAST+'
# 	exit 1
# fi

# # Translate potential VAP hits to protein
# # bash transdecoder.sh
# FILE=../tmp/potential_VAPs.fasta.transdecoder.pep 
# if [ -f "$FILE" ]
# then
# 	echo 'Successfully translated VAPs'
# else
# 	echo 'There was an issue with TransDecoder'
# 	exit 1
# fi

# # Validate VAPs
# bash validate.sh

# # Align VAPs
# # unique
# cd tmp
# cd-hit -i transdecoder_VAPs.pep -o transdecoder_VAPs_unique.pep -c 1
# mafft  --auto --reorder "transdecoder_VAPs_unique.pep" > "mafft_S-mansoni_VAP.fasta"
# sed 's/.* />/' tmp/mafft_S-mansoni_VAP.fasta | sed 's/(.)//' | sed 's/:.*//' > tmp/mafft_S-mansoni_VAP_clean-names.fasta
# # Build RAxML tree

