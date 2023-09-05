%Demo 
%% Geometric Contour Extraction and Segmentation
warning off;
clear;
clc;
addpath('Code');

%% Load Data
addpath('Data');
load('newData_ship_part2.mat');%volume data

% move the ship to a complex place
load('ship_wreck_volume_XYZI_miss.mat')
newData(21:74,41:71,115:155) = newData(21:74,41:71,115:155)+ship_wreck_volume_XYZI_miss(1:54,1:31,1:41);
I = newData;

%% Extraction
PickingDemo;% outputs newout as horizons

%% Save Contour Data
fid=fopen(['D:\','missdaya.txt'],'w');%the path,  % you can reset it
B = [X', Y', Z', II'];
[r,c]=size(B);            
 for i=1:r
  for j=1:c
  fprintf(fid,'%f\t',B(i,j));
  end
  fprintf(fid,'\r\n');
 end
fclose(fid);
clear B C;

%% Contour Extraction
%JJ: horizon segments; 
%Value: the length of ith horizon segment; 
%Judge: the label of a horizon segment
I = Iout;
path0 = 'E:\'; % you can reset it
Tracking3D;% horizon tracking to get horizon segments. outputs JJ Value and Judge
time = 1;
Dat_pattern = 1;

%% horizon segment segmentation using global energy optimization
path = 'E:\SingleFile_'; % you can reset it\\ the segmented contour will be saved here
[ JJ_new, Value_new, Judge_new, newout_new ] = Demo_Time( JJ, Value, Judge, newout, theta, time,Dat_pattern, path);
clear JJ Value Judge newout ;
time = 2;
Dat_pattern = 1;
[ JJ, Value, Judge, newout ] = Demo_Time( JJ_new, Value_new, Judge_new, newout_new, theta, time,Dat_pattern, path);
clear JJ_ne Value_new Judge_new newout_new;
time = 3;
Dat_pattern = 1;
[ JJ_new, Value_new, Judge_new, newout_new ] = Demo_Time( JJ, Value, Judge, newout, theta, time,Dat_pattern, path);
