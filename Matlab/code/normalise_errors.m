%%Normalisation of data

data = errorData1;
num_periods = 2500;
num_sims = 2000;

% The desired moments (agree with those in the summary table in Excel)
mu_target = [0 0 0 0];
sigma_target = [1 1 1 0];
skew_target = [0 2.5 2.5 0];
kurt_target = [3 9 7.5 20];

data_normalised = zeros(num_periods, num_sims);

num_moments = 4;
data_norm_moments = zeros(num_moments, num_sims);

for i = 1:num_sims

% The actual moments coming from the generation process
mu_actual = mean(data(:,i));
sigma_actual = std(data(:,i));

% Not required for the normalisation process
% skew_acual = skewness(data(:,i));
% kurt_actual = kurtosis(data(:,i));

% Normalise the simulated data to correspond to the desired moments
data_normalised(:,i) = ((data(:,i) - mu_actual) ./ sigma_actual) .* sigma_target(1,2) + mu_target(1,2);

data_norm_moments(:,i) = [mean(data_normalised(:,i)); std(data_normalised(:,i)); ...
        skewness(data_normalised(:,i)); kurtosis(data_normalised(:,i))];

end

av_moments_err1 = [mu_target(1,1) mean(data_norm_moments(1,:)) std(data_norm_moments(1,:));
    sigma_target(1,1) mean(data_norm_moments(2,:)) std(data_norm_moments(1,:));
    skew_target(1,1) mean(data_norm_moments(3,:)) std(data_norm_moments(1,:));
    kurt_target(1,1) mean(data_norm_moments(4,:)) std(data_norm_moments(1,:))];


%% add the append input after the first errors are normalised and saved
% save('Normalised Errors.mat', 'data_normalised')
% save('Normalised Errors.mat', 'av_moments_results_market2', '-append')