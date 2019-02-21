function capturedData = acquireData(handles)

set(handles.engageButton,'Enable', 'off');
flagAcq = getFlagAcquisition;
flagPlot = 0;
handles.speed = get(handles.speedListBox, 'Value');

rows = 1;
col = 1;

bufSize = 10;
avgBuf = zeros(bufSize/2,1);
dataBuf = zeros(bufSize,1);
indexDatum = 1;
indexAvg = 1;

titleLive = 'Live data from LCR819';
responseRECOVER = measureRecoverCOM(handles.LCR);
set(handles.capturedList, 'Enable', 'on');
set(handles.console, 'String', 'Capturing data from LCR');
set(handles.stopButton,'BackgroundColor', [1 0 0]);
set(handles.startButton,'BackgroundColor', [0.94 0.94 0.94]);
set(handles.startButton, 'Enable', 'off')
flushinput(handles.LCR);

startTime = datetime('now', 'Format','HH:mm:ss:ms');
while isequal(flagAcq,1)
    
    
    flagAcq = getFlagAcquisition;
    
    startCOM(handles.speed,handles.LCR);
    data{rows,col} = readBufferCOM(handles.LCR)
    
    if isequal (col, 2)
        
        if isequal(flagPlot,0)
            
            dataLCRFig = figure;
%             set(dataLCRFig,'Name', strcat("LCR819 Data Acquisiton"," - ",num2str(handles.alreadyCaptured)));
            dataLCR = gca;
            lineMain =  animatedline;
            set(lineMain, 'LineWidth', 1.5);
            set(lineMain, 'Color', [ 0.2 0.3 0.8]);
            mode = get(handles.modeListBox, 'Value');
            mode = get(handles.modeListBox, 'Value');
            set(dataLCR,'FontSize', 11);
            dataLCR.XTickLabelRotation  = 45;
            xlabel('Time [min]')
            
            flagPlot = 1;
        end
        
        set(handles.statusBox,'BackgroundColor', [0 1 0]);
        t(rows,1) =  datetime('now', 'Format','HH:mm:ss:ms'); %, 'Format','HH:mm:ss';
        timePoints(rows,1) = datenum(t(rows));
        datePoints(rows,1) = datetime('now', 'Format', 'dd-MMM-yyyy HH:mm:ss:ms');
        
        enlapsed = char(t(rows,1)-startTime); %+initialTime

        
        switch mode
            
            case 1
                txt = strcat("Mode: R/Q; ","Test freq:" , cellstr(handles.testFreq));
                title({titleLive,[ txt], ['Meas No: ' num2str(handles.alreadyCaptured)], ['Enlapsed: ' enlapsed]});
            case 2
                txt = strcat("Mode: C/D; ","Test freq: ", cellstr(handles.testFreq));
                title({titleLive,[ txt], ['Meas No: ' num2str(handles.alreadyCaptured)], ['Enlapsed: ' enlapsed]});
            case 3
                txt = strcat("Mode: C/R; ","Test freq: ", cellstr(handles.testFreq));
                title({titleLive,[ txt], ['Meas No: ' num2str(handles.alreadyCaptured)], ['Enlapsed: ' enlapsed]});
            case 4
                txt = strcat("Mode: L/Q ","Test freq: ", cellstr(handles.testFreq));
                title({titleLive,[ txt], ['Meas No: ' num2str(handles.alreadyCaptured)], ['Enlapsed: ' enlapsed]});
        end
        
        
        splitDate(rows,:) = strsplit(char(datePoints(rows)),' ' );
        splitPrim(rows,:) = strsplit(char(data(rows,1)),'M' );
        splitSeco(rows,:) = strsplit(char(data(rows,2)),'O' );
        
        divideUnitsSeco = isstrprop(char(data(rows,2)),'digit');
        positions = find(divideUnitsSeco);
        unitsTemp(rows,1) = extractAfter(data(rows,2),max(positions));
        
        u = unitsTemp;
        unit = unitsTemp{1};
        
        datum = str2double(cell2mat(splitPrim(rows,3)));
        
        dataBuf(indexDatum,1) = datum;
        
        avgBuf(indexAvg,1) = mean(dataBuf);
        
        if ~isempty(unit)
            
            chrSplit = char(unit(1,1));
            splitValandUnits(rows,:) = strsplit(char(splitSeco(rows,2)),chrSplit);
            
        else
            
            splitValandUnits = splitSeco(:,2);
            
        end
        
        set(handles.capturedList, 'String', {data{rows,1}, data{rows,2}} )
        
        %% Live Plot Routine
        
        if rows < bufSize + bufSize/2
            cleanDataMain(rows,1) = datum;
            addpoints(lineMain, timePoints(rows), datum);
            messageACQ{rows,1,handles.alreadyCaptured} = {'Stabilization data: before MEDIAN'};
        else
            cleanDatum = median(avgBuf);
            cleanDataMain(rows,1) = cleanDatum;
            addpoints(lineMain, timePoints(rows), cleanDatum);
            messageACQ{rows,1,handles.alreadyCaptured} = {'Stable data: after MEDIAN'};
        end
        
        ylabel(strcat({'Primary Unit:'},{' '},{char(u{rows})}));
        grid on;
        grid minor;
        datetick('x','keeplimits')
        refreshdata(lineMain);
        drawnow limitrate
        
    end
    
    if isequal(col,2)
        col = 1;
        rows = rows + 1;
        
        if indexDatum > bufSize-1
            indexDatum = 1;
        else
            indexDatum = indexDatum + 1;
        end
        
        if indexAvg > bufSize/2-1
            indexAvg = 1;
        else
            indexAvg = indexAvg + 1;
        end
        
    else
        if strcmp(data{rows, col}, 'Empty buffer')
            disp("Empty buffer found!")
        else
            col = col + 1;
        end
    end
    set(handles.statusBox,'BackgroundColor', [0.3 0.3 0.3]);
    
