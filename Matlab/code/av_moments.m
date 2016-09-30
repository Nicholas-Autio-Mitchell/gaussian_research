%% Author: Nicholas Mitchell
%  July 2014

%% Assess the actual moments of the generated data
%  The dimension 'n' may need to be adjusted - it refers to the value used
%  in 'generate_marketData.m'
n = 2000;

% Predefine a matrix to store the moments of each of the time series
moments = zeros(4, n);

% Calculate the actual moments of each market return time series (of each
% of the columns in the 'marketData' matrixa output) and store them in a
% single matrix
data = results_market2;

for i = 1:n
    
    moments(:,i) = [mean(data(:,i)); std(data(:,i)); ...
        skewness(data(:,i)); kurtosis(data(:,i))];
    
end

% Assess the simulated values of each of the four moments over all, n,
% generated time series. The 4x3 matrix output shows the desired moments in
% the first colum, the actual average moments in the second column and
% finally the standard deviation of those moments in the third column
av_moments_results_market2 = [mom1 mean(moments(1,:)) std(moments(1,:)); mom2 mean(moments(2,:)) std(moments(1,:)); mom3 mean(moments(3,:)) std(moments(1,:)); mom4 mean(moments(4,:)) std(moments(1,:))];
