#!/bin/bash

for compound in keto l_ala; do

	#OMP=4
	for np in 1 2 4 8; do
		sed -e "s/XXX/8/g" \
		    -e "s/YYY/4/g" \
		    -e "s/WWW/$np/g" \
		    -e "s/ZZZ/4/g" \
		    ${compound}_tmp.sh > ${compound}_mpi${np}_omp4.sh
	done
	
	#OMP=8
	for np in 1 2 4; do
		sed -e "s/XXX/4/g" \
		    -e "s/YYY/8/g" \
		    -e "s/WWW/$np/g" \
		    -e "s/ZZZ/8/g" \
		    ${compound}_tmp.sh > ${compound}_mpi${np}_omp8.sh
	done

	#OMP=16
	for np in 1 2; do
		sed -e "s/XXX/2/g" \
		    -e "s/YYY/16/g" \
		    -e "s/WWW/$np/g" \
		    -e "s/ZZZ/16/g" \
		    ${compound}_tmp.sh > ${compound}_mpi${np}_omp16.sh
	done
done

