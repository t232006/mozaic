unit extention;

interface
uses windows, sysutils;

implementation
function GpegSize(var Size: TPoint; FileName: String): Boolean;
var Handle: Integer;
    xOk: Boolean;
    Buffer: array [0..1] of Byte;
begin
  Result:=False;
  Handle:=FileOpen(FileName,fmOpenRead	or fmShareDenyNone);
  if Handle<0 then Exit;
  try
    if FileSeek(Handle,2,0)<0 then Exit;
    xOk:=False;
    repeat
      if FileRead(Handle,Buffer,2)<>2 then Exit;
      if Buffer[0]<>$FF then Exit;
      xOk:=Buffer[1]=$C0;
      if not xOk then begin
        if Buffer[1]=$D9 then Exit;
        if FileRead(Handle,Buffer,2)<>2 then Exit;
        if FileSeek(Handle,Buffer[0]*256+Buffer[1]-2,1)<0 then Exit;
      end;
    until xOk;
    if FileSeek(Handle,3,1)<0 then Exit;
    if FileRead(Handle,Buffer,2)<>2 then Exit;
    Size.Y:=Buffer[0]*256+Buffer[1];
    if FileRead(Handle,Buffer,2)<>2 then Exit;
    Size.X:=Buffer[0]*256+Buffer[1];
    Result:=True;
  finally
    FileClose(Handle);
  end;
end;


end.
