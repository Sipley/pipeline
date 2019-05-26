from methods import getFTP

server='ftp.expasy.org'
filename='uniprot_sprot.fasta.gz'
path='databases/uniprot/current_release/knowledgebase/complete/'
path_to_download_file='../tmp/'

try:
	getFTP(server, filename, path, path_to_download_file)
except:
	print("ERROR: could not download Uniprot database")

server='ftp.ebi.ac.uk'
filename='Pfam-A.hmm.gz'
path='pub/databases/Pfam/current_release/'
path_to_download_file='../tmp/'

try:
	getFTP(server, filename, path, path_to_download_file)
except:
	print("ERROR: could not download Pfam database")
