function startCOM(speed,dataPort)
%% START MEASUREMENT MODE CODE OPTIONS   
        switch speed
            case 1 % SLOW
             fprintf(dataPort,'MAIN:STAR'); 
             pause(1) %0.28 is the best option
%              response = 'Measurement started!';

            case 2 %MEDIUM
                fprintf(dataPort,'MAIN:STAR'); 
             pause(0.5)
            case 3 % FAST
                fprintf(dataPort,'MAIN:STAR'); 
             pause(0.28)
        end
          
end
