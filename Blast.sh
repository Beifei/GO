cd ../pdb_fasta_alignment/
for i in `cat ../pdbid`
do
	cat $i.fasta >> BlastClust.fasta
done


mv BlastClust.fasta BlastDatabase.fasta
/hits/mbm/zhoubeifei/program/blast-2.2.26/bin/blastclust -i BlastDatabase.fasta -o BlastCluster95.txt -S 95 
/hits/mbm/zhoubeifei/program/blast-2.2.26/bin/blastclust -i BlastDatabase.fasta -o BlastCluster90.txt -S 90 
/hits/mbm/zhoubeifei/program/blast-2.2.26/bin/blastclust -i BlastDatabase.fasta -o BlastCluster40.txt -S 40 
