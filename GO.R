#load data

GO<-function(bg,my,filename){ #bg: background gene 
			      #my: the interested gene
			      #Here: bg--- all pdbs
			      #	     my--- -RHStaple pdbs
	load(bg)
	load(my)
	get(bg)->bglist
	get(my)->mylist

	library(topGO)

	read.table('pdb_chain_go.lst',header=T)->pdb_chain_go.lst
	map<-function(x){
	    as.vector(pdb_chain_go.lst[pdb_chain_go.lst[,1]==x,4])
	}
	apply(array(tolower(bglist)),1,map)->pdb2go
	bglist->names(pdb2go)
	geneNames <- names(pdb2go)


	geneList <- factor(as.integer(geneNames %in% mylist))
	names(geneList) <- geneNames

	data_test<-function(onto,algo,test){
		GOdata<-new("topGOdata",ontology =onto, allGenes=geneList, annot=annFUN.gene2GO, gene2GO=pdb2go)
		result<-runTest(GOdata,algorithm=algo, statistic=test)
		score(result)->scores
		length(scores[scores<0.01])->NodeSize
		allRes<-GenTable(GOdata,result,topNodes=NodeSize)
		write.csv(allRes,file=paste(onto,algo,test,filename,"csv",sep='.'))
		if (NodeSize<10){
			showSigOfNodes(GOdata, score(result),firstSigNodes=NodeSize, useInfo="all")
			title(paste(onto,algo,test,sep="_"))
		}else{
			showSigOfNodes(GOdata, score(result),firstSigNodes=10, useInfo="all")
			title(paste(onto,algo,test,sep="_"))
		}
	} 

	data<-function(onto){
		GOdata<-new("topGOdata",ontology =onto, allGenes=geneList, annot=annFUN.gene2GO, gene2GO=pdb2go)
		return(GOdata)
		}



	pdf(paste('GO',filename,'pdf',sep="."))
	for (i in c("MF","BP","CC")){
		for (j in c("classic","elim","weight01","lea","parentchild")){
			for (k in c("fisher","ks","t","globaltest","sum")){
				try_result<-try(data_test(i,j,k))
				if (class(try_result)!="try-error"){
					data_test(i,j,k)
				}
	#			data(i,j,k)
			}
		}
	}
	dev.off()

	pdf(paste('GO_classic_fisher',filename,'pdf',sep='.'))
	for (l in c("MF","BP","CC")){
		data_test(l,"classic","fisher")
	}
	dev.off()	 
	#Description:  
	#Ontology: MF 
	#'classic' algorithm with the 'fisher' test
	#291 GO terms scored: 28 terms with p < 0.01
	#Annotation data:
	#    Annotated genes: 461 
	#    Significant genes: 54 
	#    Min. no. of genes annotated to a GO: 1 
	#    Nontrivial nodes: 108 

}
