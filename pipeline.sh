# Make a data & tmp folder that will hold retrieved data & intermediate files
# Enter 'scripts' directory
# mkdir tmp
# mkdir data
cd scripts

# ##########################################################################
# # STEP 1
# ##########################################################################

# #### # Download required databases  #   
# python3 get_databases.py # uncomment if prefer to use python
# # bash get_databases.sh # comment if prefer to use python
# if ls ../tmp/*gz &>/dev/null
# then
# 	gunzip ../tmp/*
# 	echo 'Done getting current versions of required databases'
# else
# 	echo 'There was an issue retrieving required databases. Exiting...'
# 	exit 1
# fi

# #### # Download query sequence of interest from GenBank  #   
# python3 get_query.py
# file="../data/query_672885886.fasta"
# if [ -s "$file" ] 
# then
# 	echo "Moving on..."
# else
# 	echo "$file is empty. Aborting..."
# 	exit 1
# fi

# #### # Download transcriptome(s)/genome(s) of interest from wormbase ParaSite  # 
# # # wormbase ParaSite (WBPS) is the largest, most current database of all things parasitic worms #  
# python3 get_transcriptome.py
# if ls ../data/*gz &>/dev/null
# then
# 	gunzip ../data/*
# 	echo 'Done with STEP 1! Moving on to STEP 2...'
# 	# echo 'Done with STEP 1! Would you like to go proceed to STEP 2? (yes/no)'
# 	# read varname
# else
# 	echo 'There was an issue retrieving transcriptome. Exiting...'
# 	exit 1
# fi

# ##########################################################################
# # STEP 2
# ##########################################################################

# BLAST query against transcriptomes(s)/genome(s) of interest
bash blast.sh
FILE=../tmp/potential_VAPs.fasta
if [ -f "$FILE" ]
then
	echo 'BLAST+ successfully completed'
else
	echo 'There was an issue with BLAST+'
	exit 1
fi

# Translate potential VAP hits to protein
bash transdecoder.sh
FILE=../tmp/potential_VAPs.fasta.transdecoder.pep 
if [ -f "$FILE" ]
then
	echo 'Successfully translated VAPs'
else
	echo 'There was an issue with TransDecoder'
	exit 1
fi

# Validate VAPs
bash validate.sh

# # Align VAPs
# # unique
# cd tmp
# cd-hit -i transdecoder_VAPs.pep -o transdecoder_VAPs_unique.pep -c 1
# mafft  --auto --reorder "transdecoder_VAPs_unique.pep" > "mafft_S-mansoni_VAP.fasta"
# sed 's/.* />/' tmp/mafft_S-mansoni_VAP.fasta | sed 's/(.)//' | sed 's/:.*//' > tmp/mafft_S-mansoni_VAP_clean-names.fasta
# # Build RAxML tree

