#!/bin/bash

clear

num=$(awk 'BEGIN{for(i=1;i<=63;i++) print i}')
ZEROFILEPATH="/home/pavan/OpenFOAM/pavan-5.x/run/Procedure_tutorial"

rm -rf $ZEROFILEPATH/system/procsNew
touch $ZEROFILEPATH/system/procsNew

echo -e "constraints" >> $ZEROFILEPATH/system/procsNew
echo -e "\t { " >> $ZEROFILEPATH/system/procsNew
echo -e "\t \t singleProcessorFaceSets " >> $ZEROFILEPATH/system/procsNew
echo -e "\t \t { " >> $ZEROFILEPATH/system/procsNew
echo -e "\t \t \t type \t \t singleProcessorFaceSets;" >> $ZEROFILEPATH/system/procsNew
echo -e "\t \t \t singleProcessorFaceSets (" >> $ZEROFILEPATH/system/procsNew
for n in $num
do
 echo -e "\t \t \t \t (fSet$n -1)" >> $ZEROFILEPATH/system/procsNew
done
echo -e "\t \t \t ); " >> $ZEROFILEPATH/system/procsNew
echo -e "\t \t } " >> $ZEROFILEPATH/system/procsNew
echo -e "\t } " >> $ZEROFILEPATH/system/procsNew

kate system/procsNew 
