%% Author: Nicholas Mitchell
% August 2014

%% Definition of input names and sizes for loop navigation

% A file used to load in the simulated data from file, analyse it tand then
% remove it from the Matlab workspace. this is necessary because the file
% sizes are too large to have them all in the workspace at the same time

% Create a cell containing the names of the three different simulated
% markets, which be used in the regression of the funds with errors
market_names = {'marketData1' 'marketData2' 'marketData3'};

% Create a cell with the identifiers for each of the simulated funds with
% errors
fund_names = {'funds1_b3' 'funds1_b2' 'funds1_b1' 'funds1_b0' 'funds1_b_1' 'funds1_b_2' 'funds1_b_3';
    'funds2_b3' 'funds2_b2' 'funds2_b1' 'funds2_b0' 'funds2_b_1' 'funds2_b_2' 'funds2_b_3';
    'funds3_b3' 'funds3_b2' 'funds3_b1' 'funds3_b0' 'funds3_b_1' 'funds3_b_2' 'funds3_b_3'};
% Each of these files contains one specific fund.
% E.g.   fundsX_bY contains funds generated from marketDataX, with the
% (eleven) different values of alpha used, for the value Y of beta. Each of
% these combinations then has four variants, which come from the four
% different error distributions that were added onto each of the fund
% combinations.

% Values used to navigate through the error-based variants of the funds
error_names = {'_err1' '_err2' '_err3' '_err4'};

% Values used to navigate through the fund variations above in the loops
num_markets = 3;
num_funds = 3;        % not being used at all (currently)
num_betas = 7;
num_alphas = 7;
num_errors = length(error_names);
num_simulations = 2000;

% predefine an output for the three large regression loops
results{1,1,2000,7} = 0;             %  {num_markets_being analysed_in_loop, NUM_OUTPUTS, num_simulations, num_alphas}

% result_market2{2,2000,11} = 0;     % perhaps needed if results between markets are separated
% result_market3{2,2000,11} = 0;

% These will contain the regression parameter results (slope and intercept)
% in the first row of the array, then the goodness of fit parameters in the
% corresponding position in the second row. 2000 simulations plus the 11
% different values of alpha.


%% Regression Loops
tic
multiWaitbar( 'Markets', 0, 'CancelFcn', @(a,b) disp( ['Cancel ',a] ) );

for i = 3:num_markets       % these correspond to the three rows of 'fund_names'
    
    current_market_name = market_names{1,i};    % stores just the name of the market being used in the loop
    
    % The output of this load is a struct with just one field, marketDataX.
    % It is possible to have it returned as a matrix, but this would have
    % to be cleared after each loop
    current_market_data = load('W:\Documents\FIM\Forschung\Forschungsphase\Simulations\MATLAB\Investigation\Data\marketData_errorData_with_fit_and_moments.mat', current_market_name);
    
    multiWaitbar( 'Betas', 0, 'CancelFcn', @(a,b) disp( ['Cancel ',a] ) );
    
    for j = 1: num_betas
        current_fund = [fund_names{i,j} '_error'];  % this is the name of the fund to be used, which of the four errors is used is specified in next level
        
        multiWaitbar( 'Errors', 0, 'CancelFcn', @(a,b) disp( ['Cancel ',a] ) );
        
        for k = 1:num_errors
            current_fund_data = cell2mat(struct2cell(load(['W:\Documents\FIM\Forschung\Forschungsphase\Simulations\MATLAB\Investigation\Data\' current_fund '.mat'], [fund_names{i,j} error_names{1,k}])));
            current_fund_name = [fund_names{i,j} error_names{1,k}];
            
            multiWaitbar( 'Alphas', 0, 'CancelFcn', @(a,b) disp( ['Cancel ',a] ) );
            
            for ii = 3:9     % reduced number of alpha values used
                
                multiWaitbar( 'Simulation Run', 0, 'CancelFcn', @(a,b) disp( ['Cancel ',a] ) );
                
                for jj = 1:num_simulations
                    
                    % The function `fitlm` produces one output class, to be
                    % saved in the 4-D cell
                    results{1,1,jj,(ii-2)} = fitlm(current_market_data.(current_market_name)(:,jj), current_fund_data(:,jj,ii), 'Intercept', true);
                    
                    % Alternative method using the `fit` function
                    %   [result{i,1,jj,ii}, result{i,2,jj,ii}] = fit(current_market_data.(current_market_name)(:,jj), current_fund_data(:,jj,ii), 'Intercept', false);
                    abort = multiWaitbar( 'Simulation Run', jj/num_simulations);
                end
                % How can we append all results, say for marketData1, to the
                % same output and possible take an average like in av_moments??
                multiWaitbar( 'Simulation Run', 'Close' )
                abort = multiWaitbar( 'Alphas', (ii-2)/num_alphas);
            end
            % evalin('base', ['clear' ' ' curent_fund_data])
            % evalin('base', ['clear' ' ' curent_fund_name])
            multiWaitbar( 'Alphas', 'Close' )
            abort = multiWaitbar( 'Errors', k/num_errors );
        end
        multiWaitbar( 'Errors', 'Close' )
        abort = multiWaitbar( 'Betas', j/num_betas );
    end
    multiWaitbar( 'Betas', 'Close' )
    abort = multiWaitbar( 'Markets', i/num_markets );
end
multiWaitbar( 'Markets', 'Close' )

save('result_v.3.mat', 'results')
total_time = toc;