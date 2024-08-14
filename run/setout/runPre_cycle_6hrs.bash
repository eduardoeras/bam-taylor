#!/bin/bash -x
#help#
#************************************************************************************#
#                                                                                    #
# script to run CPTEC OPERATION                                                      #
# runPre TRC LV  LABELI PREFIX total   SmoothTopo  GDASOnly      RESIN     KMIN      #
# example :                                                                          #
# runPre 62 28  2004032600 NMC 1   F  F      62     42                               #
#                                                                                    #
#                    TRC   => 4 digits spectral resolution                           #
#                     LV   => 3 digits vertical resolution                           #
#                 LABELI   => initial data YYYYMMDDHH                                #
#                 PREFIX   => NMC,AVN,P!                                             #
#                 total    => 1 tudo 0 parcial                                       #
#               SmoothTopo => Flag to Performe Topography Smoothing                  #
#                GDASOnly  => Flag to Only Produce Input CPTEC Analysis File (T or F)#
#                RESIN     => Spectral Horizontal Resolution of Input Data           #
#                             4 digits spectral resolution                           #
#                KMIN      => Number of Layers of Input Data                         #
#                             3 digits vertical resolution                           #
#                                                                                    #
#************************************************************************************#
#help#
if [ "${1}" = "help" -o -z "${1}" ]
then
  cat < ${0} | sed -n '/^#help#/,/^#help#/p'
  exit 1
else
export TRC=`echo $1 | awk '{print $1/1}'`
fi
if [ -z "${2}" ]
then
  echo "LV is not set" 
  exit 2
else
export LV=`echo $2 | awk '{print $1/1}'` 
fi

if [ -z "${3}" ]
then
  echo "initial data YYYYMMDDHH is not set" 
  exit 3
else
export DATA=$3
fi

if [ -z "${4}" ]
then
  echo "PREFIX is not set" 
  exit 2
else
export PREFIXO=${4}
fi
if [ -z "${5}" ]
then
  echo "PRE-PROCESSING TOTAL " 
export total=1
else
export total=${5}
fi
if [ -z "${6}" ]
then
  echo "Flag to Performe Topography Smoothing " 
export SmoothTopo=T    #! Flag to Performe Topography Smoothing
else
export SmoothTopo=${6}
fi
if [ -z "${7}" ]
then
  echo "Flag to Only Produce Input CPTEC Analysis File " 
export GDASOnly=F      #! Flag to Only Produce Input CPTEC Analysis File
else
export GDASOnly=${7}
fi
if [ -z "${8}" ]
then
  echo "Spectral Horizontal Resolution of Input Data " 
export RESIN=62        #! Spectral Horizontal Resolution of Input Data
else
export RESIN=${8}
fi
if [ -z "${9}" ]
then
  echo "Number of Layers of Input Data " 
export KMIN=28         #! Number of Layers of Input Data
else
export KMIN=${9}
fi

CASE=`echo ${TRC} ${LV} |awk '{ printf("TQ%4.4dL%3.3d\n",$1,$2)  }' `
PATHA=`pwd`
export FILEENV=`find ${PATHA} -name EnvironmentalVariablesMCGA -print`
export PATHENV=`dirname ${FILEENV}`
export PATHBASE=`cd ${PATHENV};cd ../;pwd`
. ${FILEENV} ${CASE} ${PREFIXO}
cd ${DK_suite}/pre/exec

# Set  Res for Chopping
typeset -x prefi
export RESOUT=`echo $1 | awk '{print $1/1}'`
export KMOUT=`echo $2 | awk '{print $1/1}'`
export GetOzone=T      #! Flag to Produce Ozone Files
export GetTracers=T    #! Flag to Produce Tracers Files
export GrADS=T         #! Flag to Produce GrADS Files
export GrADSOnly=F     #! Flag to Only Produce GrADS Files (Do Not Produce Inputs for Model)
export RmGANL=F        #! Flag to Remove GANL File if Desired
export MendCut=`echo $RESOUT | awk '{ print (int(1/((5+(40000/($1*3)))*(3/(40000)))) +1) }' ` #! FLAG to Spectral Resolution Cut Off for Topography Smoothing
#export MendCut=`echo $RESOUT | awk '{ print (int(1/((8+(1/($1))))) +1) }' ` #! FLAG to Spectral Resolution Cut Off for Topography Smoothing
#export MendCut=$RESOUT
export SmthPerCut=0.12 #! FLAG to Percentage for Topography Smoothing

export SetLinear=FALSE
export RESO=${1}

if [ $RESOUT = 21 ]; then
 export IM=64
 export JM=32
 export timestep=3600
fi 
if [ $RESOUT = 31 ]; then
 export IM=96
 export JM=48
 export timestep=1800
fi 
if [ $RESOUT = 42 ]; then
 export IM=128
 export JM=64
 export timestep=1200
fi 
if [ $RESOUT = 62 ]; then
 export IM=192
 export JM=96
 export timestep=900
fi
if [ $RESOUT = 106 ]; then
 export IM=320
 export JM=160
 export timestep=600
fi
if [ $RESOUT = 126 ]; then
 export IM=384
 export JM=192
 export timestep=450
fi
if [ $RESOUT = 133 ]; then
 export IM=400
 export JM=200
 export timestep=450
