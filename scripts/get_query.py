# transcriptome to gene tree tutorial

# Install necessary & optional biopython dependencies
# python -m pip install --user numpy scipy matplotlib ipython jupyter pandas sympy nose
# python3 -m pip install --user numpy scipy matplotlib ipython jupyter pandas sympy nose
# python3 -m pip install --user ReportLab
# python3 -m pip install --user biopython

#Set-up
#python3
import Bio
#print(Bio.__version__)
from Bio import Entrez
from Bio import SeqIO
import os
Entrez.email = 'Breanna.Sipley@gmail.com'

''' Explore Entrez
databases = Entrez.einfo()
db = Entrez.einfo(db="protein")
descr = Entrez.read(db)
print(descr["DbInfo"].keys())
print(descr["DbInfo"]["Count"])
print(descr["DbInfo"]["LastUpdate"])
'''

# Get VAP sequence query
handle = Entrez.esearch(db="protein", term='"venom allergen-like protein" AND "Schistosoma mansoni"[Organism] NOT partial', retmax='100')
record = Entrez.read(handle)\
# record["Count"]
id=record["IdList"]
handle2 = Entrez.efetch(db="protein", id=id, rettype="gb", retmode="text")
# print(handle2.read())
idStr = id[0]
filename = "%s.gbk" % idStr

if not os.path.isfile(filename):
	net_handle = Entrez.efetch(db="protein", id=id, rettype="gb", retmode="text")
	out_handle = open(filename, "w")
	out_handle.write(net_handle.read())
	out_handle.close()
	net_handle.close()
	#print("Saved")

#print("Parsing...")
record = SeqIO.read(filename, "genbank")
#print(record)
query = record.format("fasta")
print(query)





