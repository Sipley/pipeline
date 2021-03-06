# pipeline

## Disclaimer

This was created in partial fulfillment of the requirements for a Scripting for Biologists graduate-level course, which I co-opted to improve the bioinformatics pipeline used in my MS thesis.  I have generalized many parts of this pipeline but in it's current state it's probably only super useful for me.  Check back later for a more generally useful pipeline.

## Purpose

To survey the diversity of Venom Allergen-like Proteins (VAPs) expressed in _Schistosoma mansoni_

## Known dependences

<details><summary>Python3 + modules</summary>

* `biopython` + its dependencies
* `ftplib` (slow)
* `os`

If on mac and have `pip`, you can install all required Python modules with the following:
```bash
python3 -m pip install --user numpy scipy matplotlib ipython jupyter pandas sympy nose
python3 -m pip install --user biopython
python3 -m pip install --user ftplib
python3 -m pip install --user os
python3 -m pip install --user wormbase-parasite
python3 -m pip install --user requests
```

</details>

<details><summary>BLAST+</summary>

#### BLAST+ 2.9.0 executables: ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/ 

After installing, add the BLAST+ executables to your path by inserting the following into your `~/.bash_profile`:
```bash
PATH="/usr/local/ncbi/blast/bin:${PATH}"
export PATH
```

Then exit terminal & re-enter or run `source ~/bash_profile`