fi
if [ $RESOUT = 159 ]; then
 export IM=480
 export JM=240
 export timestep=360
fi
if [ $RESOUT = 170 ]; then
 export IM=512
 export JM=256
 export timestep=360
fi
if [ $RESOUT = 213 ]; then
 export IM=640
 export JM=320
 export timestep=300
fi
if [ $RESOUT = 213 ]; then
 export IM=640
 export JM=320
 export timestep=300
fi
if [ $RESOUT = 254 ]; then
 export IM=768
 export JM=384
 export timestep=240
fi
if [ $RESOUT = 299 ]; then
 export IM=900
 export JM=450
 export timestep=200
fi
if [ $RESOUT = 319 ]; then
 export IM=960
 export JM=480
 export timestep=180
fi
if [ $RESOUT = 341 ]; then
 export IM=1024
 export JM=512
 export timestep=180
fi
if [ $RESOUT = 382 ]; then
 export IM=1152
 export JM=576
 export timestep=150
fi
if [ $RESOUT = 511 ]; then
 export IM=1536
 export JM=768
 export timestep=120
fi
if [ $RESOUT = 533 ]; then
 export IM=1600
 export JM=800
 export timestep=120
fi
if [ $RESOUT = 666 ]; then
 export IM=2000
 export JM=1000
 export timestep=90
fi
if [ $RESOUT = 863 ]; then
 export IM=2592
 export JM=1296
 export timestep=60
fi
if [ $RESOUT = 1279 ]; then
 export IM=3840
 export JM=1920
 export timestep=20
fi
if [ $RESOUT = 1332 ]; then
 export IM=4000
 export JM=2000
 export timestep=20
fi
if [[ "$SetLinear" = "TRUE" ]]; then
export TRUNC=`echo ${RESOUT} |awk '{ printf("TL%4.4d\n",$1)  }' `
export MRES=`echo ${TRC} ${LV} |awk '{ printf("TL%4.4dL%3.3d\n",$1,$2)  }' `
else
export TRUNC=`echo ${RESOUT} |awk '{ printf("TQ%4.4d\n",$1)  }' `
export MRES=`echo ${TRC} ${LV} |awk '{ printf("TQ%4.4dL%3.3d\n",$1,$2)  }' `
fi
export TRUNCA=`echo ${TRC} ${LV} |awk '{ printf("T%4.4dL%3.3d\n",$1,$2)  }' `

export pfxgrd=`echo ${JM} ${LV} |awk '{ printf("G%5.5dL%3.3d\n",$1,$2)  }' `

prefix=`echo ${JM} |awk '{ printf("%5.5d\n",$1)  }' `

#set run date

echo $DATA
if [ -z "${AnlPref}" ] ;then
export AnlPref=gdas1
fi 

export dirhome=${HOME_suite}/pre
export dirdata=${DK_suite}
export dirgrads=${DIRGRADS}

# Machine options: SX6; Linux
export MAQUI=Darwin
export PBS_SERVER=${pbs_server2}


#
# Set <pre-scripts>=1 to execute or <pre-scripts>=0 not execute
# 
if [ $total -eq 1 ]; then
TopoWaterPercNavy=0
TopoWaterPercGT30=0 
NormalModes=0
LandSeaMask=1
Chopping_serial=0
Chopping_parallel=1
VarTopo=1
TopoSpectral=1
VegetationMaskSSiB=1
VegetationMask=1
VegetationMaskSiB2Clima=1
VegetationMaskSiB2=1
VegetationMaskIBISClima=1
VegetationMaskIBIS=1
VegetationAlbedoSSiB=1
DeepSoilTemperatureClima=1
DeepSoilTemperature=1
RoughnessLengthClima=1
RoughnessLength=1
SoilMoistureClima=1
SoilMoisture=1
AlbedoClima=1
Albedo=1
SnowClima=1
SSTClima=1
FLUXCO2Clima=1
SSTWeeklyNCEP=0
SSTWeekly=0
SNOWWeeklyNCEP=0
SNOWWeekly=0
SoilMoistureWeeklyCPTEC=0
SoilMoistureWeekly=0
CLimaSoilMoistureClima=1
CLimaSoilMoisture=1
ClmtClima=1
Clmt=1
DeltaTempColdestClima=1
DeltaTempColdest=1
NDVIClima=1
NDVI=1
PorceClayMaskIBISClima=1
PorceClayMaskIBIS=1
PorceClayMaskSiB2Clima=1
PorceClayMaskSiB2=1
PorceSandMaskIBISClima=1
PorceSandMaskIBIS=1
PorceSandMaskSiB2Clima=1
PorceSandMaskSiB2=1
SoilTextureMaskSiB2Clima=1
SoilTextureMaskSiB2=1
CO2MonthlyDirec=1
SSTMonthlyDirec=1
SSTDailyDirec=1
TopographyGradient=1
else
TopoWaterPercGT30=0
TopoWaterPercNavy=0
NormalModes=0
LandSeaMask=0
VarTopo=0
TopoSpectral=0
Chopping_serial=0
Chopping_parallel=0
VegetationMaskSSiB=0
VegetationMask=0
VegetationMaskSiB2Clima=0
VegetationMaskSiB2=0
VegetationMaskIBISClima=0
VegetationMaskIBIS=0
VegetationAlbedoSSiB=0
DeepSoilTemperatureClima=0
DeepSoilTemperature=0
RoughnessLengthClima=0
RoughnessLength=0
SoilMoistureClima=0
SoilMoisture=0
AlbedoClima=0
Albedo=0
SnowClima=1
SSTClima=1
FLUXCO2Clima=1
SSTWeeklyNCEP=1
SSTWeekly=1
SNOWWeeklyNCEP=0
SNOWWeekly=0
SoilMoistureWeeklyCPTEC=1
SoilMoistureWeekly=1
CLimaSoilMoistureClima=0
CLimaSoilMoisture=0
ClmtClima=0
Clmt=0
DeltaTempColdestClima=0
DeltaTempColdest=0
NDVIClima=0
NDVI=0
PorceClayMaskIBISClima=0
PorceClayMaskIBIS=0
PorceClayMaskSiB2Clima=0
PorceClayMaskSiB2=0
PorceSandMaskIBISClima=0
PorceSandMaskIBIS=0
PorceSandMaskSiB2Clima=0
PorceSandMaskSiB2=0
SoilTextureMaskSiB2Clima=0
SoilTextureMaskSiB2=0
SSTMonthlyDirec=0
CO2MonthlyDirec=0
SSTDailyDirec=0
TopographyGradient=1
fi

