%% Generation of the fund data, for various alpha and beta values, based 
% off the back of three different simulated market data return


%% Author: Nicholas Mitchell
%  July 2014
%% Define inputs and predefine an output

% Simulated market data - the three different markets to be run separately
% data1 = marketData1;
% data2 = marketData2;
% data3 = marketData3;

% Define alpha and beta ranges
alphas = (-5:5)';
betas = (-3:3)';

% Define dimensions of output
num_periods = 2500;
num_simulations = 2000;
num_alphas = length(alphas);
num_betas = length(betas);
num_markets = 3;
num_funds = num_alphas * num_betas;
num_errors = 5;
num_funds_with_epsilon = num_funds * num_errors;

% Generate cell containing all combinations of the alpha and beta ranges

% Predefine the cell size
para_combinations = cell(length(alphas), length(betas));

% Allocate the combinations of alpha and beta
for i = 1:length(alphas)
    for j = 1:length(betas)
       para_combinations{i,j} = [alphas(i) betas(j)];
    end       
end


%% Create a fund for each combination of the alphas and betas

a = size(para_combinations,1);
b = size(para_combinations,2);
alpha = 1;              % alpha is the first variable stored in the cell of combinations
beta = 2;               % beta is the second. These values are simply used for indexing.

% the column of the beta value being used to generate the fund
beta_neg_3 = 1;
beta_neg_2 = 2;
beta_neg_1 = 3;
beta_zero = 4;
beta_pos_1 = 5;
beta_pos_2 = 6;
beta_pos_3 = 7;

% ****  Seven cells to be created, one for each beta value being used, each
% cell contains the 2000 simulations of 2500 periods with the given beta
% value (and being based on one of the three pre-simulated markets) - and
% the third dimension of the cell array holds this all for the 11 different
% values of alpha being used. Each cell is then 2500x2000x11 in size. ****

% Predefine output
funds3_b3 = zeros(num_periods, num_simulations, num_alphas);
for p = 1:num_alphas
    funds3_b3(:,:,p) = marketData3 .* para_combinations{p,beta_pos_3}(beta) + para_combinations{p,beta_pos_3}(alpha);   
end

% Predefine output
funds3_b2 = zeros(num_periods, num_simulations, num_alphas);
for p = 1:num_alphas
    funds3_b2(:,:,p) = marketData3 .* para_combinations{p,beta_pos_2}(beta) + para_combinations{p,beta_pos_2}(alpha);   
end

% Predefine output
funds3_b1 = zeros(num_periods, num_simulations, num_alphas);
for p = 1:num_alphas
    funds3_b1(:,:,p) = marketData3 .* para_combinations{p,beta_pos_1}(beta) + para_combinations{p,beta_pos_1}(alpha);   
end

% Predefine output
funds3_b0 = zeros(num_periods, num_simulations, num_alphas);
for p = 1:num_alphas
    funds3_b0(:,:,p) = marketData3 .* para_combinations{p,beta_zero}(beta) + para_combinations{p,beta_zero}(alpha);   
end

% Predefine output
funds3_b_1 = zeros(num_periods, num_simulations, num_alphas);
for p = 1:num_alphas
    funds3_b_1(:,:,p) = marketData3 .* para_combinations{p,beta_neg_1}(beta) + para_combinations{p,beta_neg_1}(alpha);   
end

% Predefine output
funds3_b_2 = zeros(num_periods, num_simulations, num_alphas);
for p = 1:num_alphas
    funds3_b_2(:,:,p) = marketData3 .* para_combinations{p,beta_neg_2}(beta) + para_combinations{p,beta_neg_2}(alpha);   
end

% Predefine output
funds3_b_3 = zeros(num_periods, num_simulations, num_alphas);
for p = 1:num_alphas
    funds3_b_3(:,:,p) = marketData3 .* para_combinations{p,beta_neg_3}(beta) + para_combinations{p,beta_neg_3}(alpha);   
end



%% Add the errors to the funds in order to introduce skewness and kurtosis to them
% The erros must have a mu of 0, so that the mu of the fund remains
% unchanged, after the alpha and beta values were introduced above.
% The value of the st. dev. will also be altered, which is ok.


%% To go through all funds from the three markets, simply use 'Replace all' with ctrl+F, to swap between markets.
% E.g. find 'funds1' and replace with 'funds2' or 'funds3'.

%% funds1_b3
fund = funds1_b3;

% predefine output matrix
funds1_b3_err1(2500,2000,11) = 0; 
for i = 1:size(fund, 3)
    funds1_b3_err1(:,:,i) = fund(:,:,i) + errorData1;
end

% predefine output matrix
funds1_b3_err2(2500,2000,11) = 0; 
for i = 1:size(fund, 3)
    funds1_b3_err2(:,:,i) = fund(:,:,i) + errorData2;
end

% predefine output matrix
funds1_b3_err3(2500,2000,11) = 0; 
for i = 1:size(fund, 3)
    funds1_b3_err3(:,:,i) = fund(:,:,i) + errorData3;
end

% predefine output matrix
funds1_b3_err4(2500,2000,11) = 0; 
for i = 1:size(fund, 3)
    funds1_b3_err4(:,:,i) = fund(:,:,i) + errorData4;
end

%% funds1_b2
fund = funds1_b2;

