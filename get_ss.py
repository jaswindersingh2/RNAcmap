import pandas as pd
import numpy as np
import pickle as pkl
import os, six
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('--inputs_path', default='inputs', type=str, help='Path to input file in fasta format, accept multiple sequences as well in fasta format; default = ''sample_inputs/2zzm-1-B.fasta''\n', metavar='')
parser.add_argument('--outputs',default='outputs', type=str, help='Path to output files; SPOT-RNA outputs at least three files .ct, .bpseq, and .prob files; default = ''outputs/\n', metavar='')
parser.add_argument('--rna_id', default='sample_seq', type=str, help='Name of the input sequence file\n')
parser.add_argument('--dca_method', default='GREMLIN', type=str, help='Method used for direct coupling analysis \n', metavar='')

args = parser.parse_args()

def ct_file_output(pairs, seq, id, save_result_path):
###### write base-pairs into ct file format #######
    col1 = np.arange(1, len(seq) + 1, 1)
    col2 = np.array([i for i in seq])
    col3 = np.arange(0, len(seq), 1)
    col4 = np.append(np.delete(col1, 0), [0])
    col5 = np.zeros(len(seq), dtype=int)

    for i, I in enumerate(pairs):
        col5[I[0]] = int(I[1]) + 1
        col5[I[1]] = int(I[0]) + 1
    col6 = np.arange(1, len(seq) + 1, 1)
    temp = np.vstack((np.char.mod('%d', col1), col2, np.char.mod('%d', col3), np.char.mod('%d', col4),
                      np.char.mod('%d', col5), np.char.mod('%d', col6))).T
    np.savetxt(os.path.join(save_result_path, str(id))+'.ct', (temp), delimiter='\t\t', fmt="%s", header=str(len(seq)) + '\t\t' + str(id) + '\t\t' + 'SPOT-RNA output\n', comments='')

    return

def bpseq_file_output(pairs, seq, id, save_result_path):
###### write base-pairs into bpseq file format #######
    col1 = np.arange(1, len(seq) + 1, 1)
    col2 = np.array([i for i in seq])
    col5 = np.zeros(len(seq), dtype=int)

    for i, I in enumerate(pairs):
        col5[I[0]] = int(I[1]) + 1
        col5[I[1]] = int(I[0]) + 1
    temp = np.vstack((np.char.mod('%d', col1), col2, np.char.mod('%d', col5))).T
    np.savetxt(os.path.join(save_result_path, str(id))+'.bpseq', (temp), delimiter=' ', fmt="%s", header='#' + str(id) , comments='')

    return

###### read query sequence #######
with open(os.path.join(args.inputs_path, args.rna_id + '.fasta')) as f:
    temp_1 = pd.read_csv(f, comment='#', delim_whitespace=True, header=None, skiprows=[0]).values
seq = [j.upper() for j in temp_1[0, 0]]

if args.dca_method=="GREMLIN":
	###### read GREMLIN output #######
	with open(os.path.join(args.outputs,args.rna_id + '.dca_gremlin')) as f:
		temp = pd.read_csv(f, comment='#', delim_whitespace=True, header=None, skiprows=[0], usecols=[0,1,2]).values
elif args.dca_method=="plmc":
	###### read plmc output #######
	with open(os.path.join(args.outputs,args.rna_id + '.dca_plmc')) as f:
		temp = pd.read_csv(f, comment='#', delim_whitespace=True, header=None, skiprows=[0], usecols=[0,2,5]).values
	
###### read down-weight dca value for |i-j| < 4 by 0.01 #######
dca = []
for i in temp:
	if abs(i[0]-i[1]) < 4.0:
		dca.append([i[0],i[1],0.01*i[2]])	
	else: 
		dca.append([i[0],i[1],i[2]])	
dca = np.array(dca)
dca = np.flipud(dca[dca[:,2].argsort()])

#### consider top L/4 dca values ######
dca = dca[0:int(len(seq)/4)]

#### get base-pair index values starting from 0 ########
pred_pairs = [[int(i[0]-1), int(i[1]-1)] for i in dca]
#print(pred_pairs)

#### write base-pairs in standard RNA secondary structure format ########
ct_file_output(pred_pairs, seq, args.rna_id, args.outputs)
bpseq_file_output(pred_pairs, seq, args.rna_id, args.outputs)

#### get base-pair index values starting from 0 ########
dca = np.zeros((len(seq), len(seq)))
for k in temp:
    if abs(int(k[0]) - int(k[1])) < 4:
        dca[int(k[0]-1), int(k[1]-1)] = 0.01*k[2]
    else:
        dca[int(k[0]-1), int(k[1]-1)] = k[2]
np.savetxt(args.outputs + '/'+ args.rna_id +'.prob', dca, delimiter='\t')

#print(out_pred)

