# Make a data & tmp folder that will hold retrieved data & intermediate files
# Enter 'scripts' directory
# mkdir tmp
# mkdir data
cd scripts

# Download required databases
# python3 get_databases.py
# if ls ../tmp/*gz &>/dev/null
# then
# 	gunzip ../tmp/*
# 	echo 'Done getting current versions of required databases'
# else
# 	echo 'There was an issue retrieving required databases. Exiting...'
# 	exit 1
# fi

# Download query sequence of interest from GenBank
# python3 get_query.py

# # Download transcriptome(s)/genome(s) of interest from wormbase ParaSite
# # wormbase ParaSite (WBPS) is the largest, most current database of all things parasitic worms
# python3 get_transcriptome.py
# gunzip ../data/*gz

# # BLAST query against transcriptomes(s)/genome(s) of interest
# bash blast.sh
# tidy=`awk '!/^>/ { printf "%s", $0; n = "\n" } /^>/ { print n $0; n = "" } END { printf "%s", n }'`
# $tidy tmp/blast_hits.fasta > tmp/potential_VAPs.fasta
