function [response,speed] = speedCOM(opc,dataPort)

%% SPEED CODE OPTIONS

switch opc
    case 0 % QUERY
          
          fprintf(dataPort,'MAIN:SPEE?'); 
          response = fscanf(dataPort,'%s');
              
              if strcmp(response,'MAIN:SPEE:SLOW')
                  speed = 1;
              elseif strcmp(response,'MAIN:SPEE:MEDI')
                  speed = 2;
              elseif strcmp(response,'MAIN:SPEE:FAST')
                  speed = 3;
              else
                  speed = 2;
              end
          
    case 1 % SLOW
          
          fprintf(dataPort,'MAIN:SPEE:SLOW'); 
          response = fscanf(dataPort,'%s');
          speed = 1;
          
    case 2 % MEDIUM
         
          fprintf(dataPort,'MAIN:SPEE:MEDI'); 
          response = fscanf(dataPort,'%s');
          speed = 2;
          
    case 3 % FAST
          
          fprintf(dataPort,'MAIN:SPEE:FAST'); 
          response = fscanf(dataPort,'%s');
          speed = 3;
          
    otherwise
        
          response = 'Invalid option!';
         
end
