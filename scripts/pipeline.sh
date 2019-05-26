# Make a tmp folder that will hold intermediate files & inter 'scripts' directory
mkdir ../tmp
# cd scripts

# Download query sequence of interest from GenBank
python3 get_query.py > ../data/query.fasta

# Download transcriptome(s)/genome(s) of interest from wormbase ParaSite
# wormbase ParaSite (WBPS) is the largest, most current database of all things parasitic worms
python3 get_transcriptome.py
gunzip ../data/*gz

# BLAST query against transcriptomes(s)/genome(s) of interest
bash blast.sh

