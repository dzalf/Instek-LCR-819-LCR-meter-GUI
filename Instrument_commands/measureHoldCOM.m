
function response = measureHoldCOM(dataPort)
%% HOLD IS USED SU SUSPEND THE MEASUREMENT TO ISSUE  NEW COMMAND
%pause(0.1)
fprintf(dataPort,'COMU:HOLD'); 

response = fscanf(dataPort,'%s');
% % responses
% comuHOLD = ['COMU:HOLD'];
end