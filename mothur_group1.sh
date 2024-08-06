#!/bin/bash
module load mothur/1.47
mothur "#make.file(inputdir=fastq, type=gz);"
#outputPath="/home/berdnikovich/task/Stage2"
#dataPath="/home/berdnikovich/task/trimmed_galoread/"#_trimmed_fastqc.zip
# stage2 в /home/berdnikovich/task/trimmed_galoread/

#metadata for contigs
#make.file(inputdir=/home/berdnikovich/task/trimmed_galoread, type=gz, prefix=stability)

#Output File Names: 
#/home/berdnikovich/task/trimmed_galoread/stability.files
#log Output mothur.1722542798.logfile

#make contigs
#make.contigs(file=stability.files)

#summary.seqs(fasta=stability.trim.contigs.fasta, count=stability.contigs.count_table)

##screen.seqs(fasta=stability.trim.contigs.fasta, count=stability.contigs.count_table, maxambig=0, maxlength=275, maxhomop=8)
summary.seqs(fasta=current, count=current)
unique.seqs(fasta=current, count=current)

summary.seqs(fasta=current, count=current)
#попробуем один контиг 
align.seqs(fasta=group2.fasta, reference=silva.bacteria.fasta)
#получился shit

##подготовим матрицу для выравниваний! - это вырезает из общего слоя то, что нужно
pcr.seqs(fasta=silva.bacteria.fasta, start=11895, end=25318, keepdots=F)
silva.bacteria.pcr.fasta - это выравнивание 
rename.file(input=silva.bacteria.pcr.fasta, new=silva.v4.fasta)

##выровним с референсом
align.seqs(fasta=stability.trim.contigs.good.unique.fasta, reference=silva.v4.fasta)
out = stability.trim.contigs.good.unique.align
#получаем таблицу

summary.seqs(fasta=current, count=current)
#высеем все, кто не вписался
screen.seqs(fasta=stability.trim.contigs.good.unique.align, count=stability.trim.contigs.good.count_table, start=1968, end=11550)
# попробуем тот 2 процента отсеять в отдельный файл - потом дообработать этот файл называется stability.trim.contigs.good.unique.bad.accnos

#это удаление концов некартированных
filter.seqs(fasta=stability.trim.contigs.good.unique.good.align, vertical=T, trump=.)

#удалили концы - возможно последовательности стали лучше повторяться
unique.seqs(fasta=stability.trim.contigs.good.unique.good.filter.fasta, count=stability.trim.contigs.good.good.count_table)
summary.seqs(fasta=current, count=current)

#удаление шума
pre.cluster(fasta=stability.trim.contigs.good.unique.good.filter.unique.fasta, count=stability.trim.contigs.good.unique.good.filter.count_table, diffs=2)