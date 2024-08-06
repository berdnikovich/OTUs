#!/bin/bash
module load mothur/1.47
mothur "#make.file(inputdir=fastq, type=gz);"
#outputPath="/home/berdnikovich/task/Stage2"
#dataPath="/home/berdnikovich/task/trimmed_galoread/R1_R2/2group"#_trimmed_fastqc.zip
# stage2 в /home/berdnikovich/task/trimmed_galoread/

#metadata for contigs
make.file(inputdir=/home/berdnikovich/task/trimmed_galoread/R1_R2/2group, type=gz, prefix=stability)

#Output File Names: 
#/home/berdnikovich/task/trimmed_galoread/stability.files
#log Output mothur.1722542798.logfile

#make contigs
make.contigs(file=stability.files)
summary.seqs(fasta=current, count=current)

#summary.seqs(fasta=stability.trim.contigs.fasta, count=stability.contigs.count_table)

#screen.seqs(fasta=stability.trim.contigs.fasta, count=stability.contigs.count_table, maxambig=0, maxlength=417, maxhomop=17)
screen.seqs(fasta=stability.trim.contigs.fasta, count=stability.contigs.count_table, maxambig=0, maxlength=417, maxhomop=8)

summary.seqs(fasta=current, count=current)
unique.seqs(fasta=current, count=current)

summary.seqs(fasta=current, count=current)


##подготовим матрицу для выравниваний! - это вырезает из общего слоя то, что нужно
pcr.seqs(fasta=silva.bacteria.fasta, start=11595, end=25318, keepdots=F)
silva.bacteria.pcr.fasta - это выравнивание 
rename.file(input=silva.bacteria.pcr.fasta, new=silva.v4newbr.fasta)

##выровним с референсом
#align.seqs(fasta=stability.trim.contigs.good.unique.fasta, reference=silva.v4new.fasta)
align.seqs(fasta=stability.trim.contigs.good.unique.fasta, reference=silva.v4newbr.fasta)
out = stability.trim.contigs.good.unique.align
#получаем таблицу

summary.seqs(fasta=current, count=current)# теряется длина до 147
#высеем все, кто не вписался
screen.seqs(fasta=stability.trim.contigs.good.unique.align, count=stability.trim.contigs.good.count_table, start=301, end=13724)
summary.seqs(fasta=current, count=current)
set.current(fasta=stability.trim.contigs.good.unique.good.align)
set.current(count=stability.trim.contigs.good.good.count_table)

# попробуем тот 2 процента отсеять в отдельный файл - потом дообработать этот файл называется stability.trim.contigs.good.unique.bad.accnos

#это удаление концов некартированных
filter.seqs(fasta=stability.trim.contigs.good.unique.good.align, vertical=T, trump=.)
summary.seqs(fasta=stability.trim.contigs.good.unique.good.filter.fasta, count=stability.trim.contigs.good.good.count_table)
#удалили концы - возможно последовательности стали лучше повторяться
unique.seqs(fasta=stability.trim.contigs.good.unique.good.filter.fasta, count=stability.trim.contigs.good.good.count_table)
summary.seqs(fasta=current, count=current)

#удаление шума
pre.cluster(fasta=stability.trim.contigs.good.unique.good.filter.unique.fasta, count=stability.trim.contigs.good.unique.good.filter.count_table, diffs=2)