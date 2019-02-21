function response = nominalValueCOM(opc,val)
%% SETS NOMINAL VALUE. DEPEND ON THE MEASUREMENT MODE
% <value> should be captured from a box. Must be composed of 8 digit
% characters including a decimabl place and a signage (+ or -)
% and '_' is a single space
% EG. SORT:NOMV_-0.12345

switch opc
    case 0 % QUERY
        
        fprintf(dataPort,'SORT:NOMV?');
        response = fscanf(dataPort,'%s');
%          'SORT:NOMV_0.00200' is a response option 

    case 1 % SET VALUE
        
        spaceChar = ' ';
        dotChar = '.';
        zeroChar = '0';
        sortNOMV = 'SORT:NOMV'; % is a response as well. Composed of 9 chars
        numStr =  num2str(val);
        numChars = numel(numStr);

        switch numChars
            case 8
                    instruction = [sortNOMV,spaceChar,numStr];
                     fprintf(dataPort,instruction);
                     response = fscanf(dataPort,'%s');
                        
               
            otherwise
        
         response = 'Nominal value format: (+/-)X.XXXXX!';
        
        end
        otherwise
        
        response = 'Invalid option!';

end