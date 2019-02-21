function response = recallSettingsCOM(opc,mem,dataPort)
%% RECALL (CURRENT SETTINGS FROM ONE OF 100 MEMORY SLOTS) CODE OPTIONS
% <value> should be captured from a box. Must be composed of 4 characters
% and '_' is a single space

switch opc
    case 0 % QUERY
        
        fprintf(dataPort,'MEMO:NUMB?');
        response = fscanf(dataPort,'%s');
%          'MEMO:RECA:EMPT' is a response option    
    case 1 % RECALL SETTING
        
        spaceChar = ' ';
        dotChar = '.';
        zeroChar = '0';
        memoRECA = 'MEMO:RECA'; % is a response as well. Composed of 9 chars
        numValue = int2str(mem);
        numChars = numel(numValue);

        switch numChars
            case 1
                if mem < 1
                    response = 'Min memory exceeded!';
                else
                    instruction = [memoRECA,spaceChar,numValue,dotChar,zeroChar,zeroChar];
                    fprintf(dataPort,instruction);
                    response = fscanf(dataPort,'%s');
        %           response = instruction;
                end
            case 2
                instruction = [memoRECA,spaceChar,numValue,dotChar,zeroChar];
                fprintf(dataPort,instruction);
                response = fscanf(dataPort,'%s');
        %       response = instruction;
            case 3
                if mem > 100
                    response = 'Max memory exceeded!';
                else
                    instruction = [memoRECA,spaceChar,numValue,dotChar];
                    fprintf(dataPort,instruction);
                    response = fscanf(dataPort,'%s');
        %           response = instruction;
                end
                
            otherwise
        
                 response = 'Invalid option!';
        end
        
    

end