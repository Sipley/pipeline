# pipeline

## Disclaimer

This was created in partial fulfillment of the requirements for a Scripting for Biologists graduate-level course, which I co-opted to improve the bioinformatics pipeline used in my MS thesis.  As such, it's probably only useful for me.

## Purpose

To survey the diversity of Venom Allergen-like Proteins (VAPs) across flatworm diversity

## Summary

1. Acquire 47 flatworms transcriptomes
2. Pull out predicted VAPs from all 47 transcriptomes (non-redundant)
3. Infer the best gene tree for VAPs
4. Test prediction that there are two main groups of VAPs, one of which is secretory and one of which is intracellular
5. Test prediction that rates of amino acid substitutions in secretory VAPs is greater on average than in intracellular VAPs 

## Step 1: Acquire 47 flatworm transcriptomes

NOTE: These transcriptomes are private, and the link to access them will only be provided for the instructors of this course.

If you are one of the instructors of this course, please run the following code in your terminal.

```bash
mkdir transcriptomes
cd transcriptomes
curl -L <link to transcriptomes>?dl=1 > transcriptomes.zip
unzip transcriptomes.zip
rm transcriptomes.zip
```
