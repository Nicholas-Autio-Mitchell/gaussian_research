results_market2(4,2000,7) = 0;
market = 2;
for i = 3:9
    for j = 1:2000
        
        
    results_market2(1,j,(i-2)) = results_v2{market,1,j,i}.Coefficients(1,1);
    results_market2(2,j,(i-2)) = results_v2{market,1,j,i}.Coefficients(2,1);
    results_market2(3,j,(i-2)) = results_v2{market,1,j,i}.Rsquared.Ordinary;
    results_market2(4,j,(i-2)) = results_v2{market,1,j,i}.Rsquared.Adjusted;
    
    end
    
end


%% need to check indexing as the output Cell is different i.e. 'results_v1'
results_market1(4,2000,7) = 0;
market = 2;
for i = 3:9
    for j = 1:2000
        
        
    results_market1(1,j,(i-2)) = results_v2{market,1,j,i}.Coefficients(1,1);
    results_market1(2,j,(i-2)) = results_v2{market,1,j,i}.Coefficients(2,1);
    results_market1(3,j,(i-2)) = results_v2{market,1,j,i}.Rsquared.Ordinary;
    results_market1(4,j,(i-2)) = results_v2{market,1,j,i}.Rsquared.Adjusted;
    
    end
    
end