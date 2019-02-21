function response = constantVoltageCOM(opc, dataPort)
%% CONSTANT VOLTAGE CODE OPTIONS

switch opc
    case 0 % QUERY
        fprintf(dataPort,'MAIN:C.V.?'); 
        response = fscanf(dataPort,'%s');
    case 1 % R.H. OFF
        fprintf(dataPort,'MAIN:C.V.:OFF.'); 
        response = fscanf(dataPort,'%s');
    case 2  % R.H. ON
        fprintf(dataPort,'MAIN:C.V.:ON..'); 
        response = fscanf(dataPort,'%s');
    otherwise % ERROR        
        response = 'Invalid option!';
end
