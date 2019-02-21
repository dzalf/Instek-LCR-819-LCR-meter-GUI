function response = displayCOM (opc,dataPort)
%% DISPLAY CODE OPTIONS
switch opc
    case 0 % QUERY
        
        fprintf(dataPort,'MAIN:DISP?'); 
        response = fscanf(dataPort,'%s');
        
    case 1 % VALUE
        
        fprintf(dataPort,'MAIN:DISP:VALU'); 
        response = fscanf(dataPort,'%s');
        
    case 2 % DELTA %
        
        fprintf(dataPort,'MAIN:SPEE:DELP'); 
        response = fscanf(dataPort,'%s');
        
    case 3 % DELTA
       
        fprintf(dataPort,'MAIN:SPEE:DELT'); 
        response = fscanf(dataPort,'%s');
       
    otherwise
        response = 'Invalid option!';
end