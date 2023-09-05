function [ ns ] = Energy_segment(  Dat_Cost, Conn_Weight, Smo_Cost, LC_Mat, Value, Neigh  )
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明
[NumSites, NumLabels] = size(Dat_Cost);%the number of labels should be decided carefully.
h = GCO_Create(NumSites, NumLabels);             % Create new object with NumSites=4, NumLabels=3
%Initial umber og labels equals NumSites
GCO_SetDataCost(h, Dat_Cost);%Dat_Cost  ones(NumSites, NumSites)-diag(ones(NumSites,1))
%size : NumLabels * NumSites
% GCO_SetDataCost(h,[
%         0 9 2 0;                         % Sites 1,4 prefer  label 1
%         3 0 3 3;                         % Site  2   prefers label 2 (strongly)
%         5 9 0 5;                         % Site  3   prefers label 3
%         ]);
GCO_SetSmoothCost(h, Smo_Cost);%exp(LC_Mat)Smo_Cost
% GCO_SetSmoothCost(h,[
%         0 1 2;      % 
%         1 0 1;      % Linear (Total Variation) pairwise cost
%         2 1 0;      %
%         ]);
Nei_Mat = Conn_Weight; %Conn_Weight size : NumSites * NumSites; Weight:the weight of connection
GCO_SetNeighbors(h, Nei_Mat);
% GCO_SetNeighbors(h,[
%         0 1 0 0;     % Sites 1 and 2 connected with weight 1
%         0 0 1 0;     % Sites 2 and 3 connected with weight 1
%         0 0 0 2;     % Sites 3 and 4 connected with weight 2
%         0 0 0 0;
%         ]);
% GCO_SetLabelCost(h,exp(-Value)); 
GCO_Expansion(h);                % Compute optimal labeling via alpha-expansion 
ns = GCO_GetLabeling(h);
[E D S] = GCO_ComputeEnergy(h);   % Energy = Data Energy + Smooth Energy
GCO_Delete(h);                   % Delete the GCoptimization object when finished

end

