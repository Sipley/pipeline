from Bio import SeqIO
from Bio.Blast import NCBIWWW
my_query = SeqIO.read("query.fasta", format="fasta")
result_handle = NCBIWWW.qblast("tblastn", "prot", my_query.seq)
blast_result = open("my_blast.xml", "w")
blast_result.write(result_handle.read())
blast_result.close()
result_handle.close()