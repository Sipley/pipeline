make_blastdb.py

python3 -m pip install --user wormbase-parasite
python3 -m pip install --user requests
python3

'''
import urllib.request as urllib2
response = urllib2.urlopen('https://parasite.wormbase.org/ftp.html')
html = response.read()
'''

import wormbase_parasite