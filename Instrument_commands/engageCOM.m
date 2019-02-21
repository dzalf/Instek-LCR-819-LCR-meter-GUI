function [handles,response,dataPort]= engageCOM(handles)
% Engage communication deleting serial ports --> assigning dataPort and 
% starting communication on request by the user

[handles,numPorts,portList] = deleteSerialPorts(handles,15);
portList

% [handles,dataPort] = assignDataPort(handles,numPorts,portList);

% [handles,response] = startCommunication(dataPort);



return