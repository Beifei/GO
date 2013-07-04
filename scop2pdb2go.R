#To get the pdb files which have disulfide bonds from 40% similarity

read.delim('pdb_chain_scop_uniprot.lst',fill=T, header=F)[,c(1:3,5,6)]->pdb_uniprot_scop
#read files from mapping data from website http://www.ebi.ac.uk/pdbe/docs/sifts/quick.html 
read.table('list_40_cedric.dat')->list_40
#read data from cedric

scop2pdb<-function(x){
	as.vector(pdb_uniprot_scop[pdb_uniprot_scop[,5]==x,1])[1]
}
apply(list_40,1, scop2pdb)->pdb40 #got the pdb id which have 40 percent structurally similarity
unique(pdb40)->tmp
toupper(tmp[-which(is.na(tmp))])->PDB40

read.table('/hits/mbm/zhoubeifei/DisulfidesStatistics/2012/Sele_Multi_MD_30102012/Dist_average_angle.txt',header=T, sep='\t',quote="",stringsAsFactor=F)->Data
Data[Data[,21]<0.21399 & Data[,21]>0.19361,]->D
unique(D[,1])->pdbid

pdbSS_pdb40<-function(x){
	pdbid[pdbid==x][1]
}
apply(array(PDB40),1, pdbSS_pdb40)->tmp
unique(tmp)->tmp
tmp[-which(is.na(tmp))]->pdb_scop40


D[D[,19]==".-RHStaple",]->RHS_D
rhs<-function(x){
	RHS_D[RHS_D[,1]==x,1][1]
}

apply(as.array(pdb_scop40),1,rhs)->tmp
unique(tmp)->tmp
tmp[-which(is.na(tmp))]->rhs_scop40
save(pdb_scop40, file='pdb_scop40') #pdb files with 40% smilarities
save(rhs_scop40, file='rhs_scop40') #-RHStaple disulfie bonds' proteins with 40% similarities

#################################################
	
