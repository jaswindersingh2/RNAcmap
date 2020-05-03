# RNAcmap
A Fully Automatic Method for Predicting Contact Maps of RNAs by Evolutionary Coupling Analysis

SYSTEM REQUIREMENTS
====
Hardware Requirments:
----
RNAcmap predictor requires only a standard computer with around 32 GB RAM to support the in-memory operations for RNAs sequence length less than 500.

Software Requirments:
----
* [NCBI's nt database](ftp://ftp.ncbi.nlm.nih.gov/blast/db/)
* [BLASTN](https://blast.ncbi.nlm.nih.gov/Blast.cgi?PAGE_TYPE=BlastDocs&DOC_TYPE=Download)
* [Infernal](http://eddylab.org/infernal/)
* [Python3](https://docs.python-guide.org/starting/install3/linux/) (optinal if using SPOT-RNA)
* [virtualenv](https://virtualenv.pypa.io/en/latest/installation/) or [Anaconda](https://anaconda.org/anaconda/virtualenv) (optinal if using SPOT-RNA)


RNAcmap has been tested on Ubuntu 14.04, 16.04, and 18.04 operating systems.

USAGE
====

Installation:
----

To install RNAcmap and it's dependencies following commands can be used in terminal:

1. `git clone https://github.com/jaswindersingh2/RNAcmap.git`
2. `cd RNAcmap`

If Infernal tool is not installed in the system, please use follwing 2 command to download and extract it. In case of any problem and issue regarding Infernal download, please refer to [Infernal webpage](http://eddylab.org/infernal/) as following commands only tested on Ubuntu 18.04, 64 bit system.

3. `wget 'eddylab.org/infernal/infernal-1.1.3-linux-intel-gcc.tar.gz'`
4. `tar -xvzf infernal-*.tar.gz && rm infernal-*.tar.gz`

If BLASTN tool is not installed in the system, please use follwing 2 command to download and extract it. In case of any problem and issue regarding BLASTN download, please refer to [BLASTN webpage](https://blast.ncbi.nlm.nih.gov/Blast.cgi?PAGE_TYPE=BlastDocs&DOC_TYPE=Download) as following commands only tested on Ubuntu 18.04, 64 bit system.

5. `wget 'ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/ncbi-blast-2.10.0+-x64-linux.tar.gz'`
6. `tar -xvzf ncbi-blast-2.10.0+-x64-linux.tar.gz && rm ncbi-blast-2.10.0+-x64-linux.tar.gz`

Either install **RNAfold** or **SPOT-RNA** predictor depending upon which Secondary Structure predictor you want to use. Installation of RNAfold will take 15-20 mins and 2-3 mins for SPOT-RNA:<br />

7. `./install_RNAfold.sh` or `./install_SPOT-RNA.sh`

Download the reference database ([NCBI's nt database](ftp://ftp.ncbi.nlm.nih.gov/blast/db/)) for BLASTN and INFERNAL. The following command can used for NCBI's nt database. Make sure there is enough space on the system as NCBI's nt database is of size around 270 GB after extraction and it can take couple of hours to download depending on the internet speed. In case of any issue, please rerfer to [NCBI's database website](https://blast.ncbi.nlm.nih.gov/Blast.cgi?PAGE_TYPE=BlastDocs&DOC_TYPE=Download).

```
wget -c "ftp://ftp.ncbi.nlm.nih.gov/blast/db/FASTA/nt.gz -O ./nt_database && gunzip ./nt_database/nt.gz"
```

This NCBI's database need to formated to use with BLASTN tool. To format the NCBI's database, the following command can be used. Please make sure system have enough space as formated database is of size around 120 GB in addition to appox. 270 GB from previous step and it can few hours for it.
```
./ncbi-blast-2.10.0+/bin/makeblastdb -in ./nt_database -dbtype nucl
```

To install the DCA predictor, please run the following command:<br />

8. `./install_GREMLIN.sh`

To run the RNAcmap
-----
To run the RNAcmap, the following command can be used.
```
./sample.sh inputs/sample_seq.fasta RNAfold
```
The final output will be the "*.dca" file in the "outputs" folder consists of predicted Direct Coupling Analysis (DCA) by RNAcmap for a given input RNA sequence.

References
====
If you use RNAcmap for your research please cite the following papers:
----
Zhang, T., Singh, J., Litfin, T., Zhan, J., Paliwal, K., Zhou, Y., 2020. RNAcmap: A Fully Automatic Method for Predicting Contact Maps of RNAs by Evolutionary Coupling Analysis. (Under Review)

Other references:
----
[1] Nawrocki, E.P. and Eddy, S.R., 2013. Infernal 1.1: 100-fold faster RNA homology searches. Bioinformatics, 29(22), pp.2933-2935..

[2] Hofacker, I.L., 2003. Vienna RNA secondary structure server. Nucleic acids research, 31(13), pp.3429-3431. 

[3] H.M. Berman, J. Westbrook, Z. Feng, G. Gilliland, T.N. Bhat, H. Weissig, I.N. Shindyalov, P.E. Bourne. (2000) The Protein Data Bank Nucleic Acids Research, 28: 235-242.

[4] Singh, J., Hanson, J., Paliwal, K. and Zhou, Y., 2019. RNA secondary structure prediction using an ensemble of two-dimensional deep neural networks and transfer learning. Nature communications, 10(1), pp.1-13.

[5] Kamisetty, H., Ovchinnikov, S. and Baker, D., 2013. Assessing the utility of coevolution-based residue–residue contact predictions in a sequence-and structure-rich era. Proceedings of the National Academy of Sciences, 110(39), pp.15674-15679.

Licence
====
Mozilla Public License 2.0


Contact
====
jaswinder.singh3@griffithuni.edu.au, tongchuan.zhang@griffithuni.edu.au, yaoqi.zhou@griffith.edu.au

