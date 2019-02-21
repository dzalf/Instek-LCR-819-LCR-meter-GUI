function LCR = startSerialTM (comPort)
    cleanDevices = querySerialPorts();
    comPort = cleanDevices{1,3};
    LCR = serial(char(comPort));
    LCR.InputBufferSize = 128;
    
    termArray = {'LF','LF/CR'}; % Terminators! I'll be back!!!

    %% Serial port configuration
%     
    set(LCR, 'Terminator', termArray); % set communication string to end on ASCII 13
    set(LCR, 'BaudRate', 38400);   % NEVER CHANGE THE DEFAULT BAUDRATE! THE INSTRUMENT GETS CRAZY!!!
    set(LCR, 'StopBits', 1);    
    set(LCR, 'DataBits', 8);
    set(LCR, 'Parity', 'none');
    set(LCR, 'Timeout',20); % Check this value!
%     set(LCR, 'InputBufferSize', 128); % Check this value! This seems to be te clue Default is 512
    
    try
        fopen(LCR);
    catch err
        fclose(instrfind);
        error('Make sure you select the correct COM Port where the instrument is connected.');
    end
    
end