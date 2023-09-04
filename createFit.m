function [fitresult, gof] = createFit(X, Y, Z)
%CREATEFIT(X,Y,Z)
%  Create a fit.
%
%  Data for 'untitled fit 1' fit:
%      X Input : X
%      Y Input : Y
%      Z Output: Z
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  另请参阅 FIT, CFIT, SFIT.

%  由 MATLAB 于 13-Feb-2022 14:43:03 自动生成


%% Fit: 'untitled fit 1'.
[xData, yData, zData] = prepareSurfaceData( X, Y, Z );

% Set up fittype and options.
ft = 'linearinterp';

% Fit model to data.
[fitresult, gof] = fit( [xData, yData], zData, ft, 'Normalize', 'on' );

% Plot fit with data.
figure( 'Name', 'untitled fit 1' );
h = plot( fitresult, [xData, yData], zData );
legend( h, 'untitled fit 1', 'Z vs. X, Y', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label axes
xlabel( 'X', 'Interpreter', 'none' );
ylabel( 'Y', 'Interpreter', 'none' );
zlabel( 'Z', 'Interpreter', 'none' );
axis equal
grid on
view( 126.0, 15.3 );


