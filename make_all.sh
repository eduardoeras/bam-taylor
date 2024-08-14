#!/bin/bash

##############################################
# Script for Compilation, running and test   #
# By Eduardo Rohde Eras                      #
# eduardo.eras@inpe.br                       #
##############################################

#Load Modules
module load gcc/11.1
module load openmpi/gnu/4.1.4

#Model Compilation
cd GetICnAGCM/Sources
make clean
make gnu_lachibrido

cd ../../pre/sources/
make clean
make gnu_lachibrido

cd ../../model/source/
make clean
make gnu_lachibrido

cd ../../pos/source/
make clean
make gnu_lachibrido