end



flushinput(handles.LCR)
measureHoldCOM(handles.LCR);

set(handles.stopButton,'BackgroundColor', [0.94 0.94 0.94]);

capturedData = cell(rows, 7); % ren has one more dimension after the last increment

mode = get(handles.modeListBox, 'Value');

switch mode
    
    case 1
        capturedData(1, 1:6) = {'Date','Timestamp','Resistance', 'Units','Quality factor','Notes', 'Test Frequency'};
        unitsRes = unitsTemp{1};
        
        if isempty(unitsRes)
            for i =1:rows-1
                unitsTemp(i,1) = {'Ohms'};
            end
        else
            
            unitsRes = char(unitsTemp{1});
            
            if isequal(unitsRes, 'k')
                for i =1:rows-1
                    unitsTemp(i,1) = {'kOhms'};
                end
            end
        end
    case 2
        capturedData(1, 1:7) = {'Date','Timestamp','Capacitance', 'Units','Dissipation','Notes', 'Test Frequency'};
    case 3
        capturedData(1, 1:7) = {'Date','Timestamp','Capacitance', 'Units','Resistance','Notes', 'Test Frequency'};
    case 4
        capturedData(1, 1:7) = {'Date','Timestamp','Inductance', 'Units','Quality factor','Notes', 'Test Frequency'};
    otherwise
        
end

flushinput(handles.LCR);
capturedData(2:end,1:2) = cellstr(splitDate);
capturedData(2:end,3) = cellstr(num2str(cleanDataMain)); %splitPrim(:,3);
capturedData(2:end,4) = unitsTemp;
capturedData(2:end,5) = splitValandUnits(:,1);
capturedData(2:bufSize + bufSize/2,6) =  messageACQ{1:bufSize + bufSize/2,1,handles.alreadyCaptured};
capturedData(bufSize + bufSize/2+1:end,6) =  messageACQ{bufSize + bufSize/2+1:end,1,handles.alreadyCaptured};
capturedData(2,7) = cellstr(handles.testFreq);
% capturedData
% messageACQ

set(handles.engageButton,'Enable', 'on');
set(handles.console, 'String', 'Data table loaded in memory. Ready to SAVE');
set(handles.startButton, 'Enable', 'on')
end