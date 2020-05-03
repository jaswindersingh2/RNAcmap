#!/bin/bash

input=$1
input_dir=$(dirname $1)
seq_id=$(basename $(basename $input) .fasta)

if [[ $2 == 'SPOT-RNA' ]]; then
    cd SPOT-RNA
	source ./venv/bin/activate
    python3 SPOT-RNA.py --inputs ../$input_dir/$seq_id.fasta --outputs ../$input_dir/
    deactivate
    cd ../k2n_standalone
    python knotted2nested.py -f bpseq -F vienna  ../$input_dir/$seq_id.bpseq | tail -n +3 > ../$input_dir/$seq_id.dbn
	cd ../
else
	./RNAfold/bin/RNAfold $input | awk '{print $1}' | tail -n +3 > $input_dir/$seq_id.dbn
fi
