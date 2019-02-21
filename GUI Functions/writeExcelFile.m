function writeExcelFile(handles)

[filename, pathname] = uiputfile('*.xlsx', 'Save excel file');

if isequal(filename,0)
    
    writeCancelledMsgBox = msgbox('User CANCELLED writing file operation....Good luck!', 'ATTENTION!','warn');
    pause(2.5)
    writeCancelledMsgBox.Visible = 'off';
    return
else
    sucess = xlswrite([pathname filename], handles.capturedData);
    
    if isequal(sucess,1)
       
       set(handles.console, 'String','Data matrix created and saved');
        system('taskkill /F /IM EXCEL.EXE');
        set(handles.txtName, 'String', filename)
    else
        
        set(handles.console, 'String', 'Operation failed. File opened. TRY AGAIN!')
    end
end
end