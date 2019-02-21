function response = voltageCOM(opc,val,dataPort)
%% SETS TEST VOLTAGE
% <value> should be captured from a box. Must be composed of 5 digit
% characters including a decimal and '_' is a single space
% EG. MAIN:VOLT_0.005

switch opc
    case 0 % QUERY
        
         fprintf(dataPort,'MAIN:VOLT?');
         response = fscanf(dataPort,'%s');
%       'MAIN:FREQ 0.01200' is a response option. Returns value in kHz

    case 1 % SET VALUE
        
        spaceChar = ' ';
        dotChar = '.';
        zeroChar = '0';
        mainVOLT = 'MAIN:VOLT'; % is a response as well. Composed of 9 chars
        numStr = sprintf('%-.3f', val);  % DIDN'T WORK --> num2str(val);
        numChars = numel(numStr);
        
        switch numChars
            
            case 5
                if or(val < 0.005 ,val > 1.275)
                response = 'Out of limits';
                
                else
                    instruction = [mainVOLT,spaceChar,numStr];
                    fprintf(dataPort,instruction);
                    response = fscanf(dataPort,'%s');       
                end
                
            otherwise
        
         response = 'Voltage value range 0.005-1.275!';
        
        end
    otherwise
        
        response = 'Invalid option!';
    
end