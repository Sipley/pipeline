# pipeline

## Disclaimer

This was created in partial fulfillment of the requirements for a Scripting for Biologists graduate-level course, which I co-opted to improve the bioinformatics pipeline used in my MS thesis.  I have generalized many parts of this pipeline but in it's current state it's probably only super useful for me.  Check back later for a more generally useful pipeline.

## Purpose

To survey the diversity of Venom Allergen-like Proteins (VAPs) expressed in _Schistosoma mansoni_

## Known dependences

* Python3

* <details><summary>Python modules</summary>

	- biopython + its dependencies
	- ftplib (slow)
	- os

	If on mac and have `pip`, you can install all required Python modules with the following:
	```bash
	python3 -m pip install --user numpy scipy matplotlib ipython jupyter pandas sympy nose
	python3 -m pip install --user biopython
	python3 -m pip install --user ftplib
	python3 -m pip install --user os
	```
</details>

* BLAST+ 

	- BLAST+ 2.9.0 executables: ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/ 
  
    	> After installing, add the BLAST+ executables to your path by inserting the following into your `~/.bash_profile`:
    	> ```
    	> PATH="/usr/local/ncbi/blast/bin:${PATH}"
    	> export PATH
    	> ```
    	> Then exit terminal & re-enter or run `source ~/bash_profile`
  
	- [MagicBlast](https://ncbi.github.io/magicblast/) (OPTIONAL)
	- [IgBlast](https://ncbi.github.io/igblast/) (OPTIONAL)
  
* TransDecoder

 	- [TransDecoder 5.5.0](https://github.com/TransDecoder/TransDecoder/wiki)

 		The easiest way to install TransDecoder and many other programs is through `anaconda` (available [here](https://docs.conda.io/projects/conda/en/latest/user-guide/install/index.html "Download miniconda")).

 		With `anaconda` installed, simply run the following to install the appropriate version of TransDecoder:
		```bash
		conda config --add channels bioconda
		conda install transdecoder=3.0.1 # Do not use most recent version
		```
 	- [HMMER](http://hmmer.org/)

		To install with `anaconda` on mac:
		```bash
		conda install hmmer
		```
	- [Swiss-Prot database](https://www.uniprot.org/downloads) (INCLUDED)
	- Pfam database: ftp://ftp.ebi.ac.uk/pub/databases/Pfam/current_release (INCLUDED)

* `ftp` (OPTIONAL)

		If on mac, get `ftp` by running:
		```bash
		brew install inetutils
		```

* other programs

## Summary

1. Acquire a large dataset of sequences
2. Pull out Gene Family of Interest from all sequences (non-redundant)
3. Infer the best gene tree for your Gene Family of Interest
4. Color best gene tree based on signal peptide predictions
5. Compare average rates of amino acid substitutions

## Step 1: Acquire a large dataset of sequences

### For this tutorial, we will use the publicly available transcriptome of _Schistosoma mansoni_

We're actually going to use the pipeline itself to generate our datasets.

Please *fork* this repository and clone the directory from your GitHub to your local machine. Then cd into the `scripts` directory and run `pipeline.sh` (ignore the warning message):
```bash
git clone https://github.com/<YOUR GITHUB USERNAME>/pipeline.git
cd pipeline/data
bash pipeline.sh
```

*Output:* two files in `data/`:
1. `query.fasta`

	This contains the protein sequence for the only solved structure of a 'Venom allergen-like Protein' from flatworms, to my knowledge. 

2. `schistosoma_mansoni.PRJEA36577.WBPS13.CDS_transcripts.fa.gz`

	This is the most recent transcriptome assembly for _Schistosoma mansoni_, which arguably has the most well-annotated genome of all flatworms.


### This tutorial can be easily extended to a much larger number of transcriptomes

> NOTE: Said transcriptomes are private as many of them are currently unpublished, and the link to access them will only be provided to the instructors of this course.  However, check back after the associated manuscript is published.

Download the dataset of interest by running the following code in your terminal:
```bash
mkdir transcriptomes
cd transcriptomes
curl -L <LINK-TO-TRANSCRIPTOMES>?dl=1 > transcriptomes.zip
unzip transcriptomes.zip
rm transcriptomes.zip
```

To confirm that the transcriptomes were downloaded successfully, please run the following code: 
```bash
md5sum -c md5sum.txt
```
> NOTE: if you're on a mac and received a `command not found` error, please run `brew install md5sha1sum` and try again).

Your output should look like:
```bash
transcriptomes-MS.tgz: OK
```
If not, the transcriptomes were not downloaded correctly, and you should proceed with extreme caution. 

## Step 2: Pull out Gene Family of Interest from all sequences (non-redundant)

This will run automatically.

What heppened?
1. Sequences expressed in _Schistosoma mansoni_ that are homologous to the solved structure of _Schistosoma mansoni_ were identified using BLAST+ & saved in a new `tmp/` directory as `potential_VAPs.fasta`
2.   

You will find a new directory `tmp/` which will contain many files including:
```bash
672885886.gbk		blast.db.nog		blast.db.nsq		contigLure.txt
blast.db.nhr		blast.db.nsd		blast.tblastn		potential_VAPs.fasta
blast.db.nin		blast.db.nsi		blast_hits.fasta
```
