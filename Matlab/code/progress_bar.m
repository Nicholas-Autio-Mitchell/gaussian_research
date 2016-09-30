num_markets = 3;
num_betas = 7;
num_errors = length(error_names);
num_alphas = 11;
num_simulations = 2000;

multiWaitbar( 'Task 1', 0, 'CancelFcn', @(a,b) disp( ['Cancel ',a] ) );
for i = 1:num_markets
    abort = multiWaitbar( 'Task 1', i/num_markets );
    
end
multiWaitbar( 'Task 1', 'Close' )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

multiWaitbar( 'Task 2', 0, 'CancelFcn', @(a,b) disp( ['Cancel ',a] ) );
for j = 1:num_betas
    abort = multiWaitbar( 'Task 2', j/num_betas );
    
end
multiWaitbar( 'Task 2', 'Close' )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

multiWaitbar( 'Task 3', 0, 'CancelFcn', @(a,b) disp( ['Cancel ',a] ) );
for k = 1:num_errors
    abort = multiWaitbar( 'Task 3', k/num_errors );
    
end
multiWaitbar( 'Task 3', 'Close' )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

multiWaitbar( 'Task 4', 0, 'CancelFcn', @(a,b) disp( ['Cancel ',a] ) );
for ii = 1:num_alphas
    abort = multiWaitbar( 'Task 4', ii/num_alphas );
    
end
multiWaitbar( 'Task 4', 'Close' )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

multiWaitbar( 'Task 5', 0, 'CancelFcn', @(a,b) disp( ['Cancel ',a] ) );
for jj = 1:num_simulations
    abort = multiWaitbar( 'Task 5', jj/num_simulations );
    
end
multiWaitbar( 'Task 5', 'Close' )

