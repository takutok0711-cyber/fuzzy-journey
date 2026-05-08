#!/bin/bash
#SBATCH -J q_k_mWWW_oZZZ
#SBATCH --ntasks=XXX                  ### MPI processors
#SBATCH --cpus-per-task=YYY          ### OPENMP threads
#SBATCH --nodes=1                   ### number of nodes
#SBATCH --partition=p2-6           ### p1 or p2-6 or all
#SBATCH --error="%x.e%j"
#SBATCH --output="%x.o%j"

export PATH_TO_QUICKRC="$HOME/quick/quick_install" 
source $PATH_TO_QUICKRC/quick.rc   

export OMP_NUM_THREADS=ZZZ

mpirun -np WWW quick.MPI keto_mpiWWW_ompZZZ.in 

