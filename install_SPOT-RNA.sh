#!/bin/bash

git clone https://github.com/jaswindersingh2/SPOT-RNA.git
cd SPOT-RNA
wget 'https://www.dropbox.com/s/dsrcf460nbjqpxa/SPOT-RNA-models.tar.gz' || wget -O SPOT-RNA-models.tar.gz 'https://app.nihaocloud.com/f/fbf3315a91d542c0bdc2/?dl=1'
tar -xvzf SPOT-RNA-models.tar.gz && rm SPOT-RNA-models.tar.gz

source ../venv_rnacmap/bin/activate || conda activate venv_rnacmap
pip install tensorflow==1.14.0 || conda install tensorflow==1.14.0 
pip install -r requirements.txt || while read p; do conda install --yes $p; done < requirements.txt
