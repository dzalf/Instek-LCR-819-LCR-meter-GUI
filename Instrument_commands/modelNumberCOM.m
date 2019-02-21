function response = modelNumberCOM(dataPort)
%% QUERIES THE MUDEL NUMBER OF THE INSTRUMENT
    
             fprintf(dataPort,'COMU:MONO'); 
             response = fscanf(dataPort,'%s');
   
end
