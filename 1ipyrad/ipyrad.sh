#!/bin/bash

#SBATCH -p general
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --cpus-per-task=32
#SBATCH --time=11-00:00:00
#SBATCH --mem=250g
#SBATCH --out=ipyrad.out

module add anaconda/2023.03
source activate ipyrad
cd /YOUR/WORK/PATH/
ipyrad -p params-test.txt -s 1 -c 4
ipyrad -p params-test.txt -s 2 -c 4


#ipyrad -p params-test.txt -b test60
#ipyrad -p params-test.txt -b data70
#ipyrad -p params-test.txt -b data80
#ipyrad -p params-test.txt -b data40
#ipyrad -p params-test.txt -b data30
#ipyrad -p params-test.txt -b data20

ipyrad -p params-test.txt -s 3 -c 50
ipyrad -p params-test.txt -s 4 -c 32
ipyrad -p params-test.txt -s 5 -c 32
ipyrad -p params-test.txt -s 6 -c 20
ipyrad -p params-test.txt -s 7 -c 30
