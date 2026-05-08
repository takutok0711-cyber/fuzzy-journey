#!/bin/bash

#making .py
for compound in keto l_ala; do
	for i in 4 8 16 32; do
		cp ${compound}.py ${compound}_omp${i}.py
	done
done



#making .sh
for compound in keto l_ala; do
	
	for i in 4 8 16 32; do
		sed -e "s/ZZZ/${i}/g" \
		    -e "s/COMPOUND/${compound}/g"\
		    run_tmp.sh > ${compound}_omp${i}.sh
	done
done

#mk_mv
for compound in keto l_ala; do
	mkdir ${compound}
	mv ${compound}_omp* $compound
done

