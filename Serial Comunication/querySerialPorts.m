function  cleanDevices = querySerialPorts()

foundPorts = scanports(10);  % seek for serial ports
devices = foundPorts';
numPorts = size(devices,2);

if numPorts >= 1
    [r,c] = size(devices);
    
    row = 1;
    col = 1;
    done = false;
    
    for i = 1:r
        
        for j = 1:c
            
            if isempty(devices{i,j})
                done = false;
            else
                row;
                col;
                cleanDevices(row,col) = devices(i,j);
                done = true;
                if (done) && isequal(col,c)
                    row = row + 1;
                    done = false;
                end
                
                
            end
            col = col + 1;
            
            if col > c
                col = 1;
            end
        end
        
    end
    
else
    devices = {};
    comPort = {};
    cleanDevices = {};
    
end
end