# 3D-SBP
The data and code for paper "A Comprehensive buried shipwreck detection method based on 3D SBP data"
1. Geometric contour extraction can be employed through Demo.m in file "3D_SBP_Geometric_Contour_Extraction".
2. The result of Geometric contour extraction is a set of contours save in .txt form.
3. Calculating the shipwreck index (SI) using Detection.m based on the contour data, the contour with the highest SI which is higher than a given threshold is the shipwreck contour. This means that shipwreck detection based on geometric contour data can be realized by running the Detection.m file
4. .figs show the extracted voxles and shipwreck model and its corresponding voxels.
5.  The test data in "3D_SBP_Geometric_Contour_Extraction" is the simulated shipwreck data in a complex sub-bottom environment.
