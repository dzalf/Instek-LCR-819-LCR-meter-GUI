clear datePoints
clear data
clear timePoints
clear splitValandUnits
clear splitPrim
clear splitSeco
clear splitDate
clear units
clear unitsTemp
clear t
clear capturedData

dataLCRFig = figure;
existFig = strcmp(dataLCRFig.Visible,'on');
rows = 1;
col = 1;
speed = 1;
iterations = 1;
bufSize = 10;
flagPlot = 0;
%% Work on this later. Cleaning spurious data
bufSize = 10;
avgData = zeros(bufSize,1);
dataBuf = zeros(bufSize,1);

flushinput(LCR);
tic

speed = 1;
[resSpeed,speed] = speedCOM(speed,LCR);

for i=1:30
    existFig = strcmp(dataLCRFig.Visible,'on');
    startCOM(speed,LCR);
    data{rows,col} = readBufferCOM(LCR)
    
%     resHold = measureHoldCOM(LCR); 
    if isequal (col, 2)

        if isequal(flagPlot,0)
            
            dataLCRFig.Name = 'LCR819 Data Acquisiton';
            dataLCR = gca;
            lineMain =  animatedline;
            set(lineMain, 'LineWidth', 1.5);
            set(lineMain, 'Color', [ 0.2 0.3 0.8]);
            title( 'Live data from LCR819');
            set(dataLCR,'FontSize', 11);
            dataLCR.XTickLabelRotation  = 45;
            xlabel('Time [min]')
            
            flagPlot = 1;
        end
%         set(handles.statusBox,'BackgroundColor', [0 1 0]);
        t(rows,1) =  datetime('now', 'Format','HH:mm:ss:ms'); %, 'Format','HH:mm:ss';
        timePoints(rows,1) = datenum(t(rows));
        datePoints(rows,1) = datetime('now', 'Format', 'dd-MMM-yyyy HH:mm:ss:ms');
        
        splitDate(rows,:) = strsplit(char(datePoints(rows)),' ' );
        splitPrim(rows,:) = strsplit(char(data(rows,1)),'M' );
        splitSeco(rows,:) = strsplit(char(data(rows,2)),'O' );
        
        divideUnitsSeco = isstrprop(char(data(rows,2)),'digit');
        positions = find(divideUnitsSeco);
        unitsTemp(rows,1) = extractAfter(data(rows,2),max(positions));
        
        u = unitsTemp;
        unit = unitsTemp{1};
        
        if ~isempty(unit)
            
            chrSplit = char(unit(1,1));
            splitValandUnits(rows,:) = strsplit(char(splitSeco(rows,2)),chrSplit);
            
        else
            
            splitValandUnits = splitSeco(:,2);
            
        end

        %% Live Plot Routine
        addpoints(lineMain, timePoints(rows), str2double(cell2mat(splitPrim(rows,3))));
        
        ylabel(strcat({'Primary Unit:'},{' '},{char(u{1})}));
        grid on;
        grid minor;
        datetick('x','keeplimits')
        refreshdata(lineMain);
        drawnow limitrate
        
    end
    
    if isequal(col,2)
        
        col = 1;
        rows = rows + 1;

    else
        
        if strcmp(data{rows, col}, 'Empty buffer')
            disp("Empty buffer found!")
           % col = col;
%             resRecover = measureRecoverCOM(LCR);
        else
            col = col + 1;
%             resRecover = measureRecoverCOM(LCR);
        end
        
    end
    
end
toc
flushinput(LCR)
 measureHoldCOM(LCR);

capturedData = cell(rows, 5); % rows has one more dimension after the last increment
capturedData(1, 1:5) = {'Date','Timestamp','Primary value', 'Units','secondary value',};
capturedData(2:end,1:2) = cellstr(splitDate);
capturedData(2:end,3) = splitPrim(:,3);
capturedData(2:end,4) = unitsTemp;
capturedData(2:end,5) = splitValandUnits(:,1);

capturedData