function success = engageCommunication(handles)

%% Initialization routine with the instrument

responseQUERY = onlineQUERY(handles.LCR); % send request to the LCR

if isequal(responseQUERY,'COMU:ON..')    % if communications was successful
    
    responseINITIATE = initiateCOM(handles.LCR);

    if isequal(responseINITIATE,'COMU:OVER')
        responseTRIGGER = measurementCOM(1, handles.LCR);    
        
        pause(0.3)
        
        measureHoldCOM(handles.LCR);

        message = sprintf('Communication was successful!');
        set(handles.console, 'String', message);
        
        success = 1;
        
        responseTRIGGER = measurementCOM(0, handles.LCR); %Tell the LCR to wait for instructions
        
        if isequal(responseTRIGGER, 'MAIN:TRIG:MANU')
            set(handles.console, 'String', 'Engaged. Trigger set to MANUAL mode')
        end
        
        % Enable buttons and panels. Set current status
       
        set(handles.speedListBox, 'Enable', 'on');
        set(handles.modeListBox, 'Enable', 'on');
        
        set(handles.circuitListBox, 'Enable', 'on');
        set(handles.oneButton, 'Enable', 'on');
        set(handles.tenButton, 'Enable', 'on');
        set(handles.hundredButton, 'Enable', 'on');
        
        set(handles.COMBox,'BackgroundColor', [0 1 0]);
        
    end
    
    set(handles.console, 'String', 'Initialization finished...');
    
elseif isempty(responseQUERY)
    success = 0;
    set(handles.console, 'String', 'Communication not successful :( ');
    %         set(handles.retry, 'Visible', 'On');
    set(handles.COMBox,'BackgroundColor', [1 0 0]);
end

return