#### Optional
* [MagicBlast](https://ncbi.github.io/magicblast/)
* [IgBlast](https://ncbi.github.io/igblast/)

</details>
 
<details><summary>TransDecoder + dependencies</summary>

#### [TransDecoder 5.5.0](https://github.com/TransDecoder/TransDecoder/wiki)

The easiest way to install TransDecoder and many other programs is through `anaconda` (available [here](https://docs.conda.io/projects/conda/en/latest/user-guide/install/index.html "Download miniconda")).

With `anaconda` installed, simply run the following to install the appropriate version of TransDecoder:
```bash
conda config --add channels bioconda
conda install transdecoder=3.0.1 # Do not use most recent version
```

#### [HMMER](http://hmmer.org/)

To install with `anaconda` on mac:
```bash
conda install hmmer
```

#### [Swiss-Prot database](https://www.uniprot.org/downloads) 
#### Pfam database: ftp://ftp.ebi.ac.uk/pub/databases/Pfam/current_release 

</details>

<details><summary>mafft</summary><br>

If on mac, get `mafft` by running:
```bash
conda install -c bioconda mafft 
```

</details>

<details><summary>RAxML</summary>

If on mac, get `RAxML` by running:
```bash
conda install -c bioconda raxml
```

Don't forget to add to your `~/.bash_profile`:
```bash
PATH="/Users/breanna/miniconda3/bin:$PATH"
export PATH
```

</details>

<details><summary>CD-HIT</summary><br>

If on mac, this should work:
```bash
conda install -c bioconda cd-hit 
```

</details>

<details><summary>SignalP</summary><br>

#### [SignalP version 4.1](http://www.cbs.dtu.dk/cgi-bin/nph-sw_request?signalp)

You'll have to install this yourself by requesting an academic download.  Be sure you install the correct version for your system (if not mac `Darwin`).  Please follow instructions carefully and make sure the exectuables are in your PATH; it's important that the file structure of the original download is conserved for `SignalP` to find the correct executables. It is strongly advised that you decompress the tarball for this download in your `/usr/local/bin`

If you downloaded the package to `/usr/local/bin` as sugguested, this should work on Mac to add the executables to your path:
```bash
cp ~/Downloads/signalp-4.1g.Darwin.tar.gz /usr/local/bin/.
cd /usr/local/bin
tar -xvzf ~/Downloads/signalp-4.1g.Darwin.tar.gz
```

Add this new directory to your path in `~/.bash_profile`
```bash
# Adding SignalP
PATH="/usr/local/bin/signalp-4.1:${PATH}"
export PATH
```

YOU MUST READ THE *.readme FILE & change settings in 'signalp' appropriately. Pay special attention to `my $outputDir`---this MUST be writable by ALL users.  Recommended settings:
```bash
# full path to the signalp-4.1 directory on your system (mandatory)
BEGIN {
    $ENV{SIGNALP} = '/usr/local/bin/signalp-4.1';
}

# determine where to store temporary files (must be writable to all users)
my $outputDir = "/var/tmp";
```
</details>

<details><summary>FTP (Optional)</summary><br>

If on mac, get `ftp` by running:
```bash
brew install inetutils
```

</details>

<details><summary>Other programs</summary>

* "Normal" `sed`

If on mac, download by running:
```bash
brew install gnu-sed
```

Don't forget to add to path:
```bash
PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
```

* R

</details>

## Summary

1. Acquire a large dataset of sequences
2. Pull out Gene Family of Interest from all sequences (non-redundant)
3. Infer the best gene tree for your Gene Family of Interest
4. Color best gene tree based on signal peptide predictions
5. Compare average rates of amino acid substitutions

## Step 1: Acquire a large dataset of sequences

### For this tutorial, we will use the publicly available transcriptome of _Schistosoma mansoni_

Please *fork* this repository and clone the directory from your GitHub to your local machine in your home directory `~`. Then cd into the `scripts` directory and run `pipeline.sh` (ignore the warning message):
```bash
git clone https://github.com/<YOUR GITHUB USERNAME>/pipeline.git
cd pipeline
cd tmp

bash scripts/pipeline.sh
```

### Output
1. `data/query.fasta`

	This contains the protein sequence for the only solved structure of a 'Venom allergen-like Protein' from flatworms, to my knowledge. 

2. `data/schistosoma_mansoni.PRJEA36577.WBPS13.CDS_transcripts.fa.gz`

	This is the most recent transcriptome assembly for _Schistosoma mansoni_, which arguably has the most well-annotated genome of all flatworms.


<details><summary>This tutorial can be easily extended to a much larger number of transcriptomes</summary><br>

If you have the needed link, you can download a dataset containing 47 flatworms transcriptomes by running the following code in your terminal:
```bash
mkdir transcriptomes
cd transcriptomes
curl -L <LINK-TO-TRANSCRIPTOMES>?dl=1 > transcriptomes.zip
unzip transcriptomes.zip
rm transcriptomes.zip
```

To confirm that the transcriptomes were downloaded successfully, please run the following code (if you're on a mac and received a `command not found` error, please run `brew install md5sha1sum` and try again): 
```bash
md5sum -c md5sum.txt
```

Your output should look like:
```bash
transcriptomes-MS.tgz: OK
```

If not, the transcriptomes were not downloaded correctly, and you should proceed with extreme caution.

</details>

## Step 2: Pull out Gene Family of Interest from all sequences (non-redundant)

This will run automatically.

### What heppened?

1. Sequences expressed in _Schistosoma mansoni_ that are homologous to the solved structure of _Schistosoma mansoni_ were identified using BLAST+ & saved in a new `tmp/` directory as `potential_VAPs.fasta`
2. Potential VAP sequences were translated to protein and validated as VAPs via CRISP domain presence

## Step 3: Infer the best gene tree for your gene family of interest

This will run automatically.

### What happened?

1. Redudant sequences were removed using 'cd-hit'
2. The VAP protein sequences were aligned using the program 'mafft'
3. Header names were cleaned up
4. RAxML was employed

	b. Maximum likelihood trees inferred from 10 bootstrapped alignments (rapid) under WAG model of protein evolution
	c. ML search for best tree (Fast ML -> Slow ML -> Thorough ML)
	d. Draw Bootstrap Support Valus on best-scoring ML tree

Note: This is for proof-of-concept only; if running this pipeline for publication, you'll want to adjust # of bootstraps & change model to what best fits your data

Outputs:
```bash
RAxML_bestTree.WAG.10bp
RAxML_bipartitions.WAG.10bp
RAxML_bipartitionsBranchLabels.WAG.10bp
RAxML_bootstrap.WAG.10bp
RAxML_info.WAG.10bp
```

Can find some interesting info in `RAxML_info.WAG.10bp`. 

## Step 4: Color best gene tree based on signal peptide predictions

### What happened?

1. Signal peptides were predicted from full protein sequences using SignalP
2. A `.png` file was created with the RAxML tree with signal peptide predictions mapped onto it

You will find a new directory `tmp/` which will contain many files including:

```bash
Pfam-A.hmm					pfam-hits_VAPs.domtblout
Pfam-A.hmm.h3f					pfam-validate_VAPs.domtblout
Pfam-A.hmm.h3i					potential_VAPs.fasta
Pfam-A.hmm.h3m					potential_VAPs.fasta.transdecoder.bed
Pfam-A.hmm.h3p					potential_VAPs.fasta.transdecoder.cds
RAxML_bestTree.WAG.10bp				potential_VAPs.fasta.transdecoder.gff3
RAxML_bipartitions.WAG.10bp			potential_VAPs.fasta.transdecoder.pep
RAxML_bipartitionsBranchLabels.WAG.10bp		potential_VAPs.fasta.transdecoder_dir
RAxML_bootstrap.WAG.10bp			problematic-VAPs.txt
RAxML_info.WAG.10bp				sprot-hits_VAPs.blastp
VAPs.signalp					sprot.db.phr
VAPs.signalp.csv				sprot.db.pin
VAPs_unique_clean-names.fasta			sprot.db.pog
blast.db.nhr					sprot.db.psd
blast.db.nin					sprot.db.psi
blast.db.nog					sprot.db.psq
blast.db.nsd					test_moreThan75percentHit_names.txt
blast.db.nsi					transdecoder-VAP_names.txt
blast.db.nsq					transdecoder-complete_VAPs.pep
blast.tblastn					transdecoder-complete_VAPs_75-percent.pep
blast_hits.fasta				transdecoder_VAPs.pep
contigLure.txt					transdecoder_VAPs_unique.pep
mafft_S-mansoni_VAP.fasta			transdecoder_VAPs_unique.pep.clstr
mafft_S-mansoni_VAP_clean-names.fasta		tree_signalp.png
pfam-CRISP_names.txt				uniprot_sprot.fasta
```

