function response = measurementCOM(opc, dataPort)

%% MEASUREMENT MODE (AUTO/MANU) CODE OPTIONS
switch opc
    case 0 % QUERY
        fprintf(dataPort,'MAIN:TRIG?'); 
        response = fscanf(dataPort,'%s');
    case 1 % MANUAL
        fprintf(dataPort,'MAIN:TRIG:MANU'); 
        response = fscanf(dataPort,'%s'); 
    case 2  % AUTOMATIC
        fprintf(dataPort,'MAIN:TRIG:AUTO'); 
        response = fscanf(dataPort,'%s');  
    otherwise % ERROR        
        response = 'Invalid option!';
end
