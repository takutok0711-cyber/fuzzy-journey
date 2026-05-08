#!/bin/bash

for compound in keto l_ala; do
	for i in 4 8 16 32; do
		cd $compound
		sbatch ${compound}_omp${i}.sh ${compound}_omp${i}.gjf
		cd ../
	done
done
