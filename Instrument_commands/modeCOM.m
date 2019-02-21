function response = modeCOM (opc, dataPort)

%% MODE CODE OPTIONS
switch opc
    case 0 % QUERY  
        fprintf(dataPort,'MAIN:MODE?'); 
        response = fscanf(dataPort,'%s');
    case 1 % RQ
        fprintf(dataPort,'MAIN:MODE:RQ'); 
        response = fscanf(dataPort,'%s');
    case 2 % CD
        fprintf(dataPort,'MAIN:MODE:CD'); 
        response = fscanf(dataPort,'%s');
    case 3 % CR
        fprintf(dataPort,'MAIN:MODE:CR'); 
        response = fscanf(dataPort,'%s');
    case 4 % LQ
        fprintf(dataPort,'MAIN:MODE:LQ'); 
        response = fscanf(dataPort,'%s');
    otherwise % ERROR
        response = 'Invalid option!';
end