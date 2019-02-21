clc
clear

serialBufferSize = 128;

cleanDevices = querySerialPorts();

[index,v] = listdlg('PromptString','Select a COM Port:',...
                'SelectionMode','single',...
                'ListString',cleanDevices');

comPort = char(cleanDevices(1,index));

% Open COM serial Port selected
LCR = startSerialTM (comPort, serialBufferSize);
success = startCommunicationTM(LCR);
dataPort = LCR;
responseTRIGGER = measurementCOM(0, LCR);