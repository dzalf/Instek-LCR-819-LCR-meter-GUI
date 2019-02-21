function [success, handles] = sendLCRCurrentStatus(handles)

% Set manual trigger
responseTRIGGER = measurementCOM(1, handles.LCR);

% Query speed from panel and send value

speed = get(handles.speedListBox, 'Value');

[resSPEED,handles.speed] = speedCOM(speed, handles.LCR);

%Query LCR mode and send status

mode = get(handles.modeListBox, 'Value');

resMODE = modeCOM(mode, handles.LCR);

%Query circuit mode and send selection

circuit = get(handles.circuitListBox, 'Value');

resCIRCUIT = circuitCOM(circuit, handles.LCR);

%% Query frequencies
f1 = get(handles.oneButton, 'Value');
f10 = get(handles.tenButton, 'Value');
f100 = get(handles.hundredButton, 'Value');

if isequal(f1, 1)   
    res1k = frequencyCOM(1,1.000, handles.LCR);
    handles.testFreq = {'1 kHz'};
end

if isequal(f10, 1)   
    res10k = frequencyCOM(1,10.000, handles.LCR); 
    handles.testFreq = {'10 kHz'};
end

if isequal(f100, 1)   
    res100k = frequencyCOM(1,100.000, handles.LCR);
    handles.testFreq = {'100 kHz'};
end

success = 1;

end