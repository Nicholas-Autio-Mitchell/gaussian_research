%% Author: Nicholas Mitchell
%  July 2014

%% Without the error terms - define required inputs for the regression
ds = marketData2;        % This is the data set from 'generate_marketData'
r = 0;                   % Riskless rate of return
a = 0.03;                % The alpha of the fund
b = 1.00;                % The beta of the fund
f = a + b .* ds;         % The fund data from given market data, alpha & beta values
n = 2000;                % number of simulations

% Other factors can later be added to the fund's strategy,
% for example:
%     - options on the market
%     - various amounts of leverage
%     - variations of the riskless rate
%     - mixtures of both the above

%% Set up the regression model
% f is to represent the fund's returns
% E.g. 'f = a + b*data' will represent the one factor regression model

coef7 = zeros(n, 2);
stats7 = zeros(n, 2);


for i = 1:size(f,2)
    
[coef7(:,i), stats7(:,i)] = polyfit(market_with_errors7, f, 1); 

end