function RawSerial  = getValues(oscDAQ, serialBufferSize)
%  RawSerial = char(fread(oscDAQ, serialBufferSize))';
RawSerial = fgetl(oscDAQ);
end