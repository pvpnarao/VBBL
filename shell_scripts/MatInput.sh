#!/bin/bash

#postProcess -func writeCellCentres


sed -n $1,$2p 0/C>InletFaceCenters

sed -i '1,2d' InletFaceCenters

sed -i 's/[()]//g' InletFaceCenters

