![nf-core](figures/nf-core-rnaseq.svg)

<h3 align="center">Local RNASeq nf-core Pipeline Run</h3>

---

<p align="center">
This project is designed to run the nf-core RNASeq pipeline locally using Docker. It is a simplified version of the original nf-core RNASeq pipeline, which is designed for use on a high performance cluster. The goal of this project is to provide a quick and easy way to run the pipeline on a local machine for testing and development purposes, but mostly just to learn how to setup and run a Nextflow pipeline on my local machine.
    <br> 
</p>

## Table of Contents

- [Getting Started](#getting-started)
- [Prerequisites](#prerequisites)
- [Installing](#installing)
- [Update the Sample Sheet](#update-the-sample-sheet)
- [Update the run.sh file](#update-the-runsh-file)
- [Run the pipeline](#run-the-pipeline)
- [Acknowledgments](#acknowledgement)

## Getting Started

You will need sequence data in the form of FASTQ files. You can use your own data or download a sample dataset from the [SRA](https://www.ncbi.nlm.nih.gov/sra) or [ENA](https://www.ebi.ac.uk/ena/browser/home). Save the FASTQ files into the reads directory.

A reference genome is also required. You can use your own reference genome or download a sample dataset from the [UCSC Genome Browser](https://genome.ucsc.edu/) or [Ensembl](https://www.ensembl.org/index.html). Save the reference genome into the fasta directory.

Lastly, you will need a GTF file. You can use your own GTF file or download a sample dataset from the [UCSC Genome Browser](https://genome.ucsc.edu/) or [Ensembl](https://www.ensembl.org/index.html). Save the GTF file into the gtf directory.

The pipeline will take care of the rest.

## Prerequisites

- Docker
- Nextflow
- Java 8 or higher
- A local machine with at least 16GB of RAM and decent CPU + some disk space
- Sequence data in the form of FASTQ files added to the `reads` directory
- A reference genome in the form of a FASTA file added to the `fasta` directory
- A GTF file in the form of a GTF file added to the `gtf` directory

## Installing

To get started running this pipeline, first make sure you have Docker installed. You can find this [https://docs.docker.com/get-docker/](https://docs.docker.com/get-docker/).

You also need to have Nextflow installed. You can find this [https://www.nextflow.io/docs/latest/getstarted.html](https://www.nextflow.io/docs/latest/getstarted.html).

To install Nextflow, run the following command:

```bash
curl -s https://get.nextflow.io | bash
```

You will also need to add it to your PATH. You can do this by running the following command:

```bash
echo 'export PATH=$PATH:$(pwd)' >> ~/.bashrc
```

Then, run the following command to make the changes take effect:

```bash
source ~/.bashrc
```

## Update the Sample Sheet

samplesheet.csv contains 4 columns: sample, fastq_1, fastq_2, and strandedness. Change the sample names to match your own samples, and the fastq_1 and fastq_2 columns to match your own FASTQ files. The strandedness column should be set to either "forward" or "reverse" depending on the strandedness of your data.
The sample sheet should look like this:

```csv
sample,fastq_1,fastq_2,strandedness
sample_1,reads/sample_1_R1.fastq.gz,reads/sample_1_R2.fastq.gz,forward
sample_2,reads/sample_2_R1.fastq.gz,reads/sample_2_R2.fastq.gz,reverse
```

## Update the run.sh file

The run.sh file contains the command to run the pipeline. You will need to update your email to receive notifications when the pipeline is finished, as well as ensure that the paths to the reference genome and GTF file are correct. The run.sh file should look like this:

```bash
#!/bin/bash
pwd; hostname; date
nextflow run nf-core/rnaseq -r 3.14.0 \
-resume \
-profile docker \
--input samplesheet.csv \
--outdir "./outdir" \
--fasta "<your_fasta_here>" \
--gtf "<your_gtf_here>" \
--pseudo_aligner salmon \
--gencode \
--email <your_email_here> \
--max_cpus 6 \
--max_memory 10GB \
-c nextflow.config
```

You can also update the number of CPUs and memory to match your own machine. The default is 6 CPUs and 10GB of memory.
A key feature here is the -resume flag, which allows you to resume the pipeline from where it left off in the event that it fails. The pipeline will cache results at each step, preventing data loss.

## Run the pipeline

To run the pipeline, simply run the following commands:

```bash
chmod +x run.sh
```

Then, run the following command:

```bash
./run.sh
```

## Acknowledgement

Huge credit to John Rinn for inspiration and the original setup of this pipeline during our computational genomics lab
at CU Boulder.
