# pipeline

## Disclaimer

This was created in partial fulfillment of the requirements for a Scripting for Biologists graduate-level course, which I co-opted to improve the bioinformatics pipeline used in my MS thesis.  As such, it's probably only useful for me.

## Purpose

To survey the diversity of Venom Allergen-like Proteins (VAPs) across flatworm diversity

## Summary

1. Acquire a large dataset of sequences
2. Pull out Gene Family of Interest from all sequences (non-redundant)
3. Infer the best gene tree for your Gene Family of Interest
4. Color best gene tree based on signal peptide predictions
5. Compare average rates of amino acid substitutions

## Step 1: Acquire a large dataset of sequences

### For this tutorial, we will use a database that consists of 47 transcriptomes from flatworms

NOTE: These transcriptomes are private, and the link to access them will only be provided to the instructors of this course.

Download the dataset of interest by running the following code in your terminal.

```bash
mkdir transcriptomes
cd transcriptomes
curl -L <link to transcriptomes>?dl=1 > transcriptomes.zip
unzip transcriptomes.zip
rm transcriptomes.zip
```

To confirm that the transcriptomes were downloaded successfully, please run the following code:
```bash
md5sum -c md5sum.txt
```
NOTE: if you're on a mac and received a 'command not found' error, please run 'brew install md5sha1sum' and try again).

Your output should look like
```bash
transcriptomes-MS.tgz: OK
```

If not, the transcriptomes were not downloaded correctly, and you should proceed with extreme caution.

You will also need a file that contains sequences for your Gene Family of Interest.

In this example, our Gene Family of Interest is Venom Allergen-like Proteins (VAPs).  You can download these files using
```bash
