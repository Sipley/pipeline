from methods import getWormParaSiteData

species='Schistosoma mansoni'
path='../data'

getWormParaSiteData(species, path)

# def getWormParaSiteData(species, path=None):

# 	api = wormbase_parasite.WormbaseClient()
# 	dict=api.get_info_for_taxonomy_node(species)[0]
# 	species_id=dict['species']
# 	species_list=species_id.split('_')
# 	species=species_list[0]+'_'+species_list[1]
# 	id=species_list[2].upper()
# 	version=api.get_release_info()["wbps_release"]
# 	release='WBPS'+version

# 	server='ftp://ftp.ebi.ac.uk/pub/databases/wormbase/parasite/releases/'
# 	ext='%s/species/%s/%s/' % (release, species, id)
# 	filename='%s.%s.%s.CDS_transcripts.fa.gz' % (species, id, release)
# 	url=server+ext+filename

# 	if path:
# 		os.chdir(path)

# 	with urllib.request.urlopen(url) as response, open(filename, 'wb') as out_file:
# 		data = response.read()
# 		out_file.write(data)
