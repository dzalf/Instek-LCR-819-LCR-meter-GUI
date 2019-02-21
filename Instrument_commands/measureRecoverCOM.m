function response = measureRecoverCOM(dataPort)
%% RECOVER IS USED TO RESUME THE MEASUREMENT TO ISSUE  NEW COMMAND

fprintf(dataPort,'COMU:RECO'); 
response = fscanf(dataPort,'%s');
% % responses
% comuRECO = ['COMU:RECO'];
end