function varargout = LCRDAQ(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @LCRDAQ_OpeningFcn, ...
    'gui_OutputFcn',  @LCRDAQ_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before LCRDAQ is made visible.
function LCRDAQ_OpeningFcn(hObject, eventdata, handles, varargin)

handles = MainDataStructure(handles);  % Initialize the main group data structure

addpath(genpath(handles.base_directory));  % Add all m-file directories to the search path

% Load initial state of controls and buttons
handles = initialState(handles);
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = LCRDAQ_OutputFcn(hObject, eventdata, handles)

varargout{1} = handles.output;

function console_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function console_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in engageButton.
function engageButton_Callback(hObject, eventdata, handles)
set(handles.console, 'String', 'Engaging communication with LCR819');
%% Engage MODE

if isequal(handles.engageFlag,0)
    disp('Engage mode')
    handles.lastVal = handles.engageFlag;
    set(handles.engageButton,'String', 'ENGAGE LCR');
    
    successENGAGE = engageCommunication(handles);
    pause(0.2);
    
    if isequal(successENGAGE,1)
        [successSTATUS, handles] = sendLCRCurrentStatus(handles);
        handles.engageFlag = 1;
        
        if isequal(successSTATUS,1)
            set(handles.startButton, 'Enable', 'on')
            set(handles.console, 'String', 'Initial configuration finished. READY');
            set(handles.engageButton,'String', 'DISENGAGE');
             set(handles.engageButton,'BackgroundColor', [243/255, 122/255, 122/255]);
            set(handles.COMBox,'BackgroundColor', [0.1 0.7 0.1]);
            set(handles.startButton,'BackgroundColor', [0 1 0]);
            
        else
            set(handles.console, 'String', 'Initialization failed');
            handles = initialState(handles);
        end
        
    else
        set(handles.console, 'String', 'Handshake with LCR failed! :(');
    end
    
    handles.engageFlag = 1;
else
    
    %% Disengage MODE
    
    disp('Disengage mode')
    responseTRIGGER = measurementCOM(2, handles.LCR);
    set(handles.capturedList, 'String', {('Captured '),('Data')})
    set(handles.engageButton,'String', 'ENGAGE LCR');
    set(handles.engageButton, 'BackgroundColor', [0 0.7 0]);
   
    set(handles.COMBox,'BackgroundColor', [0.5 0.7 0.2]);
    set(handles.statusBox,'BackgroundColor', [0.5 0.5 0.5]);
    set(handles.startButton,'BackgroundColor', [0.94 0.94 0.94]);
    set(handles.startButton, 'Enable', 'off')
    
    set(handles.speedListBox, 'Enable', 'off');
    set(handles.modeListBox, 'Enable', 'off');
    
    set(handles.circuitListBox, 'Enable', 'off');
    set(handles.oneButton, 'Enable', 'off');
    set(handles.tenButton, 'Enable', 'off');
    set(handles.hundredButton, 'Enable', 'off');
    
    handles.engageFlag = 0;
    killCOM(handles.LCR);
    if isequal(handles.lastVal,0)
        handles.engageFlag = 0;
    end
    set(handles.console, 'String', 'LCR disengaged');
end

guidata(hObject, handles)
return


% --- Executes on button press in stopButton.
function stopButton_Callback(hObject, eventdata, handles)

setFlagAcquisiton(0);


set(handles.statusBox,'BackgroundColor', [0.5 0.5 0.5]);
set(handles.console, 'String', 'Stopping acquisition');
set(handles.stopButton, 'Enable', 'off')

pause(0.5);

set(handles.engageButton,'Enable', 'on')
set(handles.killCOM,'Enable', 'on')
set(handles.stopButton,'Enable', 'off')
set(handles.stopButton, 'BackgroundColor', [0.7 0.7 0.7]);
set(handles.console, 'String', 'Acquisition stopped! LCR is idle...');

guidata(hObject, handles);  % Update the handles structure
return
% --- Executes on button press in saveButton.
function saveButton_Callback(hObject, eventdata, handles)

writeExcelFile(handles)
return
function txtName_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function txtName_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in portsList.
function portsList_Callback(hObject, eventdata, handles)
set(handles.console, 'String', 'Working on selection...');
pause(1)
set(handles.portsList, 'Enable', 'off')
set(handles.portsList, 'FontWeight', 'bold')
set(handles.queryButton, 'Enable', 'off');
set(handles.portsList, 'ForegroundColor', [1 0 0])

index = get(handles.portsList,'Value');
handles.comPort = handles.cleanDevices(1,index);

stringFound =  strcat('Device found and linked in -> ', handles.comPort);
set(handles.console, 'String', stringFound);
pause(2)
set(handles.console, 'String', 'Serial port ready to ENGAGE with LCR');
handles.LCR = startSerial (handles.comPort); %Create serial port structure
set(handles.killCOM, 'Enable', 'on');
set(handles.engageButton,'Enable', 'on')
set(handles.engageButton, 'BackgroundColor', [0 0.7 0]);
set(handles.COMBox, 'BackgroundColor', [0 1 0]);

guidata(hObject, handles);  % Update the handles structure
return


% --- Executes during object creation, after setting all properties.
function portsList_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in queryButton.
function queryButton_Callback(hObject, eventdata, handles)

set(handles.portsList, 'Enable', 'on')
set(handles.console, 'String', 'Looking for available devices');
handles.cleanDevices = querySerialPorts();
devs = handles.cleanDevices';
if ~isempty(handles.cleanDevices)
    set(handles.console, 'String', 'Devices found! :)');
    pause(1)
    set(handles.portsList, 'String', devs);
    set(handles.console, 'String', 'Select a device from the list');
    set(hObject, 'Enable', 'off')
else
    pause(1);
    set(handles.console, 'String', 'No devices found! :(');
    pause(2);
    handles = initialState(handles);
end
guidata(hObject, handles);  % Update the handles structure
return

% --- Executes on button press in killCOM.
function killCOM_Callback(hObject, eventdata, handles)

if isequal(handles.engageFlag, 1)
    responseTRIGGER = measurementCOM(2, handles.LCR);
    set(handles.engageButton,'Enable', 'off');
    set(handles.startButton,'Enable', 'off');
    set(handles.startButton, 'BackgroundColor', [0.94 0.94 0.94]);
    killCOM(handles.LCR);
    flushinput(handles.LCR);
    fclose(handles.LCR);
    delete(handles.LCR);
else
    flushinput(handles.LCR);
    fclose(handles.LCR);
    delete(handles.LCR);
end

set(handles.engageButton, 'Enable', 'off');
set(handles.engageButton, 'BackgroundColor', [0.94 0.94 0.94]);
set(handles.killCOM, 'Enable', 'off');
set(handles.console, 'String', 'Serial port closed');
pause(0.5);
set(handles.console, 'String', strcat({'Select COM device from the list.'}, {' '},{char(handles.comPort)}, {' '}, {'still available'}));
set(handles.portsList, 'Enable', 'on');
set(handles.portsList, 'ForegroundColor', [1 1 1]);
set(handles.portsList, 'FontWeight', 'normal');
set(handles.queryButton, 'Enable', 'on');
set(handles.COMBox, 'BackgroundColor', [1 0 0]);
guidata(hObject, handles);  % Update the handles structure
return


% --- Executes on button press in oneButton.
function oneButton_Callback(hObject, eventdata, handles)

if isequal (handles.oneFlag,0)
    handles.oneFlag = 1;
    handles.tenFlag = 0;
    handles.hundredFlag = 0;
    handles.testFreq = {'1 kHz'};
    set(handles.oneButton, 'Value', 1);
    set(handles.tenButton, 'Value', 0);
    set(handles.hundredButton, 'Value', 0);
    r= frequencyCOM(1,1.00000, handles.LCR);
    set(handles.console, 'String', r)
    flushinput(handles.LCR)
    pause(0.5)
    set(handles.console, 'String', 'Click START to begin aquisition')
end

guidata(hObject, handles)
return


% --- Executes on button press in tenButton.
function tenButton_Callback(hObject, eventdata, handles)

if isequal (handles.tenFlag,0)
    handles.oneFlag = 0;
    
    handles.tenFlag = 1;
    handles.hundredFlag = 0;
    handles.testFreq = {'10 kHz'};
    set(handles.oneButton, 'Value', 0);
    set(handles.tenButton, 'Value', 1);
    set(handles.hundredButton, 'Value', 0);
    r= frequencyCOM(1,10.0000, handles.LCR);
    set(handles.console, 'String', r)
    flushinput(handles.LCR)
    pause(0.5)
    set(handles.console, 'String', 'Click START to begin aquisition')
end

guidata(hObject, handles)
return

% --- Executes on button press in hundredButton.
function hundredButton_Callback(hObject, eventdata, handles)

if isequal (handles.hundredFlag,0)
    handles.oneFlag = 0;
    handles.tenFlag = 0;
    handles.hundredFlag = 1;
    handles.testFreq = {'100 kHz'};
    set(handles.tenButton, 'Value', 0);
    set(handles.oneButton, 'Value', 0);
    set(handles.hundredButton, 'Value', 1);
    r = frequencyCOM(1,100.000, handles.LCR);
    set(handles.console, 'String', r)
    flushinput(handles.LCR)
    pause(0.5)
    set(handles.console, 'String', 'Click START to begin aquisition')
end

guidata(hObject, handles)
return

% --- Executes on selection change in circuitListBox.
function circuitListBox_Callback(hObject, eventdata, handles)

val = get(hObject, 'Value');

r = circuitCOM(val, handles.LCR);

set(handles.console, 'String', strcat('LCR says: ', r));
flushinput(handles.LCR)
pause(0.5)
set(handles.console, 'String', 'Click START to begin aquisition')
guidata(hObject, handles);
return


% --- Executes during object creation, after setting all properties.
function circuitListBox_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in modeListBox.
function modeListBox_Callback(hObject, eventdata, handles)

val  = get(hObject, 'Value');
% val = 2; % fiex C/R mode
r = modeCOM(val, handles.LCR);

set(handles.console, 'String', strcat('LCR says: ', r))
pause(0.5)
set(handles.console, 'String', 'Click START to begin aquisition')
flushinput(handles.LCR)
guidata(hObject, handles);
return


% --- Executes during object creation, after setting all properties.
function modeListBox_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in speedListBox.
function speedListBox_Callback(hObject, eventdata, handles)

val = get(hObject, 'Value');
[resSpeed,handles.speed] = speedCOM(val, handles.LCR);
set(handles.console, 'String', strcat('LCR says:',resSpeed))
flushinput(handles.LCR)
pause(0.5)
set(handles.console, 'String', 'Click START to begin aquisition')
guidata(hObject, handles);
return


% --- Executes during object creation, after setting all properties.
function speedListBox_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in capturedList.
function capturedList_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function capturedList_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in startButton.
function startButton_Callback(hObject, eventdata, handles)
set(handles.console, 'String', 'Starting acquisition...');

handles.alreadyCaptured = handles.alreadyCaptured + 1;
setFlagAcquisiton(1);
set(handles.stopButton, 'Enable', 'on')
handles.capturedData = acquireData(handles);
set(handles.saveButton, 'Enable', 'on');

guidata(hObject, handles)
return
