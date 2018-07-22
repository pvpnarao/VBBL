#!/bin/bash

#postProcess -func writeCellCentres


sed -i 's/,/ /g' inletVelocity.csv

sed -i 's/.*/(&)/' inletVelocity.csv

