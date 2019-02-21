function response = circuitCOM(opc, dataPort)

%% CIRCUIT CODE OPTIONS
switch opc
    case 0 % QUERY
        fprintf(dataPort,'MAIN:CIRC?'); 
        response = fscanf(dataPort,'%s');  
    case 1 % SERIES
        fprintf(dataPort,'MAIN:CIRC:SERI'); 
        response = fscanf(dataPort,'%s');   
    case 2  % PARALLEL
        fprintf(dataPort,'MAIN:CIRC:PARA'); 
        response = fscanf(dataPort,'%s');    
    otherwise % ERROR        
        response = 'Invalid option!';
end