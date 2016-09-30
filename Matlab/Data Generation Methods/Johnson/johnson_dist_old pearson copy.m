%% Pearson wrapper function
% This function uses the Pearson method of distribution mixtures to
% reproduce a random set of numbers i.e. a distribution, which is unique to
% the moments given. This means that it will prodice the same numbers ever
% time for given input parameters, but not that the output is actually
% unique for the given moments. It doesn not use the moment generating
% function, and so therefore cannot be the case.

function [pearson, type_p] = pearson_dist(mu, stdev, skew, kurt, m, n)

%% Input variables:
% mu    = the mean of the created distribution (first moment)
% stdev = the standard deviation of the distribution (second moment)
% skew  = the skewness of the distribution to be created (third moment)
% kurt  = the kurtosis of the distribution to be created (fourth moment)
% m     = the numbers of rows that the produced output will contain
% n     = the number of columns that the output will contain

%% NOTES:
% This function will create an array holding stochastically created
% numbers, together possessing the desired moments. The moments generated
% are however like those of a sample, not a popoulation, and so may differ
% slightly from those given as inputs.
%
% Not all combinations of the four input moments are valid. In the case
% that such a combination is entered, NANs will be produced and a
% corresponding error message.

%% Calculation

% Create the periodic 'returns'
[pearson, dist_type] = pearsrnd(mu, stdev, skew, kurt, m, n);

% Tell user which distribution was used:

if dist_type == 0
    ['A Guassian distribution was used to create the data']
elseif dist_type == 1
    ['A four-parameter beta distribution was used to create the data']
elseif dist_type == 2
    ['A symmetric four-parameter beta distribution was used to create the data']
elseif dist_type == 3
    ['A three-parameter gamma distribution was used to create the data']
elseif dist_type == 4
    ['The method was not related to any standarad distribution.';
     'The density is proportional to (1 + ((x – a)/b)2)–c exp(–d arctan((x – a)/b))']
elseif dist_type == 5
    ['An inverse gamma location-scale distribution was used to create the data']
elseif dist_type == 6
    ['An F location-scale distribution was used to create the data']
elseif dist_type == 7
    ['A student-t location-scale distribution was used to create the data']
end

% Test for NaNs, which may lead to problems when calculating log returns
if sum(isnan(pearson)) > 0
    ['Warning: The output vector contains' sum(isnan(c)) 'NaN terms.';
     'This equates to' sum(isnan(pearson))/m '% of the output vector']
else
    ['The output does not contain any NaN values']
end

% Create the log-returns
for i = 1:(size(pearson,1)-1)
    log_ret_p(i) = log(pearson(i+1)/pearson(i));
end



p_mom = [mean(pearson) std(pearson) skewness(pearson) kurtosis(pearson)];


%% Display distribution results
figure
subplot(2, 1, 1)
plot(1:100000, log_ret_p)
subplot(2, 1, 2)
plot(1:m, pearson)
