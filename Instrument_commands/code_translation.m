
%% SPEED CODE OPTIONS

tic; fprintf(dataPort,'MAIN:SPEE?'); response = fscanf(dataPort,'%s');fprintf('\n'); disp(response); fprintf('\n'); toc

tic; fprintf(dataPort,'MAIN:SPEE:SLOW'); response = fscanf(dataPort,'%s');fprintf('\n'); disp(response); fprintf('\n'); toc

tic; fprintf(dataPort,'MAIN:SPEE:MEDI'); response = fscanf(dataPort,'%s');fprintf('\n'); disp(response); fprintf('\n'); toc

tic; fprintf(dataPort,'MAIN:SPEE:FAST'); response = fscanf(dataPort,'%s');fprintf('\n'); disp(response); fprintf('\n'); toc

%% DISPLAY CODE OPTIONS

tic; fprintf(dataPort,'MAIN:DISP?'); response = fscanf(dataPort,'%s');fprintf('\n'); disp(response); fprintf('\n'); toc

tic; fprintf(dataPort,'MAIN:DISP:VALU'); response = fscanf(dataPort,'%s');fprintf('\n'); disp(response); fprintf('\n'); toc

tic; fprintf(dataPort,'MAIN:SPEE:DELP'); response = fscanf(dataPort,'%s');fprintf('\n'); disp(response); fprintf('\n'); toc

tic; fprintf(dataPort,'MAIN:SPEE:DELT'); response = fscanf(dataPort,'%s');fprintf('\n'); disp(response); fprintf('\n'); toc

%% MODE CODE OPTIONS

tic; fprintf(dataPort,'MAIN:MODE?'); response = fscanf(dataPort,'%s');fprintf('\n'); disp(response); fprintf('\n'); toc

tic; fprintf(dataPort,'MAIN:MODE:RQ'); response = fscanf(dataPort,'%s');fprintf('\n'); disp(response); fprintf('\n'); toc

tic; fprintf(dataPort,'MAIN:MODE:CD'); response = fscanf(dataPort,'%s');fprintf('\n'); disp(response); fprintf('\n'); toc

tic; fprintf(dataPort,'MAIN:MODE:CR'); response = fscanf(dataPort,'%s');fprintf('\n'); disp(response); fprintf('\n'); toc

tic; fprintf(dataPort,'MAIN:MODE:LQ'); response = fscanf(dataPort,'%s');fprintf('\n'); disp(response); fprintf('\n'); toc

%% CIRCUIT CODE OPTIONS

tic; fprintf(dataPort,'MAIN:CIRC?'); response = fscanf(dataPort,'%s');fprintf('\n'); disp(response); fprintf('\n'); toc

tic; fprintf(dataPort,'MAIN:CIRC:SERI'); response = fscanf(dataPort,'%s');fprintf('\n'); disp(response); fprintf('\n'); toc

tic; fprintf(dataPort,'MAIN:CIRC:PARA'); response = fscanf(dataPort,'%s');fprintf('\n'); disp(response); fprintf('\n'); toc

%% MEASUREMENT MODE (AUTO/MANU) CODE OPTIONS

tic; fprintf(dataPort,'MAIN:TRIG?'); response = fscanf(dataPort,'%s');fprintf('\n'); disp(response); fprintf('\n'); toc

tic; fprintf(dataPort,'MAIN:TRIG:MANU'); response = fscanf(dataPort,'%s');fprintf('\n'); disp(response); fprintf('\n'); toc

tic; fprintf(dataPort,'MAIN:TRIG:AUTO'); response = fscanf(dataPort,'%s');fprintf('\n'); disp(response); fprintf('\n'); toc

%% START MEASUREMENT MODE CODE OPTIONS

tic; fprintf(dataPort,'MAIN:STAR'); toc % No return is associated

%% RANGE HOLD CODE OPTIONS
tic; fprintf(dataPort,'MAIN:R.H.?'); response = fscanf(dataPort,'%s');fprintf('\n'); disp(response); fprintf('\n'); toc

tic; fprintf(dataPort,'MAIN:R.H.:OFF.'); response = fscanf(dataPort,'%s');fprintf('\n'); disp(response); fprintf('\n'); toc

tic; fprintf(dataPort,'MAIN:R.H.:ON..'); response = fscanf(dataPort,'%s');fprintf('\n'); disp(response); fprintf('\n'); toc

%% CONSTANT VOLTAGE CODE OPTIONS

tic; fprintf(dataPort,'MAIN:C.V.?'); response = fscanf(dataPort,'%s');fprintf('\n'); disp(response); fprintf('\n'); toc

