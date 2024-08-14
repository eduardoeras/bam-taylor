# * * * Wet Run * * *
./runModel 48 2 1 bam 126 28 2014011512 2014013012 2014013012 2014013012 NMC sstmtd 2
echo "Wet Model Run has started..."

# * * * Dry Run * * *
#./runModel 48 2 1 bam 126 28 2014091512 2014093012 2014093012 2014093012 NMC sstmtd 2
#echo "Dry Model Run has started..."

sleep 1
squeue --iterate=1 | grep BAM

