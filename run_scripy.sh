#!/bin/bash

##############################################
# Script for Compilation, running and test   #
# By Eduardo Rohde Eras                      #
# eduardo.eras@inpe.br                       #
##############################################

#Model Compilation
cd GetICnAGCM/Sources
make clean
#make gnu_lachibrido

cd ../../pre/sources/
make clean
#make gnu_lachibrido

cd ../../model/source/
make clean
#make gnu_lachibrido

cd ../../pos/source/
make clean
#make gnu_lachibrido