yyyy=`echo ${DATA} |awk '{ printf("%4.4d\n",substr($1,1,4))  }'`
mm=`echo  ${DATA}  |awk '{ printf("%2.2d\n",substr($1,5,2))  }'`
dd=`echo  ${DATA}  |awk '{ printf("%2.2d\n",substr($1,7,2))  }'`
hh=`echo  ${DATA}  |awk '{ printf("%2.2d\n",substr($1,9,2))  }'`

cp /stornext/online9/DATAIN_DMD/analise_gfs/${yyyy}${mm}/${dd}${hh}/gdas1.T00Z.SAnl.${yyyy}${mm}${dd}${hh}  ${dirdata}/pre/datain
cp /stornext/online9/DATAIN_DMD/analise_gfs/${yyyy}${mm}/${dd}${hh}/gdas1.T00Z.sstgrb2.${yyyy}${mm}${dd}${hh} ${dirdata}/pre/datain

HH=`echo ${DATA} |cut -c9-10`
DATASUMD=${3}

DATAUMD1=`echo ${DATASUMD} |cut -c1-6`

dirumid=/scratchout/oper/tempo/Umid_Solo/dataout
dirumid2=/stornext/oper/tempo/Umid_Solo/${DATAUMD1}/${dd}${hh}

if [ -s ${dirumid}/GL_SM.GPNR.${DATASUMD}.vfm ];then
cp -f ${dirumid}/GL_SM.GPNR.${DATASUMD}.vfm ${dirdata}/pre/datain/GL_SM.GPNR.${DATA}.vfm
echo "existe"
else
if [ -s ${dirumid2}/GPNR_${DATASUMD}.tgz ];then
cp -f ${dirumid2}/GPNR_${DATASUMD}.tgz ${dirdata}/pre/datain/GPNR_${DATASUMD}.tgz
cd ${dirdata}/pre/datain/
tar -zxvf  ${dirdata}/pre/datain/GPNR_${DATASUMD}.tgz
cd -
else
echo "nao existe"
fi
echo "nao existe"
fi

