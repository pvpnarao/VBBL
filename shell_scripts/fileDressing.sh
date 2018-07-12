#!/bin/bash


#for i in $(<times); do
#	echo $i;
#done
	
num=$(awk 'BEGIN{for(i=0;i<=10;i+=0.01)print i}')
for n in constant/boundaryData/IN/$num
do
  cd $n
  echo "inside the directory " $n
  sed -i 's/,/ /g' U 
  sed -i 's/.*/(&)/' U
  sed -i '1s/^/2064\n/' U
  sed -i '2s/^/(\n/' U
  sed -i -e "\$a)" U
  cd ..
  echo "outside the directory " $n
done
