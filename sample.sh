#!/bin/bash

input=$1
input_dir=$(dirname $1)
seq_id=$(basename $(basename $input) .fasta)

echo $input
echo $input_dir
echo $seq_id
