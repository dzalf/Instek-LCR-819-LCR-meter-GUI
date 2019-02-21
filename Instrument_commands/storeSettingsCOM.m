
function response = storeSettingsCOM(mem,dataPort)
%% STORE (CURRENT SETTINGS TO ONE OF 100 MEMORY SLOTS) CODE OPTIONS

% <value> should be captured from a box. Must be composed of 4 characters
% and '_' is a single space

spaceChar = ' ';
dotChar = '.';
zeroChar = '0';
memoSTOR = 'MEMO:STOR'; % is a response as well. Composed of 9 chars
numValue = int2str(mem);
numChars = numel(numValue);

switch numChars
    case 1
        if mem < 1
            response = 'Min memory exceeded!';
        else
            instruction = [memoSTOR,spaceChar,numValue,dotChar,zeroChar,zeroChar];
            fprintf(dataPort,instruction);
            response = fscanf(dataPort,'%s');
%           response = instruction;
        end
    case 2
        instruction = [memoSTOR,spaceChar,numValue,dotChar,zeroChar];
        fprintf(dataPort,instruction);
             response = fscanf(dataPort,'%s');
%            response = instruction;
    case 3
        if mem > 100
            response = 'Max memory exceeded!';
        else
            instruction = [memoSTOR,spaceChar,numValue,dotChar];
            fprintf(dataPort,instruction);
            response = fscanf(dataPort,'%s');
%           response = instruction;
        end
end


end

