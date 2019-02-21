function response = rangeHoldCOM(opc, dataPort)

%% RANGE HOLD CODE OPTIONS
switch opc
    case 0 % QUERY
        fprintf(dataPort,'MAIN:R.H.?'); 
        response = fscanf(dataPort,'%s');
    case 1 % R.H. OFF
        fprintf(dataPort,'MAIN:R.H.:OFF.'); 
        response = fscanf(dataPort,'%s'); 
    case 2  % R.H. ON
        fprintf(dataPort,'MAIN:R.H.:ON..'); 
        response = fscanf(dataPort,'%s');
    otherwise % ERROR        
        response = 'Invalid option!';
end

