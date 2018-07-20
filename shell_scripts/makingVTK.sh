#!/bin/bash

of5x

num=$(awk 'BEGIN{for(i=0;i<=127;i++)print i}')
for n in $num
do
  cd processor$n
  echo "inside the directory " processor$n
  foamToVTK 
  cd ..
  echo "outside the directory " processor$n
done
