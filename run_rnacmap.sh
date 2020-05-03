#!/bin/bash

input=$1
input_dir=$(dirname $1)
seq_id=$(basename $(basename $input) .fasta)

#path_blastn=./ncbi-blast-2.10.0+/bin/
#path_blastn_database=./nt_database/nt
#path_infernal=./infernal-1.1.3-linux-intel-gcc/binaries
#path_infernal_database=./nt_database/nt

path_blastn=/home/jaswinder/Documents/project4/programs/ncbi-blast-2.10.0+/bin
path_blastn_database=/home/jaswinder/Downloads/ncbi_db/nt
path_infernal=/home/jaswinder/Documents/project4/programs/infernal-1.1.3-linux-intel-gcc/binaries
path_infernal_database=/home/jaswinder/Documents/project4/database/nt

#echo $input_dir/$seq_id.bla

start=`date +%s`

######## run blastn ################
$path_blastn/blastn -db $path_blastn_database -query $input -out $input_dir/$seq_id.bla -evalue 0.001 -num_descriptions 1 -num_threads 8 -line_length 1000 -num_alignments 50000

######## reformat the output ################
./parse_blastn_local.pl $input_dir/$seq_id.bla $input_dir/$seq_id.fasta $input_dir/$seq_id.aln
./reformat.pl fas sto $input_dir/$seq_id.aln $input_dir/$seq_id.sto

######## predict secondary ################
./RNAfold/bin/RNAfold $input | awk '{print $1}' | tail -n +3 > $input_dir/$seq_id.dbn

################ reformat ss with according to gaps in reference sequence of .sto file from blastn ################
for i in `awk '{print $2}' $input_dir/$seq_id.sto | head -n5 | tail -n1 | grep -b -o - | sed 's/..$//'`; do sed -i "s/./&-/$i" $input_dir/$seq_id.dbn; done

#########  add reformated ss from last step to .sto file of blastn ##############
head -n -1 $input_dir/$seq_id.sto > $input_dir/temp.sto
echo "#=GC SS_cons                     "`cat $input_dir/$seq_id.dbn` > $input_dir/temp.txt
cat $input_dir/temp.sto $input_dir/temp.txt > $input_dir/$seq_id.sto
echo "//" >> $input_dir/$id.sto


######## run infernal ################
$path_infernal/cmbuild --hand -F $input_dir/$seq_id.cm $input_dir/$seq_id.sto
$path_infernal/cmcalibrate $input_dir/$seq_id.cm
$path_infernal/cmsearch -o $input_dir/$seq_id.out --cpu 30 --incE 10.0 $input_dir/$seq_id.cm $path_infernal_database

######### reformat the output for dca input ###############
$path_infernal/esl-reformat --replace acgturyswkmbdhvn:................ a2m $input_dir/$seq_id.msa > $input_dir/$seq_id.a2m


end=`date +%s`

runtime=$((end-start))

echo -e "\ncomputation time = "$runtime" seconds"

