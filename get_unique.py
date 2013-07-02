#!usr/bin/python
#to get unique pdb file by uniprot id


input1=open('pdbid','r') #pdbid from Philip Hogg with disulfide bonds
input2=open('pdb_chain_go.order3','r') #read file of pdb_chain_go.lst which is modifed to pdb-chain_go_oder3 
input3=open('RHS','r') #-RHStaple disulfide bonds from the database by Prof. Hogg

output1=open('subgroup_pdblist','w')
output2=open('singlepdb_pdblist','w')
output3=open('subgroup_RHS','w')
output4=open('singlepdb_RHS','w')

line=input2.readline().strip().split()
pdbid=[]
sub_pdbid=[]
sub_pdbid.append(line[0])

while 1:
	line_next=input2.readline().strip().split()
	if line_next==[]:
		break
	else:
		if line_next[2]==line[2]: #if the uniprot id same
			if line_next[0]!=line[0]: #if the pdb id are different
				sub_pdbid.append(line_next[0]) #then the pdbs have same uniprot id but different pdbid
		else:
			if list(set(sub_pdbid)) not in pdbid:
				pdbid.append(list(set(sub_pdbid)))
				sub_pdbid=[]
				sub_pdbid.append(line_next[0])
		line=line_next

#function to get the the list which one uniprot has several pdbs
def get_group(inputdata,output_1, output_2):	
	group=[]
	sub_group=[]
	dataset=inputdata.readlines()
	dataset_new=[]
	for each in dataset:
		each=each.lower().strip()
		dataset_new.append(each)
	for sub in pdbid:
		for pdb_in_sub in sub:
			if pdb_in_sub in dataset_new:
				sub_group.append(pdb_in_sub)
		if sub_group!=[]:
			group.append(sub_group)
			output_1.write("".join(["\t".join(sub_group),"\n"])) #write all pdbs which was divied into groups 
			output_2.write("".join([sub_group[0],"\n"])) #write pdbs which only contain first pdb which represent the file
			sub_group=[]
	inputdata.close()
	output_1.close()
	output_2.close()
	return group

pdblist=get_group(input1,output1,output2)
rhs=get_group(input3,output3,output4)

output5=open("pdblist_filter","w") #write all pdbs which can be found in uniprot
for each in pdblist:
	if len(each)==1:
		output5.write("".join([each[0],"\n"]))
	else:
		n=0
		for each_rhs in rhs:
			if len(each_rhs)!=1:
				if set(each_rhs).issubset(set(each)):
					output5.write("".join([each_rhs[0],"\n"]))
					n=n+1
		if n==0:
				output5.write("".join([each[0],"\n"]))
output5.close()

