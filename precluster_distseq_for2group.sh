#work_dir=~/task/trimmed_galoread/R1_R2/2group

#pre.cluster(fasta=stability.trim.contigs.good.unique.good.filter.unique.fasta, count=stability.trim.contigs.good.unique.good.filter.count_table, diffs=2)
#сделано до group2.precluster.fasta roup2.precluster.count_table
mv /home/berdnikovich/task/Stage2/trainset19_072023.pds.fasta ~/task/trimmed_galoread/R1_R2/2group/.
mv /home/berdnikovich/task/Stage2/trainset19_072023.pds.tax ~/task/trimmed_galoread/R1_R2/2group/.
# удаление химер
chimera.vsearch(fasta=group2.precluster.fasta, count=group2.precluster.count_table, dereplicate=t)

summary.seqs(fasta=current, count=current)

#классификация
classify.seqs(fasta=current, count=current, reference=trainset19_072023.pds.fasta, taxonomy=trainset19_072023.pds.tax)

#удаление ненужного - есть ощущения, что можно построить дерево по stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pds.wang.tax.summary
remove.lineage(fasta=current, count=current, taxonomy=current, taxon=Chloroplast-Mitochondria-unknown-Archaea-Eukaryota)
summary.seqs(fasta=current, count=current)

set.current(processors=8, count=group2.precluster.denovo.vsearch.pick.count_table, fasta=group2.precluster.denovo.vsearch.pick.fasta, taxonomy=group2.precluster.denovo.vsearch.pds.wang.pick.taxonomy)

#Построение дерева

dist.seqs(fasta=current, output=lt)
clearcut(phylip=group2.precluster.denovo.vsearch.pick.phylip.dist, version=t)
#