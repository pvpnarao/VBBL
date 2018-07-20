#!/bin/bash
clear
rm -rf RO*
cp -r MasROUTLET ROUTLET1 
num=$(awk 'BEGIN{for(i=1;i<=63;i++) print i}')
ZEROFILEPATH="/home/pavan/OpenFOAM/pavan-5.x/run/Procedure_tutorial/"
rm -rf $ZEROFILEPATH/0/pNew
rm -rf $ZEROFILEPATH/system/cDictNew
touch $ZEROFILEPATH/0/pNew
touch $ZEROFILEPATH/system/cDictNew
echo -e "(" >> $ZEROFILEPATH/system/cDictNew
for n in $num
do
  cp -r ROUTLET1 RO$n
  cd RO$n
  echo "Creating the resistance outlet" RO$n
  echo "*******************************************************"
  mv ROUTLET1FvPatchScalarField.C  RO${n}FvPatchScalarField.C
  mv ROUTLET1FvPatchScalarField.H  RO${n}FvPatchScalarField.H
  sed -i "s/ROUTLET1/RO${n}/g" RO${n}FvPatchScalarField.H 
  sed -i "s/ROUTLET1/RO${n}/g" RO${n}FvPatchScalarField.C
  sed -i "s/OUT1/O${n}/g" RO${n}FvPatchScalarField.C
  sed -i "s/ROUTLET1/RO${n}/g" Make/files
  wclean
  wmake libso 
  echo $'\n' 
  echo "updating the pressure boundary condition in the 0/p file"
  echo -e "\t O$n" >> $ZEROFILEPATH/0/pNew
  echo -e "\t {" >> $ZEROFILEPATH/0/pNew
  echo -e "\t \t type \t \t RO$n; " >> $ZEROFILEPATH/0/pNew
  echo -e "\t \t z \t \t \t uniform 0; " >> $ZEROFILEPATH/0/pNew
  echo -e "\t \t value \t \t uniform 0; " >> $ZEROFILEPATH/0/pNew
  echo -e "\t }" >> $ZEROFILEPATH/0/pNew
  echo -e "\n \n" >> $ZEROFILEPATH/0/pNew 
  echo $'\n'  
  echo "updating the controlDict file"
  echo -e ""libRO${n}.so"" >> $ZEROFILEPATH/system/cDictNew
  cd ..
  echo "moving out from the directory " RO$n
  echo $'________________________________________________________ \n \n \n' 
done
sed -i 's/.*/"&"/' ../system/cDictNew
echo -e "); \n" >> $ZEROFILEPATH/system/cDictNew

