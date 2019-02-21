
function response = onlineQUERY(dataPort)
%% QUERIES THE RS232 CONNECTION STATUS

fprintf(dataPort,'COMU?');
pause(0.001)
response = fscanf(dataPort,'%s');
% % responses
% comuON = ['COMU:ON'];
end