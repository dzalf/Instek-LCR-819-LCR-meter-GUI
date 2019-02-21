
function response = initiateCOM(dataPort)
%% INITIATES THE RS-232 CONNECTION.

% DISPLAYY SHOWS 'RS232 ONLINE'

fprintf(dataPort,'COMU:OVER'); 
% pause(0.001)
response = fscanf(dataPort,'%s');
% % responses
% comuOVER = ['COMU:OVER'];
end