#!/bin/bash

for i in 1 2 4 8; do
	cd keto
	sbatch keto_mpi${i}_omp4.sh
	cd ../l_ala
       	sbatch l_ala_mpi${i}_omp4.sh
	cd ../
done

for i in 1 2 4; do
	cd keto
       	sbatch keto_mpi${i}_omp8.sh
	cd ../l_ala
	sbatch l_ala_mpi${i}_omp8.sh
	cd ../
done

for i in 1 2; do
	cd keto
       	sbatch keto_mpi${i}_omp16.sh
	cd ../l_ala 
	sbatch l_ala_mpi${i}_omp16.sh
	cd ../
done
