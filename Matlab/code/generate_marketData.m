%% Author: Nicholas Mitchell
%  July 2014

%% Generate the data

% Define the desired moments i.e. the input parameters
mom1 = 0.0;       % mean
mom2 = 1.0;       % standard deviation
mom3 = 0.0;       % skewness
mom4 = 20.00;       % kurtosis

% Define the number of periods in one set of market returns
m = 2500;      % approximately 10 years of trading days

% Define the number of market return simulations (columns of return matrix)
n = 2000;

% Note: the larger the values of m and n, the better the actual simlated
% moments recreate the desired moments on average, and the smaller their
% standard deviation.

% Create the random data to represent the periodic market returns
errorData4 = pearsrnd(mom1, mom2, mom3, mom4, m, n);

%% Assess the actual moments of the generated data

% Predefine a matrix to store the moments of each of the time series
moments = zeros(4, n);

% Calculate the actual moments of each market return time series (of each
% of the columns in the 'marketData' matrix output) and store them in a
% single matrix
for i = 1:n
    
    moments(:,i) = [mean(errorData4(:,i)); std(errorData4(:,i)); skewness(errorData4(:,i)); kurtosis(errorData4(:,i))];
    
end

% Assess the simulated values of each of the four moments over all, n,
% generated time series. The 4x3 matrix output shows the desired moments in
% the first colum, the actual average moments in the second column and
% finally the standard deviation of those moments in the third column
av_moments_errorData5 = [mom1 mean(moments(1,:)) std(moments(1,:)); mom2 mean(moments(2,:)) std(moments(1,:)); mom3 mean(moments(3,:)) std(moments(1,:)); mom4 mean(moments(4,:)) std(moments(1,:))];