if [ $TopoWaterPercNavy -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_TopoWaterPercNavy.bash 1 1 TopoNavy hold
   ${dirhome}/scripts/run_TopoWaterPercNavy.bash  1 1 TopoNavy hold
   file_out=${dirdata}/pre/dataout/TopoNavy.dat
   file_out2=${dirdata}/pre/dataout/WaterNavy.dat
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done
   if test ! -s ${file_out} ; then 
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else if test ! -s ${file_out2} ; then
      echo "Problema!!! Nao foi gerado ${file_out2} "
      exit 1
   else
      echo
      echo "Fim do TopoWaterPercNavy"
      echo
   fi
   fi
fi

if [ $TopoWaterPercGT30 -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_TopoWaterPercGT30.bash  1 1 GT30 hold
   ${dirhome}/scripts/run_TopoWaterPercGT30.bash 1 1 GT30 hold
   file_out=${dirdata}/pre/dataout/TopoGT30.dat
   file_out2=${dirdata}/pre/dataout/WaterGT30.dat
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
      let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done
   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else if test ! -s ${file_out2} ; then
      echo "Problema!!! Nao foi gerado ${file_out2} "
      exit 1
   else
      echo
      echo "Fim do TopoWaterPercGT30"
      echo
   fi
   fi
fi

if [ $NormalModes -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_NormalModes.bash  1 1 NormalModes hold 
   ${dirhome}/scripts/run_NormalModes.bash  1 1 NormalModes hold
   file_out=${dirdata}/model/datain/NMI.${TRUNCA}
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
      let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done
   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else
      echo
      echo "Fim do NormalModes"
      echo
   fi
fi

if [ $LandSeaMask -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_LandSeaMask.bash  1 1 SeaMask hold 
   ${dirhome}/scripts/run_LandSeaMask.bash  1 1 SeaMask hold
   file_out=${dirdata}/pre/dataout/LandSeaMaskNavy.G${prefix}.dat
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
      let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done
   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else
      echo
      echo "Fim do LandSeaMask"
      echo
   fi
fi

if [ $VarTopo -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_VarTopo.bash  1 1 VarTop hold
   ${dirhome}/scripts/run_VarTopo.bash  1 1 VarTop  hold
   file_out=${dirdata}/pre/dataout/Topography.G${prefix}
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
      let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done
   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else
      echo
      echo "Fim do VarTopo"
      echo
   fi
fi

if [ $TopoSpectral -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_TopoSpectral.bash   1 1 TopoSpectra hold
   ${dirhome}/scripts/run_TopoSpectral.bash    1 1 TopoSpectra hold
   file_out=${dirdata}/model/datain/TopoVariance.G${prefix}
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done
   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else
      echo
      echo "Fim do TopoSpectral"
      echo
   fi
fi 


if [ $Chopping_serial -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_Chopping_serial.bash  1 1 Chopping hold
   ${dirhome}/scripts/run_Chopping_serial.bash  1 1 Chopping hold
   file_out=${dirdata}/model/datain/GANL${PREFXI}${DATA}S.unf.${MRES}
   file_out2=${dirdata}/model/datain/OZON${PREFXI}${DATA}S.grd.${pfxgrd}
   cp -fp ${dirdata}/model/datain/GANLNMC${DATA}S.unf.${MRES} ${file_out}
   cp -fp ${dirdata}/model/datain/OZONNMC${DATA}S.grd.${pfxgrd} ${file_out2}
   cp -fp ${dirdata}/model/datain/GANLSMT${DATA}S.unf.${MRES} ${file_out}
   cp -fp ${dirdata}/model/datain/OZONSMT${DATA}S.grd.${pfxgrd} ${file_out2}
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done
   cp -fp ${dirdata}/model/datain/GANLNMC${DATA}S.unf.${MRES} ${file_out}
   cp -fp ${dirdata}/model/datain/OZONNMC${DATA}S.grd.${pfxgrd} ${file_out2}
   cp -fp ${dirdata}/model/datain/GANLSMT${DATA}S.unf.${MRES} ${file_out}
   cp -fp ${dirdata}/model/datain/OZONSMT${DATA}S.grd.${pfxgrd} ${file_out2}
   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else
      echo
      echo "Fim do Chopping_serial"
      echo
   fi
fi 

if [ $Chopping_parallel -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_Chopping_parallel.bash  240 24 Chopping hold
.   ${dirhome}/scripts/run_Chopping_parallel.bash  240 24 Chopping hold
   file_out=${dirdata}/model/datain/GANL${PREFXI}${DATA}S.unf.${MRES}
   file_out2=${dirdata}/model/datain/OZON${PREFXI}${DATA}S.grd.${pfxgrd}
   file_out3=${dirdata}/model/datain/TRAC${PREFXI}${DATA}S.grd.${pfxgrd}
   cp -fp ${dirdata}/model/datain/GANLNMC${DATA}S.unf.${MRES} ${file_out}
   cp -fp ${dirdata}/model/datain/OZONNMC${DATA}S.grd.${pfxgrd} ${file_out2}
   cp -fp ${dirdata}/model/datain/TRACNMC${DATA}S.grd.${pfxgrd} ${file_out3}
   cp -fp ${dirdata}/model/datain/GANLSMT${DATA}S.unf.${MRES} ${file_out}
   cp -fp ${dirdata}/model/datain/OZONSMT${DATA}S.grd.${pfxgrd} ${file_out2}
   cp -fp ${dirdata}/model/datain/TRACSMT${DATA}S.grd.${pfxgrd} ${file_out3} 
    sleep 15
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      cp -fp ${dirdata}/model/datain/GANLNMC${DATA}S.unf.${MRES} ${file_out}
      cp -fp ${dirdata}/model/datain/OZONNMC${DATA}S.grd.${pfxgrd} ${file_out2}
      cp -fp ${dirdata}/model/datain/TRACNMC${DATA}S.grd.${pfxgrd} ${file_out3}
      cp -fp ${dirdata}/model/datain/GANLSMT${DATA}S.unf.${MRES} ${file_out}
      cp -fp ${dirdata}/model/datain/OZONSMT${DATA}S.grd.${pfxgrd} ${file_out2}
      cp -fp ${dirdata}/model/datain/TRACSMT${DATA}S.grd.${pfxgrd} ${file_out3}
      sleep 15
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done
   sleep 20
   cp -fp ${dirdata}/model/datain/GANLNMC${DATA}S.unf.${MRES} ${file_out}
   cp -fp ${dirdata}/model/datain/OZONNMC${DATA}S.grd.${pfxgrd} ${file_out2}
   cp -fp ${dirdata}/model/datain/TRACNMC${DATA}S.grd.${pfxgrd} ${file_out3}
   cp -fp ${dirdata}/model/datain/GANLSMT${DATA}S.unf.${MRES} ${file_out}
   cp -fp ${dirdata}/model/datain/OZONSMT${DATA}S.grd.${pfxgrd} ${file_out2}
   cp -fp ${dirdata}/model/datain/TRACSMT${DATA}S.grd.${pfxgrd} ${file_out3}
   sleep 10
   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else
      echo
      echo "Fim do Chopping_parallel"
      echo
   fi
fi


if [ $VegetationMaskSSiB -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_VegetationMaskSSiB.bash 1 1 VegMasSSiB hold
   ${dirhome}/scripts/run_VegetationMaskSSiB.bash  1 1 VegMasSSiB hold
   file_out=${dirdata}/pre/dataout/VegetationMaskClima.dat
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done

   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else
      echo
      echo "Fim do VegetationMaskSSiB"
      echo
   fi
fi 

if [ $VegetationMask -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_VegetationMask.bash  1 1 VegetationMask  hold
   ${dirhome}/scripts/run_VegetationMask.bash   1 1 VegetationMask  hold
   file_out=${dirdata}/pre/dataout/VegetationMask.G${prefix}
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done
   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else
      echo
      echo "Fim do VegetationMask"
      echo
   fi
fi 

if [ $VegetationMaskSiB2Clima -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_VegetationMaskSiB2Clima.bash 1 1 VegMasSiB2 hold
   ${dirhome}/scripts/run_VegetationMaskSiB2Clima.bash  1 1 VegMasSiB2 hold
   file_out=${dirdata}/pre/dataout/VegetationMaskClima.dat
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done
   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else
      echo
      echo "Fim do VegetationMaskSiB2Clima"
      echo
   fi
fi 

if [ $VegetationMaskSiB2 -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_VegetationMaskSiB2.bash  1 1 VegMaskSiB2  hold
   ${dirhome}/scripts/run_VegetationMaskSiB2.bash   1 1 VegMaskSiB2  hold
   file_out=${dirdata}/pre/dataout/VegetationMaskSiB2.G${prefix}
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done
   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else
      echo
      echo "Fim do VegetationMaskSiB2"
      echo
   fi
fi 

if [ $VegetationMaskIBISClima -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_VegetationMaskIBISClima.bash 1 1 VegMasIBIS hold
   ${dirhome}/scripts/run_VegetationMaskIBISClima.bash  1 1 VegMasIBIS hold
   file_out=${dirdata}/pre/dataout/VegetationMaskIBISClima.dat
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done
   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else
      echo
      echo "Fim do VegetationMaskIBISClima"
      echo
   fi
fi 

if [ $VegetationMaskIBIS -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_VegetationMaskIBIS.bash 1 1 VegMasIBIS hold
   ${dirhome}/scripts/run_VegetationMaskIBIS.bash  1 1 VegMasIBIS hold
   file_out=${dirdata}/pre/dataout/VegetationMaskIBISClima.dat
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done
   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else
      echo
      echo "Fim do VegetationMaskIBIS"
      echo
   fi
fi 

if [ $VegetationAlbedoSSiB -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_VegetationAlbedoSSiB.bash  1 1 VegAlbSSiB  hold
   ${dirhome}/scripts/run_VegetationAlbedoSSiB.bash   1 1 VegAlbSSiB  hold
   file_out=${dirdata}/model/datain/VegetationMask.G${prefix}
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done
   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else
      echo
      echo "Fim do VegetationAlbedoSSiB"
      echo
   fi
fi 

if [ $DeepSoilTemperatureClima -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_DeepSoilTemperatureClima.bash 1 1 DeepSoilTemClim hold
   ${dirhome}/scripts/run_DeepSoilTemperatureClima.bash 1 1 DeepSoilTemClim hold
   file_out=${dirdata}/pre/dataout/DeepSoilTemperatureClima.dat
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done

   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else
      echo
      echo "Fim do DeepSoilTemperatureClima"
      echo
   fi
fi 

if [ $DeepSoilTemperature -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_DeepSoilTemperature.bash  1 1 DeepSoilTemp hold
   ${dirhome}/scripts/run_DeepSoilTemperature.bash 1 1 DeepSoilTemp hold
   file_out=${dirdata}/model/datain/DeepSoilTemperature.G${prefix}
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done

   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else
      echo
      echo "Fim do DeepSoilTemperature"
      echo
   fi
fi 

if [ $RoughnessLengthClima -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_RoughnessLengthClima.bash 1 1 RouLenClm hold
   ${dirhome}/scripts/run_RoughnessLengthClima.bash 1 1 RouLenClm hold 
   file_out=${dirdata}/pre/dataout/RoughnessLengthClima.dat
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done
   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else
      echo
      echo "Fim do RoughnessLengthClima"
      echo
   fi
fi 

if [ $RoughnessLength -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_RoughnessLength.bash  1 1 RougLeng hold
   ${dirhome}/scripts/run_RoughnessLength.bash 1 1 RougLeng hold
   file_out=${dirdata}/model/datain/RoughnessLength.G${prefix}
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done

   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else
      echo
      echo "Fim do RoughnessLength"
      echo
   fi
fi 

if [ $SoilMoistureClima -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_SoilMoistureClima.bash  1 1 SoilMoisClm hold
   ${dirhome}/scripts/run_SoilMoistureClima.bash 1 1 SoilMoisClm hold
   file_out=${dirdata}/pre/dataout/SoilMoistureClima.dat
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done

   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else
      echo
      echo "Fim do SoilMoistureClima"
      echo
   fi
fi 

if [ $SoilMoisture -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_SoilMoisture.bash  1 1 SoilMoist hold
   ${dirhome}/scripts/run_SoilMoisture.bash 1 1 SoilMoist hold
   file_out=${dirdata}/model/datain/SoilMoisture.G${prefix}
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done

   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else
      echo
      echo "Fim do SoilMoisture"
      echo
   fi
fi 

if [ $AlbedoClima -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_AlbedoClima.bash 1 1 AlbClm hold
   ${dirhome}/scripts/run_AlbedoClima.bash 1 1 AlbClm hold
   file_out=${dirdata}/pre/dataout/AlbedoClima.dat
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done

   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else
      echo
      echo "Fim do AlbedoClima"
      echo
   fi
fi 

if [ $Albedo -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_Albedo.bash 1 1 Alb hold
   ${dirhome}/scripts/run_Albedo.bash 1 1 Alb hold
   file_out=${dirdata}/pre/dataout/Albedo.G${prefix}
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done

   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else
      echo
      echo "Fim do Albedo"
      echo
   fi
fi 

if [ $SnowClima -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_SnowClima.bash  1 1 SnowClm hold 
   ${dirhome}/scripts/run_SnowClima.bash 1 1 SnowClm hold 
   file_out=${dirdata}/model/datain/Snow${DATA}S.unf.G${prefix}
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done

   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else
      echo
      echo "Fim do SnowClima"
      echo
   fi
fi 

if [ $SSTClima -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_SSTClima.bash   1 1 SSTClim hold
   ${dirhome}/scripts/run_SSTClima.bash  1 1 SSTClim hold
   datt=`echo ${DATA} |cut -c 1-8`
   file_out=${dirdata}/model/datain/SSTClima$datt.G${prefix}
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done

   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else
      echo
      echo "Fim do SSTClima"
      echo
   fi
fi 

if [ $FLUXCO2Clima -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_FLUXCO2Clima.bash   1 1 FLUXCO2Clim hold
   ${dirhome}/scripts/run_FLUXCO2Clima.bash  1 1 FLUXCO2Clim hold
   datt=`echo ${DATA} |cut -c 1-8`
   file_out=${dirdata}/model/datain/FLUXCO2Clima$datt.G${prefix}
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done

   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else
      echo
      echo "Fim do FLUXCO2Clima"
      echo
   fi
fi

if [ $SSTWeeklyNCEP -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_SSTWeeklyNCEP.bash 1 1 SSTWeeklyNCEP hold
   ${dirhome}/scripts/run_SSTWeeklyNCEP.bash 1 1 SSTWeeklyNCEP hold
   datt=`echo ${DATA} |cut -c 1-8`
   file_out=${dirdata}/pre/dataout/SSTWeekly.$datt
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done

   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else

      echo
      echo "Fim do SSTWeeklyNCEP"
      echo
   fi
fi 

if [ $SSTWeekly -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_SSTWeekly.bash  1 1 SSTWeekly hold
   ${dirhome}/scripts/run_SSTWeekly.bash 1 1 SSTWeekly hold
   datt=`echo ${DATA} |cut -c 1-8`
   file_out=${dirdata}/model/datain/SSTWeekly$datt.G${prefix}
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done

   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else
      echo
      echo "Fim do SSTWeekly"
      echo
   fi
fi 

if [ $SNOWWeeklyNCEP -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_SNOWWeeklyNCEP.bash 1 1 SNOWWeeklyNCEP hold
   ${dirhome}/scripts/run_SNOWWeeklyNCEP.bash 1 1 SNOWWeeklyNCEP hold
   datt=`echo ${DATA} |cut -c 1-8`
   file_out=${dirdata}/pre/dataout/SNOWWeekly.$datt
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done

   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else

      echo
      echo "Fim do SNOWWeeklyNCEP"
      echo
   fi
fi 

if [ $SoilMoistureWeeklyCPTEC -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_SoilMoistureWeeklyCPTEC.bash 1 1 SoilMWCPTEC hold
   ${dirhome}/scripts/run_SoilMoistureWeeklyCPTEC.bash 1 1 SoilMWCPTEC hold
   datt=`echo ${DATA} |cut -c 1-8`
   file_out=${dirdata}/pre/dataout/SoilMoistureWeekly.$datt 
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done

   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else

      echo
      echo "Fim do SoilMoistureWeeklyCPTEC"
      echo
   fi
fi 

if [ $SNOWWeekly -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_SNOWWeekly.bash  1 1 SNOWWeekly hold
   ${dirhome}/scripts/run_SNOWWeekly.bash 1 1 SNOWWeekly hold
   datt=`echo ${DATA} |cut -c 1-8`
   file_out=${dirdata}/model/datain/SNOWWeekly.$datt.G${prefix}
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done

   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else
      echo
      echo "Fim do SSTWeekly"
      echo
   fi
fi 

if [ $SoilMoistureWeekly -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_$SoilMoistureWeekly.bash  1 1 SoilMW hold
   ${dirhome}/scripts/run_SoilMoistureWeekly.bash 1 1 SoilMW hold
   datt=`echo ${DATA} |cut -c 1-8`
   file_out=${dirdata}/model/datain/SoilMoistureWeekly.$datt.G${prefix}
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done

   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else
      echo
      echo "Fim do SoilMoistureWeekly"
      echo
   fi
fi 

if [ $CLimaSoilMoistureClima -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_CLimaSoilMoistureClima.bash 1 1 CSoilMoisC hold
   ${dirhome}/scripts/run_CLimaSoilMoistureClima.bash 1 1 CSoilMoisC hold
   file_out=${dirdata}/pre/dataout/CLimaSoilMoistureClima.dat
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done
   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else
      echo
      echo "Fim do CLimaSoilMoistureClima"
      echo
   fi
fi 

if [ $CLimaSoilMoisture -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_CLimaSoilMoisture.bash 1 1 CSoilMoisture hold
   ${dirhome}/scripts/run_CLimaSoilMoisture.bash 1 1 CSoilMoisture hold
   file_out=${dirdata}/model/datain/CLimaSoilMoisture.G${prefix}
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done
   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else
      echo
      echo "Fim do CLimaSoilMoisture"
      echo
   fi
fi 

if [ $ClmtClima -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_ClmtClima.bash 1 1 ClmtClima hold
   ${dirhome}/scripts/run_ClmtClima.bash 1 1 ClmtClima hold
   file_out=${dirdata}/pre/dataout/TemperatureClima.dat
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done
   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else
      echo
      echo "Fim do ClmtClima"
      echo
   fi
fi 

if [ $Clmt -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_Clmt.bash 1 1 Clmt hold
   ${dirhome}/scripts/run_Clmt.bash 1 1 Clmt hold
   file_out=${dirdata}/model/datain/Temperature.G${prefix}
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done
   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else
      echo
      echo "Fim do Clmt"
      echo
   fi
fi 

if [ $DeltaTempColdestClima -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_DeltaTempColdestClima.bash 1 1 DelTempColdC hold
   ${dirhome}/scripts/run_DeltaTempColdestClima.bash 1 1 DelTempColdC hold
   file_out=${dirdata}/pre/dataout/DeltaTempColdestClima.dat
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done
   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else
      echo
      echo "Fim do DeltaTempColdestClima"
      echo
   fi
fi 

if [ $DeltaTempColdest -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_DeltaTempColdest.bash 1 1 DelTempCold hold
   ${dirhome}/scripts/run_DeltaTempColdest.bash 1 1 DelTempCold hold
   file_out=${dirdata}/model/datain/DeltaTempColdes.G${prefix}
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done
   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else
      echo
      echo "Fim do DeltaTempColdest"
      echo
   fi
fi 

if [ $NDVIClima -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_NDVIClima.bash 1 1 NDVIClima hold
   ${dirhome}/scripts/run_NDVIClima.bash 1 1 NDVIClima hold
   file_out=${dirdata}/pre/dataout/NDVIClima.dat
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done
   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else
      echo
      echo "Fim do NDVIClima"
      echo
   fi
fi 

if [ $NDVI -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_NDVI.bash 1 1 run_NDVI hold
   ${dirhome}/scripts/run_NDVI.bash 1 1 NDVI hold
   file_out=${dirdata}/model/datain/NDVI.G${prefix}
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done
   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else
      echo
      echo "Fim do NDVI"
      echo
   fi
fi 

if [ $PorceClayMaskIBISClima -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_PorceClayMaskIBISClima.bash 1 1 PcClayMaskIBISC hold
   ${dirhome}/scripts/run_PorceClayMaskIBISClima.bash 1 1 PcClayMaskIBISC hold
   file_out=${dirdata}/pre/dataout/PorceClayMaskIBISClima.dat
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done
   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else
      echo
      echo "Fim do PorceClayMaskIBISClima"
      echo
   fi
fi 

if [ $PorceClayMaskIBIS -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_PorceClayMaskIBIS.bash 1 1 PcClayMaskIBIS hold
   ${dirhome}/scripts/run_PorceClayMaskIBIS.bash 1 1 PcClayMaskIBIS hold
   file_out=${dirdata}/model/datain/PorceClayMaskIBIS.G${prefix}
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done
   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else
      echo
      echo "Fim do PorceClayMaskIBIS"
      echo
   fi
fi 

if [ $PorceClayMaskSiB2Clima -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_PorceClayMaskSiB2Clima.bash 1 1 PcClayMskSiB2C hold
   ${dirhome}/scripts/run_PorceClayMaskSiB2Clima.bash 1 1 PcClayMskSiB2C hold
   file_out=${dirdata}/pre/dataout/PorceClayMaskSiB2Clima.dat
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done
   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else
      echo
      echo "Fim do PorceClayMaskSiB2Clima"
      echo
   fi
fi 
if [ $PorceClayMaskSiB2 -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_PorceClayMaskSiB2.bash 1 1 PcClayMskSiB2 hold
   ${dirhome}/scripts/run_PorceClayMaskSiB2.bash 1 1 PcClayMskSiB2 hold
   file_out=${dirdata}/model/datain/PorceClayMaskSiB2.G${prefix}
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done
   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else
      echo
      echo "Fim do PorceClayMaskSiB2"
      echo
   fi
fi 
if [ $PorceSandMaskIBISClima -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_PorceSandMaskIBISClima.bash 1 1 PcSandMskIBISC hold
   ${dirhome}/scripts/run_PorceSandMaskIBISClima.bash 1 1 PcSandMskIBISC hold
   file_out=${dirdata}/pre/dataout/PorceSandMaskIBISClima.dat
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done
   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else
      echo
      echo "Fim do PorceSandMaskIBISClima"
      echo
   fi
fi 

if [ $PorceSandMaskIBIS -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_PorceSandMaskIBIS.bash 1 1 PcSandMskIBIS hold
   ${dirhome}/scripts/run_PorceSandMaskIBIS.bash 1 1 PcSandMskIBIS hold
   file_out=${dirdata}/model/datain/PorceSandMaskIBIS.G${prefix}
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done
   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else
      echo
      echo "Fim do PorceSandMaskIBIS"
      echo
   fi
fi 
if [ $PorceSandMaskSiB2Clima -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_PorceSandMaskSiB2Clima.bash 1 1 PcSandMskSiB2C hold
   ${dirhome}/scripts/run_PorceSandMaskSiB2Clima.bash 1 1 PcSandMskSiB2C hold
   file_out=${dirdata}/pre/dataout/PorceSandMaskSiB2Clima.dat
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done
   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else
      echo
      echo "Fim do PorceSandMaskSiB2Clima"
      echo
   fi
fi 
if [ $PorceSandMaskSiB2 -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_PorceSandMaskSiB2.bash 1 1 PcSandMskSiB2 hold
   ${dirhome}/scripts/run_PorceSandMaskSiB2.bash 1 1 PcSandMskSiB2 hold
   file_out=${dirdata}/model/datain/PorceSandMaskSiB2.G${prefix}
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done
   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else
      echo
      echo "Fim do PorceSandMaskSiB2"
      echo
   fi
fi 
if [ $SoilTextureMaskSiB2Clima -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_SoilTextureMaskSiB2Clima.bash 1 1 SoilTxMskSiB2C hold
   ${dirhome}/scripts/run_SoilTextureMaskSiB2Clima.bash 1 1 SoilTxMskSiB2C hold
   file_out=${dirdata}/pre/dataout/SoilTextureMaskClima.dat
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done
   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else
      echo
      echo "Fim do SoilTextureMaskSiB2Clima"
      echo
   fi
fi 
if [ $SoilTextureMaskSiB2 -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_SoilTextureMaskSiB2.bash 1 1 SoilTxMskSiB2 hold
   ${dirhome}/scripts/run_SoilTextureMaskSiB2.bash 1 1 SoilTxMskSiB2 hold
   file_out=${dirdata}/model/datain/SoilTextureMaskSiB2.G${prefix}
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done
   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else
      echo
      echo "Fim do SoilTextureMaskSiB2"
      echo
   fi
fi 
if [ $SSTMonthlyDirec -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_SSTMonthlyDirec.bash 1 1 SSTMonthlyDirec hold
   ${dirhome}/scripts/run_SSTMonthlyDirec.bash 1 1 SSTMonthlyDirec hold
   DATA1=`echo ${DATA} | awk '{print substr($1,1,8)}'`
   file_out=${dirdata}/model/datain/SSTMonthlyDirec${DATA1}.G${prefix}
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done
   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else
      echo
      echo "Fim do SSTMonthlyDirec"
      echo
   fi
fi 
if [ $CO2MonthlyDirec -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_CO2MonthlyDirec.bash 1 1 CO2MonthlyDirec hold
   ${dirhome}/scripts/run_CO2MonthlyDirec.bash 1 1 CO2MonthlyDirec hold
   DATA1=`echo ${DATA} | awk '{print substr($1,1,8)}'`
   file_out=${dirdata}/model/datain/CO2MonthlyDirec${DATA1}.G${prefix}
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done
   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else
      echo
      echo "Fim do CO2MonthlyDirec"
      echo
   fi
fi 
if [ $SSTDailyDirec -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_SSTDailyDirec.bash 1 1 SSTDailyDirec hold
   ${dirhome}/scripts/run_SSTDailyDirec.bash 1 1 SSTDailyDirec hold
   DATA1=`echo ${DATA} | awk '{print substr($1,1,8)}'`
   file_out=${dirdata}/model/datain/SSTDailyDirec${DATA1}.G${prefix}
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done
   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else
      echo
      echo "Fim do SSTDaylyDirec"
      echo
   fi
fi
if [ $TopographyGradient -eq 1 ]; then
   echo executando: ${dirhome}/scripts/run_TopographyGradient.bash  1 1 TopographyGradient hold
   ${dirhome}/scripts/run_TopographyGradient.bash 1 1 TopoGrad hold
   datt=`echo ${DATA} |cut -c 1-8`
   file_out=${dirdata}/model/datain/TopographyGradient${DATA}.G${prefix}
   it=0
   itr=0
   while [ ${itr} -lt 1 ];do
      sleep 15 
       let itr=`ls ${file_out} | wc -l|awk '{print $1/1}'`
      let it=${it}+1
      if [ $it -eq 20 ];then
         let itr=$itr+20
      fi
   done
   if test ! -s ${file_out} ; then
      echo "Problema!!! Nao foi gerado ${file_out} "
      exit 1
   else
      echo
      echo "Fim do TopographyGradient"
      echo
   fi
fi 
