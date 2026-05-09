#!/bin/bash
#SBATCH -J g_COMPOUND_oZZZ
#SBATCH --ntasks=1                  ### MPI processors
#SBATCH --cpus-per-task=32          ### OPENMP threads
#SBATCH --nodes=1                   ### number of nodes
##SBATCH --ntasks-per-node=1
#SBATCH --partition=p2-6            ### p1 or p2-6 or all
#SBATCH --error="%x.e%j"
#SBATCH --output="%x.o%j"

#
#  INP : Input filename
#
    INP=$1 

    MOL=${INP%.*}
    OUT=$MOL.out
    TMP=$INP.tmp

    DATADIR=$(pwd)
    export OMP_NUM_THREADS=ZZZ
#
# ----------------------------------------------------------
# General settings for GAUSSIAN
#
#   Provide the following information:
#    1. GAUSS_DIR    : Root directory where Gaussian is located
#    2. GAUSS_EXEBIN : Folder where Executables are located
#    3. GAUSS_SCRDIR : Local scratch directory 
#
    # note that this build of G09 allows parallel calc. only 
    # within the node
    if [ $SLURM_NTASKS -gt 1 ]; then
       echo "Error! This build of G16 allows parallel only within the node"
       exit -1
    fi 

    export GAUSS_DIR=/swork/common/gaussian/g16C02
    export GAUSS_EXEBIN=$GAUSS_DIR/g16

    export GAUSS_EXEDIR=$GAUSS_DIR/bsd:$GAUSS_DIR
    if  [ $?PATH ]; then
      export PATH=$GAUSS_EXEDIR:$PATH
    else
      export PATH=$GAUSS_EXEDIR
    fi

    export GAUSS_SCRDIR=/scr/$USER/$MOL.$$
    mkdir -p $GAUSS_SCRDIR

#
# ----------------------------------------------------------
# SMP parallel job
#
    touch $TMP
    echo "%NprocShared=$OMP_NUM_THREADS" >> $TMP
    grep -v -i nproc $INP >> $TMP
    mv $TMP $INP
#

# ==============================================================
# Now execute
    (time $GAUSS_EXEBIN < $DATADIR/$INP) > $DATADIR/$OUT 2>&1
# ==============================================================
# Post process
    rm -r $GAUSS_SCRDIR
    if [ -e $MOL.chk ]; then
       formchk $MOL.chk
    fi
# 
    exit 0
#
