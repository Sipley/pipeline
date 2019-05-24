#python3 -m pip install --user wormbase-parasite
#python3 -m pip install --user requests
#python3


import wormbase_parasite
import requests
import urllib
import os
from ftplib import FTP

api = wormbase_parasite.WormbaseClient()
species=''
species='Schistosoma_mansoni'
dict=api.get_info_for_taxonomy_node(species)[0]
species_id=dict['species']
species_list=species_id.split('_')
species=species_list[0]+'_'+species_list[1]
id=species_list[2].upper()
version=api.get_release_info()["wbps_release"]
release='WBPS'+version

server='ftp://ftp.ebi.ac.uk/pub/databases/wormbase/parasite/releases/'
ext='%s/species/%s/%s/' % (release, species, id)
filename='%s.%s.%s.CDS_transcripts.fa.gz' % (species, id, release)
url=server+ext+filename

os.chdir('../data')
with urllib.request.urlopen(url) as response, open(filename, 'wb') as out_file:
	data = response.read()
	out_file.write(data)