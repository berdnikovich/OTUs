#merge files from 3 group
#work_dir=/home/berdnikovich/task/Stage2
#you should mv all files from previous dirs for groups, including .map format, *.preclaster.fasta, *.preclaster.count_table - rename them 
merge.files(input=group1.precluster.count_table-group2.precluster.count_table-group3.precluster.count_table, output=stability.trim.contigs.good.unique.good.filter.unique.precluster.count_table)

merge.files(input=group1.precluster.fasta-group2.precluster.fasta-group3.precluster.fasta, output=stability.trim.contigs.good.unique.good.filter.unique.precluster.fasta)

#это не работает
#work_dir=/home/berdnikovich/task/Stage2
#you should mv all files from previous dirs for groups, including stability.trim.contigs.good.unique.good.filter.count_table stability.trim.contigs.good.unique.good.filter.unique.fasta- rename them

merge.count(count=1group.count_table-2group.count_table-3group.count_table, output=stability.trim.contigs.good.unique.good.filter.count_table)
merge.files(input=1group.fasta-2group.fasta-3group.fasta, output=stability.trim.contigs.good.unique.good.filter.unique.fasta)

#по количеству уникальных последовательностей совпадает с суммой - мне не нра этот факт
unique.seqs(fasta=current, count=current)
#не работает
#удаление шума
pre.cluster(fasta=stability.trim.contigs.good.unique.good.filter.unique.fasta, count=stability.trim.contigs.good.unique.good.filter.count_table, diffs=2)
# удаление химер
chimera.vsearch(fasta=stability.trim.contigs.good.unique.good.filter.unique.precluster.fasta, count=stability.trim.contigs.good.unique.good.filter.unique.precluster.count_table, dereplicate=t)
#классификация
classify.seqs(fasta=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.fasta, count=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.count_table, reference=trainset19_072023.pds.fasta, taxonomy=trainset19_072023.pds.tax)
#удаление ненужного - есть ощущения, что можно построить дерево по stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pds.wang.tax.summary
remove.lineage(fasta=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.fasta, count=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.count_table, taxonomy=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pds.wang.taxonomy, taxon=Chloroplast-Mitochondria-unknown-Archaea-Eukaryota)
summary.seqs(fasta=current, count=current)
