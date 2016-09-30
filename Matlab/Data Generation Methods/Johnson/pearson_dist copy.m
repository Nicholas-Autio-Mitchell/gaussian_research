%% Pearson wrapper function
% This function uses the Pearson method of distribution mixtures to
% reproduce a random set of numbers with sample moments equal to those
% entered. As the output is generated randomly, the sample moments may
% differ slightly from the desired moments given as inputs, especially the
% skewness and kurtosis.

function [sim_data, mom_summary, multi_dist] = pearson_dist(mom1, mom2, mom3, mom4, m, n)

%% Input variables:
% mu    = the mean of the created distribution (first moment)
% stdev = the standard deviation of the distribution (second moment)
% skew  = the skewness of the distribution to be created (third moment)
% kurt  = the kurtosis of the distribution to be created (fourth moment)
% m     = the numbers of rows that the produced output will contain
% n     = the number of columns that the output will contain

%% Output variables
% sim_data = a matrix of size [m x n] containing the random periodic
% returns generate
% mom_summary = a cell (representing a simple table) that displayy the
% desired moments compared to those calculated from the simulated data
% multi_dist = the output struct of the function 'allfitdist'. This
% contains the distributions that were able to be fitted to the simulated
% data and that are also displayed on Figure 2 of the output. The struct
% contains all the information for the distributions found to fit, odered
% by goodness, according to the Baysian Information Criterion (AIK also
% possible)

%% Notes:
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
[sim_data, dist_type] = pearsrnd(mom1, mom2, mom3, mom4, m, n);

% Tell user which distribution was used:

if dist_type == 0
    message1 = 'A Guassian distribution was used to create the data';
elseif dist_type == 1
    message1 = 'A four-parameter beta distribution was used to create the data';
elseif dist_type == 2
    message1 = 'A symmetric four-parameter beta distribution was used to create the data';
elseif dist_type == 3
    message1 = 'A three-parameter gamma distribution was used to create the data';
elseif dist_type == 4
    message1 = 'The method was not related to any standarad distribution. The density is proportional to (1 + ((x – a)/b)2)–c exp(–d arctan((x – a)/b))';
elseif dist_type == 5
    message1 = 'An inverse gamma location-scale distribution was used to create the data';
elseif dist_type == 6
    message1 = 'An F location-scale distribution was used to create the data';
elseif dist_type == 7
    message1 = 'A student-t location-scale distribution was used to create the data';
end

% Test for NaNs, which may lead to problems when calculating log returns
if sum(isnan(sim_data)) > 0
    message2 = ['Warning: The output vector contains' sum(isnan(sim_data)) 'NaN terms.';
        'This equates to' sum(isnan(sim_data))/m '% of the output vector';
        'Check the entered kurtosis is greater than' (mom3^2 + 1) 'i.e. skew^2 + 1)'];
else
    message2 = 'The output does not contain any NaN values';
end

% Compare desired moments and generated moments
desired_mom = [mom1, mom2, mom3, mom4];
output_mom = [mean(sim_data) std(sim_data) skewness(sim_data) kurtosis(sim_data)];
mom_summary = {'', 'Mean', 'St Dev', 'Skewness', 'Kurtosis';
    'Desired:', desired_mom(1), desired_mom(2), desired_mom(3), desired_mom(4);
    'Output:', output_mom(1), output_mom(2), output_mom(3), output_mom(4);
    '', '', '', '', '';
    message1,'' ,'' ,'', '';
    message2,'' ,'' ,'', ''};

% check which distributions also fit the data, after creation
% Information criterion used can be altered depending on sample size. If N
% - k < 40, it is considered to be beneficial to use the Akaike IC for
% small sample sizes, i.e. 'AICc' (Multimodel Inference: Understanding AIC
% and BIC in Model Selection)
informationCriterion = 'AIC';
multi_dist = allfitdist(sim_data, informationCriterion, 'PDF');



% Create the log-returns
log_ret_p = zeros(m, n);    % predefine matrix
for i = 1:(size(sim_data,1)-1)
    log_ret_p(i) = log(sim_data(i+1)/sim_data(i));
end

%% Display distribution results
% Imaginary parts may be neglected by the plotting function when executed
figure, clf,
subplot(2, 1, 1)
plot(1:m, sim_data)
legend('Periodic returns')
subplot(2, 1, 2)
plot(1:m, log_ret_p)
legend('Periodic log returns')