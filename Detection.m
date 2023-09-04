%%
% Based on the extracted voxels. the detection method is applied
clear
load('The_voxels_to_be_detected.mat');

X = Point;
X = X-ones(size(X,1),1)*mean(X);

% Calculate the eigenvalues and eigenvectors of the new covariance matrix.
covarianceMatrix = X'*X/size(X,2); %求出其协方差矩阵
[V, D] = eig(covarianceMatrix);%V columns%  r = covarianceMatrix*V ; p = V*D;
%%
%%plane projection
P_fu = X*[V(1,2),V(2,2),V(3,2);V(1,3),V(2,3),V(3,3)]';
figure, scatter(P_fu(:,1),P_fu(:,2),'r.');
axis equal
P_zheng = X*[V(1,3),V(2,3),V(3,3);V(1,1),V(2,1),V(3,1)]';
figure, scatter(P_zheng(:,1),P_zheng(:,2),'r.');
axis equal
P_ce = X*[V(1,1),V(2,1),V(3,1);V(1,2),V(2,2),V(3,2)]';
figure, scatter(P_ce(:,1),P_ce(:,2),'r.');
axis equal
% %%
[x,lab] = sort(P_fu(:,1));
P_fu = P_fu(lab,:);
% figure,plot(P_fu(:,1),P_fu(:,2))
% axis equal
[x,lab] = sort(P_zheng(:,1));
P_zheng = P_zheng(lab,:);
% figure,plot(P_zheng(:,1),P_zheng(:,2))
% axis equal
[x,lab] = sort(P_ce(:,1));
P_ce = P_ce(lab,:);
% figure,plot(P_ce(:,1),P_ce(:,2))
% axis equal
%% Ship shape coefficients
L = max(P_fu(:,2)) - min(P_fu(:,2));
D = max(P_zheng(:,2)) - min(P_zheng(:,2));
B = max(P_ce(:,2)) - min(P_ce(:,2));
[k,av] = convhull(P_fu);
Cwp = abs(trapz(P_fu(k,1),P_fu(k,2)))/(L*B);%abs(trapz(Poiint(k,1),Poiint(k,2)))
[k,av] = convhull(P_ce);
Cm = abs(trapz(P_ce(k,1),P_ce(k,2)))/(D*B);%abs(trapz(Poiint(k,1),Poiint(k,2)))
%%
%% shipwreck index
sigma1 = 1*1.65;sigma2 = 1*0.47;sigma3 = 1*5;sigma4 = 1*0.035;sigma5 = 1*0.09;
sigma = sigma1*sigma2*sigma3*sigma4*sigma5;
u1 = 6.95;u2 = 2.32;u3 = 17.75;u4 = 0.80;u5 = 0.90;
% LB = L/B; LD = L/D; BD = B/D;
LB = u1+2*sigma1;BD = u2+2*sigma2;LD = u3+2*sigma3;Cwp = u4+2*sigma4;Cm = u5+2*sigma5;
SI = exp(-(LB-u1).^2/(2*sigma1^2))...
    *exp(-(BD-u2).^2/(2*sigma2^2)) * exp(-(LD-u3).^2/(2*sigma3^2))...
     * exp(-(Cwp-u4).^2/(2*sigma4^2))  * exp(-(Cm-u5).^2/(2*sigma5^2))

%% show results
ptCloud = pcread('shipwreck-.pcd');%output_meshnewV
figure,pcshow(ptCloud)
x=double(ptCloud.Location(:,1));y=double(ptCloud.Location(:,2));z=double(ptCloud.Location(:,3));
X=x;Y=y;Z=z;%2*(z-48)
tri=delaunay(X,Y);trisurf(tri,X,Y,Z); 
axis equal
light('position',[30,-70,-70],'style','local','color','w');lighting phong;
shading flat
colormap jet;hold on
% scatter3(X(:),Y(:),Z(:),'r');hold off
[fitresult, gof] = createFit(X, Y, Z);

[xx, yy] = meshgrid(min(X):0.3:max(X), min(Y):0.3:max(Y));
[zz] = griddata(X,Y,Z,xx,yy);
figure, surf(xx,yy,zz)
axis equal
light('position',[50,-30,-70],'style','local','color','w');lighting phong;
