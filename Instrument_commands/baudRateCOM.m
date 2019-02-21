function response = baudRateCOM(opc, dataPort)
%% SET BAUDRATE OF RS-232
switch opc
    case 0 % EXTERNAL QUERY
        fprintf(dataPort,'COMU:9600'); 
        response = fscanf(dataPort,'%s');
    case 1 % INTERNAL BIAS OFF
        fprintf(dataPort,'COMU:19.2'); 
        response = fscanf(dataPort,'%s');
    case 2  % INTERNAL BIAS ON
        fprintf(dataPort,'COMU:38.4'); 
        response = fscanf(dataPort,'%s');
    case 3  % INTERNAL BIAS ON
        fprintf(dataPort,'COMU:57.6'); 
        response = fscanf(dataPort,'%s');
    case 4  % INTERNAL BIAS ON
        fprintf(dataPort,'COMU:1152'); 
        response = fscanf(dataPort,'%s');
    otherwise % ERROR        
        response = 'Invalid option!';
end