

function response = openCalCOM(dataPort)
%% OPEN (OPEN CIRCUIT CALIBRATION) CODE OPTIONS


r = levelDisplayCOM(4,dataPort); %OFFSET
fprintf('Level display => %s',r);
fprintf('\r');
pause(0.5)          

fprintf(dataPort,'OFFS:OPEN');

calTime = 10;
    h = waitbar(0,'Open circuit calibration (10 secs)...');
    tic
    while toc < calTime
        waitbar(toc/calTime);
    %     pause(3)
    end

    close(h)

response = fscanf(dataPort,'%s');

flushinput(dataPort)

r = levelDisplayCOM(0,dataPort); %MAIN
fprintf('Level display => %s',r);
fprintf('\r');

% % responses
% openOK = ['OPEN:OK'];
% openFAIL = ['OPEN:FAIL'];

end