#!/bin/bash
clear

 
num=$(awk 'BEGIN{for(i=1;i<=63;i++) print i}')
ZEROFILEPATH="/home/pavan/OpenFOAM/pavan-5.x/run/Procedure_tutorial"

rm -rf $ZEROFILEPATH/system/fSetNew
touch $ZEROFILEPATH/system/fSetNew

echo -e "actions" >> $ZEROFILEPATH/system/fSetNew
echo -e "(" >> $ZEROFILEPATH/system/fSetNew
for n in $num
do
 echo -e "\t {" >> $ZEROFILEPATH/system/fSetNew
 echo -e "\t \t name \t fSet$n;" >> $ZEROFILEPATH/system/fSetNew
 echo -e "\t \t type \t faceSet;" >> $ZEROFILEPATH/system/fSetNew
 echo -e "\t \t action \t new;" >> $ZEROFILEPATH/system/fSetNew
 echo -e "\t \t source \t patchToFace;" >> $ZEROFILEPATH/system/fSetNew
 echo -e "\t \t sourceInfo" >> $ZEROFILEPATH/system/fSetNew
 echo -e "\t \t { " >> $ZEROFILEPATH/system/fSetNew
 echo -e "\t \t \t name \t O$n;" >> $ZEROFILEPATH/system/fSetNew
 echo -e "\t \t  } " >> $ZEROFILEPATH/system/fSetNew       
 echo -e "\t } \n " >> $ZEROFILEPATH/system/fSetNew   
done
echo -e "); \n" >> $ZEROFILEPATH/system/fSetNew

kate system/fSetNew
