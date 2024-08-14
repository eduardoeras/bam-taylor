# * * * Wet Run * * *
./runPos 48 2 1 posbam 126 28 2014011512 2014013012 2014013012 NMC COLD 1
echo "Wet Pos Run has started..."

# * * * Dry Run * * *
#./runPos 48 2 1 posbam 126 28 2014091512 2014093012 2014093012 NMC COLD 1
#echo "Dry Pos Run has started..."

sleep 1
squeue --iterate=1 | grep BAM
