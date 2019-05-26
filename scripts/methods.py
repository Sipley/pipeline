from ftplib import FTP
from Bio import Entrez
from Bio import SeqIO
import os
from urllib.error import HTTPError
import time

def getQuery(email, db, term, path=None, path_to_download_query=None):
	# Get ID for query of interest
	Entrez.email = email
	handle = Entrez.esearch(db=db, term=term, retmax='100')
	record = Entrez.read(handle)
	id=record['IdList']

	# Save query
	idStr = id[0]
	filename = "%squery_%s.fasta" % (path, idStr)

	count = int(record["Count"])
	batch_size = 3
	out_handle = open(filename, 'w')
	for start in range(0, count, batch_size):
		end = min(count, start+batch_size)
		print("Going to download record %i to %i" % (start+1, end))
		attempt = 0
		while attempt < 10:
			attempt += 1
			try:
				net_handle = Entrez.efetch(db=db, id=id, rettype="fasta", retmode="text")
			except HTTPError as err:
				if 500 <= err.code <= 599:
					print("Received error from server %s" % err)
					print("Attempt %i of 10" % attempt)
					time.sleep(15)
				else:
					raise
		if net_handle:
			out_handle.write(net_handle.read())
			net_handle.close()
		else:
			return print("Sorry, but NCBI is too busy right now. This isn't your fault. Please try again later from the 'get_query' step.")
	out_handle.close()

	return print("Query successfully downloaded as '%s'" % filename)


def getFTP(server, filename, path=None, path_to_download_file=None):

	# Connect to server
	print("Connecting to server '%s'..." % server)
	ftp=FTP(server)
	
	# Login to server anonymously
	print("Logging in...")
	try:
		ftp.login()
	except ValueError:
		return print("ERROR: are you sure you have access to '%s'?" % server)

	# Follow path to desired file if necessary
	if path:
		print("Locating '%s'..." % filename)
		try:
			ftp.cwd(path)
		except ValueError:
			return print("ERROR: are you sure '%s' is the right path to '%s'?" % (path, filename))
	
	# Prepare to retrieve file
	print("Preparing to download '%s'..." % filename)
	try:
		localfile = open(path_to_download_file + filename, 'wb')
	except FileNotFoundError:
		return print("ERROR: are you sure '%s' is the right path?" % path_to_download_file)

	# Retrieve file
	print("Downloading '%s'...\n This may take a minute..." % filename)
	try:
		ftp.retrbinary('RETR ' + filename, localfile.write, 1024)
	except ValueError:
		return print("ERROR: are you sure '%s' exists there?" % filename)
	except KeyboardInterrupt:
		return print("ERROR: looks like you aborted mission ¯\_(ツ)_/¯")
	
	# Finish up
	ftp.quit()
	localfile.close()
	return print("SUCCESS: '%s' downloaded to '%s'!" % (filename, path_to_download_file))