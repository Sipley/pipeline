from methods import getQuery

email='Breanna.Sipley@gmail.com'
db='protein'
term='"venom allergen-like protein" AND "Schistosoma mansoni"[Organism] NOT partial'
path="../data/"
path_to_download_query="../data/"

getQuery(email, db, term, path, path_to_download_query)
