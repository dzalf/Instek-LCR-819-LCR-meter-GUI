
function response = shortCalCOM(dataPort)
%% SHORT (SHORT CIRCUIT CALIBRATION) CODE OPTIONS

r = levelDisplayCOM(4,dataPort); %OFFSET
fprintf('Level display => %s',r);
fprintf('\r');

pause(0.5)

fprintf(dataPort,'OFFS:SHOR'); 

calTime = 10;
    h = waitbar(0,'Short circuit calibration (10 secs)...');
    tic
    while toc < calTime
        waitbar(toc/calTime);
    end

close(h)
    
response = fscanf(dataPort,'%s');

flushinput(dataPort);

r = levelDisplayCOM(0,dataPort); %MAIN
fprintf('Level display => %s',r);
fprintf('\r');

% % responses
% shorOK = ['SHOR:OK'];
% shorFAIL = ['SHOR:FAIL'];

end
