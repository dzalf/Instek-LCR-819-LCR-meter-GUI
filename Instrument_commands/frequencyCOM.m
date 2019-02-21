function response = frequencyCOM(opc,val,dataPort)
%% SETS TEST FREQUENCY
% <value> should be captured from a box. Must be composed of 7 digit
% characters including a decimal and '_' is a single space
% EG. MAIN:FREQ_0.01200

switch opc
    case 0 % QUERY
        
        fprintf(dataPort,'MAIN:FREQ?');
        response = fscanf(dataPort,'%s');
%       'MAIN:FREQ 0.01200' is a response option. Returns value in kHz

    case 1 % SET VALUE
        
        spaceChar = ' ';
        dotChar = '.';
        zeroChar = '0';
        mainFREQ = 'MAIN:FREQ'; % is a response as well. Composed of 9 chars
        numStr = sprintf('%-.3f', val);  % DIDN'T WORK --> num2str(val);
        numChars = numel(numStr);
        
        switch numChars
            
            case 5
                if or(val < 0.01200 ,val > 100.000)
                response = 'Out of limits';
                
                else
                     instruction = [mainFREQ,spaceChar,numStr,zeroChar,zeroChar];
                     
                      fprintf(dataPort,instruction);
                      response = fscanf(dataPort,'%s');       
                end
                
            case 6
                if or(val < 0.01200 ,val > 100.000)
                response = 'Out of limits';
                
                else
                     instruction = [mainFREQ,spaceChar,numStr,zeroChar];
                     
                   fprintf(dataPort,instruction);
                    response = fscanf(dataPort,'%s');       
                end
            case 7
                if or(val < 0.01200 ,val > 100.000)
                response = 'Out of limits';
                
                else
                     instruction = [mainFREQ,spaceChar,numStr];
                     
                      fprintf(dataPort,instruction);
                      response = fscanf(dataPort,'%s');
                        
                end
                
            otherwise
        
         response = 'Frequecy value range 0.01200-100.000!';
        
        end
    otherwise
        
        response = 'Invalid option!';
        
        

end