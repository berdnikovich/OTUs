#!/bin/bash

projectPath="/home/berdnikovich/task"
dataPath="/home/berdnikovich/task/data_min"


mkdir ${projectPath}/trimmed_galoread
mkdir ${projectPath}/trimmedgalore_fastqc
mkdir ${projectPath}/trimmed_trimgalore_vis
### auto-detected adapters

for file in ${projectPath}/trimmed/*_paired.fq.gz
do
    name="fastqc$file"
    trim_galore --gzip --illumina -o ${projectPath}/trimmed_galoread/$basein3 $file
done


for file2 in ${projectPath}/trimmed_galoread/*_trimmed.fq.gz
do
    name="fastqc$file2"
    fastqc --outdir=${projectPath}/trimmedgalore_fastqc $file2 
done

###visualisation multiqc trimgalore trimmed_data
multiqc ${projectPath}/trimmedgalore_fastqc -o ${projectPath}/trimmed_trimgalore_vis