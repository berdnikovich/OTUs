#!/bin/bash

projectPath="/home/berdnikovich/task"
dataPath="/home/berdnikovich/task/data"

##dir creation
mkdir ${projectPath}/fastqc
mkdir ${projectPath}/row_vis
mkdir ${projectPath}/trimmed
mkdir ${projectPath}/trimmed/log
mkdir ${projectPath}/trimmed_vis
mkdir ${projectPath}/trimmed_fastqc

###

##fastqc

for file in $dataPath/*.fastq
do
    name="fastqc$file"
    fastqc --outdir=${projectPath}/fastqc $file 
done

###visualisation multiqc row_data
multiqc ${projectPath}/fastqc -o ${projectPath}/row_vis

#####trim tails 
basein1="a"
for file1 in $dataPath/*.fastq
do
    basein1=${file1%_*}
    basein3=${basein1#*$dataPath/}
    if [[ "$basein3" != "$basein2" ]]; then
        java -jar trimmomatic-0.39.jar PE -trimlog ${projectPath}/trimmed/log/log_${basein3} ${dataPath}/${basein3}_1.fastq ${dataPath}/${basein3}_2.fastq ${projectPath}/trimmed/${basein3}_forward_paired.fq.gz ${projectPath}/trimmed/${basein3}_forward_unpaired.fq.gz ${projectPath}/trimmed/${basein3}_reverse_paired.fq.gz ${projectPath}/trimmed/${basein3}_reverse_unpaired.fq.gz SLIDINGWINDOW:4:20 MINLEN:100
        basein2=$basein3
    fi
done
##Trim_Galore - optioned

##trimmed-fastqc
for file in ${projectPath}/trimmed/*_paired.fq.gz
do
    name="fastqc$file"
    fastqc --outdir=${projectPath}/trimmed_fastqc $file 
done

###visualisation multiqc trimmed_data
multiqc ${projectPath}/trimmed_fastqc -o ${projectPath}/trimmed_vis