#!/bin/bash

git clone https://github.com/jaswindersingh2/SPOT-RNA.git
cd SPOT-RNA
wget 'https://www.dropbox.com/s/dsrcf460nbjqpxa/SPOT-RNA-models.tar.gz' || wget -O SPOT-RNA-models.tar.gz 'https://app.nihaocloud.com/f/fbf3315a91d542c0bdc2/?dl=1'
tar -xvzf SPOT-RNA-models.tar.gz && rm SPOT-RNA-models.tar.gz

if hash virtualenv 2>/dev/null
    then
        virtualenv -p python3.6 venv
        source ./venv/bin/activate
        pip install tensorflow==1.14.0 
		pip install -r requirements.txt
elif hash conda 2>/dev/null
    then
        conda create -n venv python=3.6
        conda activate venv
        conda install tensorflow==1.14.0 
        while read p; do conda install --yes $p; done < requirements.txt
else
	echo "Virtual environment doesn't exists. Therefore installing packages globally."
	pip install tensorflow==1.14.0 
	pip install -r requirements.txt
fi
