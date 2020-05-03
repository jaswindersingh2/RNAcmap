#!/bin/bash

working_dir=`pwd`

wget -c 'https://www.tbi.univie.ac.at/RNA/download/sourcecode/2_4_x/ViennaRNA-2.4.14.tar.gz'
tar -zxvf ViennaRNA-2.4.14.tar.gz
rm ViennaRNA-2.4.14.tar.gz
cd ViennaRNA-2.4.14
./configure --prefix=$working_dir/RNAfold
make
make install