% predefine output matrix
funds1_b2_err1(2500,2000,11) = 0; 
for i = 1:size(fund, 3)
    funds1_b2_err1(:,:,i) = fund(:,:,i) + errorData1;
end

% predefine output matrix
funds1_b2_err2(2500,2000,11) = 0; 
for i = 1:size(fund, 3)
    funds1_b2_err2(:,:,i) = fund(:,:,i) + errorData2;
end

% predefine output matrix
funds1_b2_err3(2500,2000,11) = 0; 
for i = 1:size(fund, 3)
    funds1_b2_err3(:,:,i) = fund(:,:,i) + errorData3;
end

% predefine output matrix
funds1_b2_err4(2500,2000,11) = 0; 
for i = 1:size(fund, 3)
    funds1_b2_err4(:,:,i) = fund(:,:,i) + errorData4;
end


%% funds1_b1
fund = funds1_b1;

% predefine output matrix
funds1_b1_err1(2500,2000,11) = 0; 
for i = 1:size(fund, 3)
    funds1_b1_err1(:,:,i) = fund(:,:,i) + errorData1;
end

% predefine output matrix
funds1_b1_err2(2500,2000,11) = 0; 
for i = 1:size(fund, 3)
    funds1_b1_err2(:,:,i) = fund(:,:,i) + errorData2;
end

% predefine output matrix
funds1_b1_err3(2500,2000,11) = 0; 
for i = 1:size(fund, 3)
    funds1_b1_err3(:,:,i) = fund(:,:,i) + errorData3;
end

% predefine output matrix
funds1_b1_err4(2500,2000,11) = 0; 
for i = 1:size(fund, 3)
    funds1_b1_err4(:,:,i) = fund(:,:,i) + errorData4;
end

%% funds1_b0
fund = funds1_b0;

% predefine output matrix
funds1_b0_err1(2500,2000,11) = 0; 
for i = 1:size(fund, 3)
    funds1_b0_err1(:,:,i) = fund(:,:,i) + errorData1;
end

% predefine output matrix
funds1_b0_err2(2500,2000,11) = 0; 
for i = 1:size(fund, 3)
    funds1_b0_err2(:,:,i) = fund(:,:,i) + errorData2;
end

% predefine output matrix
funds1_b0_err3(2500,2000,11) = 0; 
for i = 1:size(fund, 3)
    funds1_b0_err3(:,:,i) = fund(:,:,i) + errorData3;
end

% predefine output matrix
funds1_b0_err4(2500,2000,11) = 0; 
for i = 1:size(fund, 3)
    funds1_b0_err4(:,:,i) = fund(:,:,i) + errorData4;
end

%% funds1_b_1
fund = funds1_b_1;

% predefine output matrix
funds1_b_1_err1(2500,2000,11) = 0; 
for i = 1:size(fund, 3)
    funds1_b_1_err1(:,:,i) = fund(:,:,i) + errorData1;
end

% predefine output matrix
funds1_b_1_err2(2500,2000,11) = 0; 
for i = 1:size(fund, 3)
    funds1_b_1_err2(:,:,i) = fund(:,:,i) + errorData2;
end

% predefine output matrix
funds1_b_1_err3(2500,2000,11) = 0; 
for i = 1:size(fund, 3)
    funds1_b_1_err3(:,:,i) = fund(:,:,i) + errorData3;
end

% predefine output matrix
funds1_b_1_err4(2500,2000,11) = 0; 
for i = 1:size(fund, 3)
    funds1_b_1_err4(:,:,i) = fund(:,:,i) + errorData4;
end

%% fund1_b_2
fund = funds1_b_2;


% predefine output matrix
funds1_b_2_err1(2500,2000,11) = 0; 
for i = 1:size(fund, 3)
    funds1_b_2_err1(:,:,i) = fund(:,:,i) + errorData1;
end

% predefine output matrix
funds1_b_2_err2(2500,2000,11) = 0; 
for i = 1:size(fund, 3)
    funds1_b_2_err2(:,:,i) = fund(:,:,i) + errorData2;
end

% predefine output matrix
funds1_b_2_err3(2500,2000,11) = 0; 
for i = 1:size(fund, 3)
    funds1_b_2_err3(:,:,i) = fund(:,:,i) + errorData3;
end

% predefine output matrix
funds1_b_2_err4(2500,2000,11) = 0; 
for i = 1:size(fund, 3)
    funds1_b_2_err4(:,:,i) = fund(:,:,i) + errorData4;
end


%% fund1_b_3
fund = funds1_b_3;

% predefine output matrix
funds1_b_3_err1(2500,2000,11) = 0; 
for i = 1:size(fund, 3)
    funds1_b_3_err1(:,:,i) = fund(:,:,i) + errorData1;
end

% predefine output matrix
funds1_b_3_err2(2500,2000,11) = 0; 
for i = 1:size(fund, 3)
    funds1_b_3_err2(:,:,i) = fund(:,:,i) + errorData2;
end

% predefine output matrix
funds1_b_3_err3(2500,2000,11) = 0; 
for i = 1:size(fund, 3)
    funds1_b_3_err3(:,:,i) = fund(:,:,i) + errorData3;
end

% predefine output matrix
funds1_b_3_err4(2500,2000,11) = 0; 
for i = 1:size(fund, 3)
    funds1_b_3_err4(:,:,i) = fund(:,:,i) + errorData4;
end
