function response = readBufferCOM(dataPort)

    response = fscanf(dataPort,'%s');
	
	%response = fread(dataPort,get(dataPort,'BytesAvailable'))
    
    if isempty(response)
        response = 'Empty buffer';
    end

end
