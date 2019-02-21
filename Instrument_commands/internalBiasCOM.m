
function response = internalBiasCOM(opc, dataPort)
%% INT.B (INTERNAL BIAS) CODE OPTIONS
switch opc
    case 0 % INTERNAL QUERY
        fprintf(dataPort,'MAIN:INTB?'); 
        response = fscanf(dataPort,'%s');
    case 1 % INTERNAL BIAS OFF
        fprintf(dataPort,'MAIN:INTB:OFF.'); 
        response = fscanf(dataPort,'%s');
    case 2  % INTERNAL BIAS ON
        fprintf(dataPort,'MAIN:INTB:ON..'); 
        response = fscanf(dataPort,'%s');
    otherwise % ERROR        
        response = 'Invalid option!';
end
