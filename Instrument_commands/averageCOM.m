function response = averageCOM(opc,val,dataPort)
%% SETS AVERAGE NUMBER FROM 1-255. HOW MANY TEST SAMPLES ARE USED TO CREATE AN AVRAGED RESULT
% <value> should be captured from a box. Must be composed of 4 characters
% and '_' is a single space

switch opc
    case 0 % QUERY
        
        fprintf(dataPort,'STEP:AVER?');
        response = fscanf(dataPort,'%s');
%          'MEMO:RECA:EMPT' is a response option    
    case 1 % RECALL SETTING
        
        spaceChar = ' ';
        dotChar = '.';
        zeroChar = '0';
        stepAVER = 'STEP:AVER'; % is a response as well. Composed of 9 chars
        numValue = int2str(val);
        numChars = numel(numValue);

        switch numChars
            case 1
                if val < 1
                    response = 'Value too low!';
                else
                    instruction = [stepAVER,spaceChar,numValue,dotChar,zeroChar,zeroChar];
                    fprintf(dataPort,instruction);
                    response = fscanf(dataPort,'%s');
        %           response = instruction;
                end
            case 2
                instruction = [stepAVER,spaceChar,numValue,dotChar,zeroChar];
                fprintf(dataPort,instruction);
                response = fscanf(dataPort,'%s');
        %       response = instruction;
            case 3
                if val > 255
                    response = 'Value too high!';
                else
                    instruction = [stepAVER,spaceChar,numValue,dotChar];
                    fprintf(dataPort,instruction);
                    response = fscanf(dataPort,'%s');
        %           response = instruction;
                end
        end
        
    otherwise
        
        response = 'Invalid option!';

end