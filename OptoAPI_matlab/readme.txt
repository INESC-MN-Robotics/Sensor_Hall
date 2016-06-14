This is the OptoForce API for MATLAB (32 and 64 bits are supported). 
(It is based on our C++ API, for further info visit: http://optoforce.com/support/ )

The example.m uses two custom MATLAB classes (these are in the same folder as the example.m)
- OptoPorts.m
- OptoDAQ.m

The above two classes rely on two custom Mex files (you can find these in the "mex_files\32(64)bit" folder)
-OptoPorts_API.mexw32(64)
-OptoDAQ_API.mexw32(64)

that directly calls our DLL-s that are also stored in the .\mex_files\32(64)bit folder. 

(That's why the addpath '.\mex_files\64bit'; is used in the header of the code.)

These DLLs and folders structure must be also extracted from the zip file in order to get the code working.

If you would like to avoid the folder structure, you can copy the
- example.m
- OptoPorts.m
- OptoDAQ.m
files to the .\mex_files\64bits (where the DLLs are) and run the example.m from there. 