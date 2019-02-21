function success = startCommunicationTM(LCR)

%% Initialization routine with the instrument

responseQUERY = onlineQUERY(LCR); % send request to the LCR

    if isequal(responseQUERY,'COMU:ON..')    % if communications was successful
        
        responseINITIATE = initiateCOM(LCR); 
        responseTRIGGER = measurementCOM(1, LCR);
        
            if isequal(responseINITIATE,'COMU:OVER') 
                
                disp('Communication was successful!');
 
                success = 1;
 
            end
        
    elseif isempty(responseQUERY)
       
        disp('Communication not successful :( ');
        
    end
 
return;