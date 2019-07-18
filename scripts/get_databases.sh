#!/bin/bash
cd ../tmp/
HOST='ftp.expasy.org'
USER='anonymous'
PASSWD='breanna.sipley@gmail.com'

ftp -n -v $HOST << EOT
ascii
user $USER $PASSWD
prompt
binary
cd databases/uniprot/current_release/knowledgebase/complete/
get uniprot_sprot.fasta.gz
bye
EOT

HOST='ftp.ebi.ac.uk'
USER='anonymous'
PASSWD='breanna.sipley@gmail.com'

ftp -n -v $HOST << EOT
ascii
user $USER $PASSWD
prompt
binary
cd pub/databases/Pfam/current_release/
get Pfam-A.hmm.gz
bye
EOT