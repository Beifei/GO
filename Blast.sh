cd ../pdb_fasta_alignment/
for i in `cat ../pdbid`
do
	len_info=`tail -1 $i.fasta | wc`
	split=($len_info)
	if [ ${split[2]} -gt 6 ]
	then
		cat $i.fasta >> BlastDatabase.fasta
	fi
done
#done


/hits/mbm/zhoubeifei/program/blast-2.2.26/bin/blastclust -i BlastDatabase.fasta -o BlastCluster95.txt -S 95 
/hits/mbm/zhoubeifei/program/blast-2.2.26/bin/blastclust -i BlastDatabase.fasta -o BlastCluster90.txt -S 90 
/hits/mbm/zhoubeifei/program/blast-2.2.26/bin/blastclust -i BlastDatabase.fasta -o BlastCluster40.txt -S 40 

awk '{print $1}' BlastCluster95.txt > BlastNonRe95.txt
awk '{print $1}' BlastCluster90.txt > BlastNonRe90.txt
awk '{print $1}' BlastCluster40.txt > BlastNonRe40.txt

