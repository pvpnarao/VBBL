#### import the simple module from the paraview
from paraview.simple import *
#### disable automatic camera reset on 'Show'
import numpy as np

nprocs = 128 
step = 1
procDir   = "/home/pavan/OpenFOAM/pavan-5.x/run/PSPH1/"
Yarray   = np.arange(0,nprocs,step)

for Y in Yarray:
    # Store line data here
    caseName = "%s/processor%d/VTK/processor%d_0.vtk" % (procDir,Y,Y)
    readername = "processor%d_0vtk" % Y 
    displayname = "processor%d_0vtkDisplay" % Y 
    rederview = "renderView%d" % Y
    readername = LegacyVTKReader(FileNames = [caseName])    
