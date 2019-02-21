function response = levelDisplayCOM(opc,dataPort)

%% DISPLAYS A MENU LEVEL ON THE LCR-800
% SETS THE DISPLAY TO THE <OPC> DISPLAY LEVEL

%RETURNS THE MENU LEVEL

switch opc
    case 0 % MAIN DISPLAY
          
          fprintf(dataPort,'LEVE:MAIN'); 
          response = fscanf(dataPort,'%s'); 
          
    case 1 % MENU DISPLAY
          
          fprintf(dataPort,'LEVE:MENU'); 
          response = fscanf(dataPort,'%s');
          
    case 2 % SETTING (PARAMETER MENU)
         
          fprintf(dataPort,'LEVE:PARA'); 
          response = fscanf(dataPort,'%s');
          
    case 3 % SORT (HANDLER) MENU
          
          fprintf(dataPort,'LEVE:SORT'); 
          response = fscanf(dataPort,'%s');
    
    case 4 % OFFSET MENU
          
          fprintf(dataPort,'LEVE:OFFS'); 
          response = fscanf(dataPort,'%s');
          
    otherwise
          response = 'Invalid option!';
end