function handles = initialState(handles)


% constant declaration
handles.oneFlag = 0;
handles.tenFlag = 0;
handles.hundredFlag = 0;
handles.engageFlag = 0;
handles.alreadyCaptured = 0;
% setSliderVal(0.1);
%  buttons
set(handles.killCOM, 'Enable', 'off')
set(handles.startButton,'Enable', 'off');
set(handles.stopButton,'Enable', 'off');
set(handles.engageButton,'Enable', 'off');
set(handles.portsList, 'Enable', 'off');
set(handles.saveButton, 'Enable', 'off');
set(handles.speedListBox, 'Enable', 'off'); 
set(handles.capturedList, 'Enable', 'off'); 
set(handles.modeListBox, 'Enable', 'off');
set(handles.circuitListBox, 'Enable', 'off');
set(handles.oneButton, 'Enable', 'off');
set(handles.tenButton, 'Enable', 'off');
set(handles.hundredButton, 'Enable', 'off');
set(handles.COMBox, 'BackgroundColor', [1 0 0]);
%Flags

% handles.goFlag = 0;
setFlagAcquisiton(0);
% Console message 

set(handles.console, 'String', ' Start querying COM Devices');


end