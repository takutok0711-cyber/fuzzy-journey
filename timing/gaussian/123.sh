#!/bin/bash

#making .gjf
for compound in keto l_ala; do
	for i in 4 8 16 32; do
		sed -e "s/ZZZ/${i}/g" ${compound}.gjf > ${compound}_omp${i}.gjf
	done
done



#making .sh
for compound in keto l_ala; do

	for i in 4 8 16 32; do
		sed -e "s/ZZZ/${i}/g" \
		    -e "s/COMPOUND/${compound}/g"\
		    runGau_tmp.sh > ${compound}_omp${i}.sh
	done
done

#mk_mv
for compound in keto l_ala; do
	mkdir ${compound}
	mv ${compound}_omp* $compound
done