tic; fprintf(dataPort,'MAIN:C.V.:OFF.'); response = fscanf(dataPort,'%s');fprintf('\n'); disp(response); fprintf('\n'); toc

tic; fprintf(dataPort,'MAIN:C.V.:ON..'); response = fscanf(dataPort,'%s');fprintf('\n'); disp(response); fprintf('\n'); toc

%% BIAS CODE OPTIONS

tic; fprintf(dataPort,'MAIN:BIAS?'); response = fscanf(dataPort,'%s');fprintf('\n'); disp(response); fprintf('\n'); toc

%% INT.B (INTERNAL BIAS) CODE OPTIONS

tic; fprintf(dataPort,'MAIN:INTB?'); response = fscanf(dataPort,'%s');fprintf('\n'); disp(response); fprintf('\n'); toc

tic; fprintf(dataPort,'MAIN:INTB:OFF.'); response = fscanf(dataPort,'%s');fprintf('\n'); disp(response); fprintf('\n'); toc

tic; fprintf(dataPort,'MAIN:INTB:ON..'); response = fscanf(dataPort,'%s');fprintf('\n'); disp(response); fprintf('\n'); toc

%% EXT.B (EXTERNAL BIAS) CODE OPTIONS

tic; fprintf(dataPort,'MAIN:EXTB?'); response = fscanf(dataPort,'%s');fprintf('\n'); disp(response); fprintf('\n'); toc

tic; fprintf(dataPort,'MAIN:EXTB:OFF.'); response = fscanf(dataPort,'%s');fprintf('\n'); disp(response); fprintf('\n'); toc

tic; fprintf(dataPort,'MAIN:EXTB:ON..'); response = fscanf(dataPort,'%s');fprintf('\n'); disp(response); fprintf('\n'); toc

%% PPM (PARTS PER MILLION) CODE OPTIONS

tic; fprintf(dataPort,'MAIN:PPM.?'); response = fscanf(dataPort,'%s');fprintf('\n'); disp(response); fprintf('\n'); toc

tic; fprintf(dataPort,'MAIN:PPM.:OFF.'); response = fscanf(dataPort,'%s');fprintf('\n'); disp(response); fprintf('\n'); toc

tic; fprintf(dataPort,'MAIN:PPM.:ON..'); response = fscanf(dataPort,'%s');fprintf('\n'); disp(response); fprintf('\n'); toc

%% OPEN (OPEN CIRCUIT CALIBRATION) CODE OPTIONS

tic; fprintf(dataPort,'OFFS:OPEN'); response = fscanf(dataPort,'%s');fprintf('\n'); disp(response); fprintf('\n'); toc
% responses
openOK = ['OPEN:OK'];
openFAIL = ['OPEN:FAIL'];

%% SHORT (SHORT CIRCUIT CALIBRATION) CODE OPTIONS

tic; fprintf(dataPort,'OFFS:SHOR'); response = fscanf(dataPort,'%s');fprintf('\n'); disp(response); fprintf('\n'); toc
% responses
shorOK = ['SHOR:OK'];
shorFAIL = ['SHOR:FAIL'];

%% STORE (CURRENT SETTINGS TO ONE OF 100 MEMORY SLOTS) CODE OPTIONS

% <value> should be captured from a box. Must be composed of 4 characters
% and '_' is a single space

spaceChar = ' ';
dotChar = '.';
memoSTOR = 'MEMO:STOR'; % is a response as well
value = input('Memory position (1-100) --> ');
numValue = int2str(value);
instruction = [memoSTOR,spaceChar,numValue,dotChar];
fprintf('Final instruction %s',instruction)
fprintf('\n');
tic; fprintf(dataPort,'MEMO:STOR_<value>'); response = fscanf(dataPort,'%s');fprintf('\n'); disp(response); fprintf('\n'); toc
% responses

%% AVERAGE CODE OPTIONS

% <value> should be captured from a box. Must be composed of 4 characters
% and '_' is a single space
tic; fprintf(dataPort,'STEP:AVER?'); response = fscanf(dataPort,'%s');fprintf('\n'); disp(response); fprintf('\n'); toc
spaceChar = ' ';
dotChar = '.';
zeroChar = '0';
stepAVER = 'STEP:AVER'; % is a response as well
value = input('Set average value (1-255) --> ');
numValue = int2str(value);
instruction = [stepAVER,spaceChar,numValue,dotChar,zeroChar,zeroChar];
fprintf('Final instruction %s',instruction)
fprintf('\n');
tic; fprintf(dataPort,'MEMO:STOR_<value>'); response = fscanf(dataPort,'%s');fprintf('\n'); disp(response); fprintf('\n'); toc
% responses

