function [handles] = assignDataPort(handles, portList)

%% Scan again to assign the instrument serial port

%% OPTION 1: This routine works well
options = portList;
[opc,result] = listdlg('PromptString','Select a serial port:',...
                'SelectionMode','single',...
                'ListSize', [100,60],...
                'ListString',options);
if result == 1
    portString = portList(opc);
    chosenPort = char(portString());

    message = sprintf('Instrument attached to port %s', chosenPort);
    % Show connection figure
    set(handles.RS232,'visible','on')
    serialFig = imread('RS-232.png');
    axes(handles.RS232);
    imshow(serialFig, 'parent', handles.RS232);
    % **
    
    set(handles.COMBox, 'Enable', 'on');
    
    set(handles.console, 'String', message);
    set(handles.COMBox, 'String', chosenPort);
    termArray = {'LF','LF/CR'}; % Terminators! I'll be back!!!

    %% Serial port configuration
    handles.dataPort = serial(chosenPort);
    set(handles.dataPort, 'Terminator', termArray); % set communication string to end on ASCII 13
    set(handles.dataPort, 'BaudRate', 38400);   % NEVER CHANGE THE DEFAULT BAUDRATE! THE INSTRUMENT GETS CRAZY!!!
    set(handles.dataPort, 'StopBits', 1);    
    set(handles.dataPort, 'DataBits', 8);
    set(handles.dataPort, 'Parity', 'none')
    set(handles.dataPort, 'Timeout',5); % Check this value!
    set(handles.dataPort, 'InputBufferSize', 128); % Check this value! This seems to be te clue Default is 512

    baudsStr = handles.dataPort.BaudRate;
    set(handles.baudBox, 'Enable', 'on');
    set(handles.baudBox, 'String', baudsStr);
end
return;