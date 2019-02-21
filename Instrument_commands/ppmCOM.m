function response = ppmCOM(opc, dataPort)
%% PPM (PARTS PER MILLION) for Dissipation or Quality factor measurements
switch opc
    case 0 % QUERY
        fprintf(dataPort,'MAIN:PPM.?'); 
        response = fscanf(dataPort,'%s');
    case 1 % PPM OFF
        fprintf(dataPort,'MAIN:PPM.:OFF.'); 
        response = fscanf(dataPort,'%s');
    case 2  % PPM  ON
        fprintf(dataPort,'MAIN:PPM.:ON..'); 
        response = fscanf(dataPort,'%s');
    otherwise % ERROR        
        response = 'Invalid option!';
end
