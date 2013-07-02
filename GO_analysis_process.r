python get_unique.py 
#get five files: 
#pdblist_filter	subgroup_pdblist singlepdb_pdblist subgroup_RHS singlepdb_RHS
#1st: all pdb ids which can be found in pdb_chain_go.order3
#2nd: cluster pdblist_filter into different clusters according to uniprot id
#3rd: only the first column, in this file where all pdb files are unique
#4th: same as 2nd, but dataset are -RHStaple
#5th: same as 3rd, but dataset are -RHStaple
read.table('singlepdb_pdblist')[,1]->pdb_uniprot
save(pdb_uniprot,file='pdb_uniprot')
read.table('singlepdb_RHS')[,1]->rhs_uniprot
save(rhs_uniprot,file='rhs_uniprot')

source('scop2pdb2go.R')
#get pdb list which have 40% similarities from cedric's list
#pdb_scop40 rhs_scop40

source('GO.R')

GO('pdb_uniprot','rhs_uniprot','uniprot')
GO('pdb_scop40','rhs_scop40','scop40')
