#work_dir=/home/berdnikovich/task/Stage3_OTUs
set.current(processors=8, count=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.count_table, fasta=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.fasta, taxonomy=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pds.wang.pick.taxonomy)

#dist.seqs(fasta=final.fasta, cutoff=0.03)
#dist.seqs(fasta=current, cutoff=0.03, countends=F)
cluster.split(fasta=current, count=current, taxonomy=current, taxlevel=4, cutoff=0.03)
#смотрим представленность otu
make.shared(list=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.opti_mcc.list, count=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.count_table, label=0.03)
#otu  - это изначально последовательность - которая мб референсной
classify.otu(list=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.opti_mcc.list, count=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.count_table, taxonomy=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pds.wang.pick.taxonomy, label=0.03)
#далее команда будет давать ASV- то есть не кластеризованные последовательности - а просто которые отличаются
make.shared(count=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.count_table)
classify.otu(list=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.asv.list, count=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.count_table, taxonomy=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pds.wang.pick.taxonomy, label=ASV)

##далее предлагают сделать dist.seq с нашим набором данных - кажется это чтото нереальное
###
count.groups(shared=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.opti_mcc.shared)

##alpha diversity - между сэмплами - подсчитали эти нарастающие кривые
rarefaction.single(shared=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.opti_mcc.shared, calc=sobs, freq=100)

# далее считаем разнообразие
summary.single(shared=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.opti_mcc.shared, calc=nseqs-coverage-sobs-invsimpson, subsample=T)

rename.file(shared=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.opti_mcc.shared, prefix=final)

summary.single(shared=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.opti_mcc.shared, calc=nseqs-coverage-sobs-invsimpson, subsample=7000)
##
rename.file(shared=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.opti_mcc.shared, prefix=final)

#summary.single(shared=final.opti_mcc.shared, calc=nseqs-coverage-sobs-invsimpson, subsample=7000)
#sub_7000_alpha_ave-std.summary
###SRR22801285 contains 66. Eliminating.
summary.single(shared=final.opti_mcc.shared, calc=coverage-sobs-chao-qstat, subsample=7000)
#7000_sub_alpha.groups.chao.summary

#