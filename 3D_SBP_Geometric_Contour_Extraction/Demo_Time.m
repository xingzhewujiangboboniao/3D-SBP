function [ JJ_new, Value_new, Judge_new, newout_new ] = Demo_Time( JJ, Value, Judge, newout, theta,time ,Dat_pattern, path)
% employing energy optimization
[ Neigh, weight, Weight ] = MyConvexHull(JJ, Value, Judge, newout, theta, 3);% calculate convex
[ Dat_Cost, Conn_Weight, Smo_Cost, LC_Mat, Neigh ] = Cal_Cost( JJ, Judge, Value, newout, Neigh, weight, Weight, Dat_pattern );
Neigh(find(Neigh==0)) = 999;% neighboor matrix
Neigh(find(Neigh==1)) = 0;
%% Energy Optimization
Dat_Cost = Dat_Cost + Neigh;
[ ns ] = Energy_segment(Dat_Cost, Conn_Weight, Smo_Cost, LC_Mat, Value, Neigh);% optimization using global energy 

%% Update JJ Value_new et al.
%JJ: the horizon segment and its corresponding label
%assign the labels after segmentation to the initial labels
for i = 1:length(ns)
    for j = 1:Value(i)
        JJ(i,j,4) = ns(i);
    end
end
ns_uni = unique(ns);
ns_num = length(ns_uni);
Value_new = zeros(ns_num,1);
for i = 1:length(Value)
    loc = find(ns_uni == JJ(i,1,4));
    if ~isempty(loc)
        if (Value_new(loc) == 0)
            JJ_new(loc, 1:Value(i), :) = JJ(i, 1:Value(i), :); 
            JJ_new(loc, 1:Value(i), 4) = loc;
        else
            JJ_new(loc, 1+Value_new(loc):Value(i)+Value_new(loc), :) = JJ(i, 1:Value(i), :); 
            JJ_new(loc, 1+Value_new(loc):Value(i)+Value_new(loc), 4) = loc;
        end
        Value_new(loc) = Value_new(loc) + Value(i);
    end
end
newout_new = zeros(size(newout));
Judge_new = zeros(size(Judge));
for i = 1:length(Value_new)
    for j = 1:Value_new(i)
        a = JJ_new(i,j,1); b = JJ_new(i,j,2); c = JJ_new(i,j,3); J = JJ_new(i,j,4);
        if (a == 0|| b == 0|| c == 0)
            continue;
        end
        newout_new(a,b,c) = 255;
        Judge_new(a,b,c) = J;
    end
end
%% output
load('Itest_ship_part1.mat');
load('Xtest_ship_part1.mat');
load('Ytest_ship_part1.mat');
load('Ztest_ship_part1.mat');
X = x;
Y = y;
Z = z;
X1=min(X);X2=max(X);
Y1=min(Y);Y2=max(Y);
Z1=min(Z);Z2=max(Z);
clear X Y Z;
mkdir(strcat(path,num2str(time)));
for i = 1:length(Value)
     if (mod(i,50) == 0)
         i
     end
     newpath = strcat(path,num2str(time),'\','A4',num2str(i));
     fid=fopen([newpath,'newData_4.txt'],'w');
     B = [(JJ(i,1:Value(i),1))'*0.5+X1, (JJ(i,1:Value(i),2))'*0.5+Y1, (JJ(i,1:Value(i),3))'*0.1+Z2, JJ(i,1:Value(i),4)'];
     [r,c]=size(B);            
     for i=1:r
         for j=1:c
             fprintf(fid,'%f\t',B(i,j));
         end
         fprintf(fid,'\r\n');
     end
     clear B
     fclose(fid);
end
end
