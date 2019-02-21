function  killCOM(dataPort)
%% TERMINATES THE RS-232 CONNECTION.

% DISPLAYY SHOWS 'RS232 ONLINE'

fprintf(dataPort,'COMU:OFF.'); 
fprintf(dataPort,'MAIN:TRIG:AUTO'); 

% response = fscanf(dataPort,'%s');
% % responses
% comuOFF = 'COMU:OFF.';
end