load('pdb_uniprot')
load('rhs_uniprot')
load('pdb_scop40')
load('rhs_scop40')

tolower(pdb_scop40)->pdb_scop40
tolower(rhs_scop40)->rhs_scop40

intersect(pdb_uniprot,pdb_scop40)->pdb_inter #338
intersect(rhs_uniprot,rhs_scop40)->rhs_inter #70


for (i in c('BP','MF','CC')){
	for (j in c('uniprot','scop40')){
		assign(paste(i,'.classic.fisher.',j,sep=''),read.csv(paste('csv_',j,'/',i,'.classic.fisher.',j,'.csv',sep='')))
	}
}
intersect(BP.classic.fisher.uniprot[,2],BP.classic.fisher.scop40[,2])->BP_inter
intersect(MF.classic.fisher.uniprot[,2],MF.classic.fisher.scop40[,2])->MF_inter
intersect(CC.classic.fisher.uniprot[,2],CC.classic.fisher.scop40[,2])->CC_inter

GetInfo_BP<-function(x){
	BP.classic.fisher.uniprot->y1
	y1[y1[,2]==x,3:7]->info1
	BP.classic.fisher.scop40->y2
	y2[y2[,2]==x,4:7]->info2
	cbind(info1,info2)
	}
lapply(BP_inter,GetInfo_BP)->tmp_list
BP<-c()
for (i in 1:length(tmp_list)){
	rbind(BP,tmp_list[[i]])->BP
	}
cbind(BP_inter,BP)->BP


GetInfo_MF<-function(x){
	MF.classic.fisher.uniprot->y1
	y1[y1[,2]==x,3:7]->info1
	MF.classic.fisher.scop40->y2
	y2[y2[,2]==x,4:7]->info2
	cbind(info1,info2)
	}

lapply(MF_inter,GetInfo_MF)->tmp_list
MF<-c()
for (i in 1:length(tmp_list)){
    rbind(MF,tmp_list[[i]])->MF
    }
cbind(MF_inter,MF)->MF


GetInfo_CC<-function(x){
	CC.classic.fisher.uniprot->y1
	y1[y1[,2]==x,3:7]->info1
	CC.classic.fisher.scop40->y2
	y2[y2[,2]==x,4:7]->info2
	cbind(info1,info2)
	}
lapply(CC_inter,GetInfo_CC)->tmp_list
CC<-c()
for (i in 1:length(tmp_list)){
    rbind(CC,tmp_list[[i]])->CC
    }
cbind(CC_inter,CC)->CC

write.csv(BP,file='BP.csv')
write.csv(MF,file='MF.csv')
write.csv(CC,file='CC.csv')





			

