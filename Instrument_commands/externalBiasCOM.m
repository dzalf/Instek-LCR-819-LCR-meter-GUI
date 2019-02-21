
function response = externalBiasCOM(opc, dataPort)
%% EXT.B (EXTERNAL BIAS) CODE OPTIONS
switch opc
    case 0 % EXTERNAL QUERY
        fprintf(dataPort,'MAIN:EXTB?'); 
        response = fscanf(dataPort,'%s');
    case 1 % INTERNAL BIAS OFF
        fprintf(dataPort,'MAIN:EXTB:OFF.'); 
        response = fscanf(dataPort,'%s');
    case 2  % INTERNAL BIAS ON
        fprintf(dataPort,'MAIN:EXTB:ON..'); 
        response = fscanf(dataPort,'%s');
    otherwise % ERROR        
        response = 'Invalid option!';
end
