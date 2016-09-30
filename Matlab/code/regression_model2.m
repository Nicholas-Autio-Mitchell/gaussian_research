%% Author: Nicholas Mitchell
%  July 2014

%% Including error terms - define required inputs for the regression
ds = marketData;        % This is the data set from 'generate_marketData'
r = 0;                  % Riskless rate of return
a = 0.03;               % The alpha of the fund
b = 1.00;               % The beta of the fund
f = a + b .* ds;        % The fund data from given market data, alpha & beta values

% Add error term (to the market), which includes skewness and kurtosis

% Other factors can later be added to the fund's strategy,
% for example:
%     - options on the market
%     - various amounts of leverage
%     - variations of the riskless rate
%     - mixtures of both the above

%% Set up the regression model
% f is to represent the fund's returns
% E.g. 'f = a + b*data' will represent the one factor regression model

% Predefine an output to allocate the results to from each of the
% regressions
total_independent_variables = 1;    % Can be dynamic once made into a function, using 'nargin'

result((total_independent_variables + 2), n) = 0;   % '+2' so each of the coefficients, plus adjusted R^2 and  
**to be predefined as an array, to store the coefficients and adj. R^2 values**

for q = 1:size(ds, 2)
    m = (ds(:, q) - r);                         % A single simulation of market returns
    modelspec = 'f -r ~ a + b * (m - r)';       % The regression model
    output = LinearModel.fit(f(:,q), ds(:,q));
    resultoutput.Rsquared.Adjusted
    output.Coefficients
end

    


