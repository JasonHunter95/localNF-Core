#!/bin/bash
pwd; hostname; date
nextflow run nf-core/rnaseq -r 3.14.0 \
-resume \
-profile docker \
--input samplesheet.csv \
--outdir "./outdir" \
--fasta "./fasta/GRCm38.p6.genome.fa" \
--gtf "./gtf/gencode.vM25.annotation.gtf" \
--pseudo_aligner salmon \
--gencode \
--email jahu8701@colorado.edu \
--max_cpus 6 \
--max_memory 10GB \
-c nextflow.config