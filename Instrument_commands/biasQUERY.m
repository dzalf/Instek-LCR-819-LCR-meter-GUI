function response = biasQUERY(dataPort)
%% BIAS QUERY OPTIONS
    fprintf(dataPort,'MAIN:BIAS?'); 
    response = fscanf(dataPort,'%s');
end