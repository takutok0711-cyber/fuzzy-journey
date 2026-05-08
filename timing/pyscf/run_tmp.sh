#!/bin/bash
#SBATCH -J p_COMPOUND_oZZZ
#SBATCH --ntasks=1                  ### MPI processors
#SBATCH --cpus-per-task=32          ### OPENMP threads
#SBATCH --nodes=1                   ### number of nodes
#SBATCH --partition=p2-6           ### p1 or p2-6 or all
#SBATCH --error="%x.e%j"
#SBATCH --output="%x.o%j"

source $HOME/pyenv/qchem/bin/activate
export OMP_NUM_THREADS=ZZZ

python3 COMPOUND_ompZZZ.py
