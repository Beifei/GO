annFUN.pdb2GO<-function (whichOnto, feasibleGenes = BPS, pdb2go) 
{
    ontoGO <- get(paste("GO", whichOnto, "Term", sep = ""))
    if (!is.null(feasibleGenes)) 
        pdb2go <- pdb2go[intersect(names(pdb2go), feasibleGenes)]
    if (any(is.na(pdb2go))) 
        pdb2go <- pdb2go[!is.na(pdb2go)]
    pdb2go <- pdb2go[sapply(pdb2go, length) > 0]
    allGO <- unlist(pdb2go, use.names = FALSE)
    geneID <- rep(names(pdb2go), sapply(pdb2go, length))
    goodGO <- allGO %in% ls(ontoGO)
    return(split(geneID[goodGO], allGO[goodGO]))
}
