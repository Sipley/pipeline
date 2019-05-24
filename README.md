# pipeline

## Disclaimer

This was created in partial fulfillment of the requirements for a Scripting for Biologists graduate-level course, which I co-opted to improve the bioinformatics pipeline used in my MS thesis.  I have generalized many parts of this pipeline but in it's current state it's probably only super useful for me.  Check back later for a more generally useful pipeline.

## Purpose

To survey the diversity of Venom Allergen-like Proteins (VAPs) expressed in _Schistosoma mansoni_

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

NOTE: Said transcriptomes are private as many of them are currently unpublished, and the link to access them will only be provided to the instructors of this course.  However, check back after the associated manuscript is published.

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
NOTE: if you're on a mac and received a `command not found` error, please run `brew install md5sha1sum` and try again).

Your output should look like:
```bash
transcriptomes-MS.tgz: OK
```
If not, the transcriptomes were not downloaded correctly, and you should proceed with extreme caution. 
