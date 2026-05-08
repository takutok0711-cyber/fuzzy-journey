#!/bin/bash

for i in 1 2 4 8; do
	cp keto.in keto_mpi${i}_omp4.in
	cp l_ala.in l_ala_mpi${i}_omp4.in
done

for i in 1 2 4; do
	cp keto.in keto_mpi${i}_omp8.in
	cp l_ala.in l_ala_mpi${i}_omp8.in
done

for i in 1 2; do
	cp keto.in keto_mpi${i}_omp16.in
	cp l_ala.in l_ala_mpi${i}_omp16.in
done
