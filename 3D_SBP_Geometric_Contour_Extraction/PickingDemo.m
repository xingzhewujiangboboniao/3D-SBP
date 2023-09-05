%% Picking
options.FrangiScaleRange = [3 3];%3 4； 2 3
options.FrangiScaleRatio = 1;
options.BlackWhite = false;
[Iout,whatScale,Voutx,Vouty,Voutz]=FrangiFilter3D(I,options, [3, 3]);%Frangi滤波给出的向量方向
IOUT = Iout;
theta = cos(atan(Voutz./sqrt(Voutx.^2+Vouty.^2)));%公式有误 wrong
%%
[l, r, h] = size(Iout);
% threshold set
Iout_max = max(max(max(Iout)));
level= 0.07*Iout_max;%0.75
[l,r, h] = size(Iout);%
Iout(find(Iout>Iout_max*level)) = 255;
Iout(find(Iout==Iout_max*level)) = 255;
Iout(find(Iout<Iout_max*level)) = 0;
newout = zeros(l, r, h);
 for i = 1:l
     for j = 1:r
         u = mean(Iout(i,j,:));
         det = std(Iout(i,j,:));
         for k = h-6:-1:6
             if ((Iout(i,j,k) == 255 && Iout(i,j,k-1) == 0) ) %&& isempty(find(newout(i,j,k-8:k+8)==255))% || (Iout(i,j,k) == 0 && Iout(i,j,k-1) == 255)
                 newout(i,j,k) = 255;
             end
         end
     end
 end
%%
% % % % u std
[l,r, h] = size(Iout);
%%
%output
load('Itest_ship_part1.mat');
load('Xtest_ship_part1.mat');
load('Ytest_ship_part1.mat');
load('Ztest_ship_part1.mat');
X = x;
Y = y;
Z = z;
Data = I;

X1=min(X);X2=max(X);
Y1=min(Y);Y2=max(Y);
Z1=min(Z);Z2=max(Z);
clear X Y Z;

count = 1;
for i = 1:l
    for j = 1:r
        for k = 1:h
                X(count) = (i-1)*0.5 + X1;%
                Y(count) = (j-1)*0.5 + Y1;% 
                Z(count) = -(h-k)*0.1 + Z2;%
                II(count) = newData(i,j,k);
                count = count + 1;
        end
    end
end
