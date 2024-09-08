unit MiniThread;

interface

uses Windows, Graphics, classes, math, dialogs,
System.Generics.Collections, comctrls, engineThread, sysutils;

type
TminiTh = class(TThread)
     fPicture: TBitmap;
     fMap: TMap;
     fColCount, fRowCount: integer;
     FthNum: byte;
     fComplete: boolean;
     fbar: TProgressBar;
     fms: hwnd;
     procedure GetMap;
     procedure IncBar;
  public
     property complete: boolean read fComplete;
     property Map: TMap read fMap;
     constructor create(ms: hwnd; Picture: TBitmap; ColCount, RowCount: integer;
     var bar: TProgressBar;
     thNum:byte;
     ATermProc: TNotifyEvent);overload;
  protected
     procedure Execute; override;

  end;

implementation
{ TminiTh }

constructor TminiTh.create(ms: hwnd; Picture: TBitmap;
ColCount, RowCount:integer; var bar: TprogressBar;
thnum:byte; ATermProc: TNotifyEvent);
begin
  inherited Create(false);
  Picture.Canvas.Lock;
  fPicture:=TBitmap.Create(Picture.Width, Picture.Height);
  fPicture.Canvas.CopyRect(Rect(0,0,Picture.Width, Picture.Height),
  Picture.Canvas, Rect(0,0,Picture.Width, Picture.Height));
  Picture.Canvas.Unlock;
  fColcount:=Colcount;
  frowcount:=RowCount;
  fthnum:=thnum;
  fcomplete:=false;
  fbar:=bar;
  OnTerminate:=ATermProc;
  fms:= ms;
end;

procedure TminiTh.Execute;
begin
  self.getmap;
end;

procedure TminiTh.GetMap;
var i,j:integer;       l:TColor;
  WCoef, HCoef, u, v: word;
  rowStart, rowFinish: word;
   sR, sG, sB, vRGB: longint;
begin
  rowStart:=(fRowCount div proc) * (fthnum-1);
  rowFinish:=(fRowCount div proc) * fthnum;
  SetLength(FMap, fRowCount, fColCount);

  //FPicture.SaveToFile('pic.bmp');
  WCoef:=FPicture.Width div fColCount;
  HCoef:=FPicture.Height div fRowCount;
  Fpicture.Canvas.Lock;
  for I := RowStart to RowFinish-1 do
  begin
    for j := 0 to fColCount-1 do
      begin
         sR:=0; sG:=0; sB:=0;
         //myRect.SaveToFile('f'+inttostr(i)+inttostr(j)+'.bmp');
         for u := i*Hcoef to (i+1)*Hcoef-1 do
         for v := j*Wcoef to (j+1)*Wcoef-1 do
         begin
            vRGB:=ColorToRGB(fPicture.Canvas.Pixels[v,u]);
            inc(sR,GetRValue(vRGB));
            inc(sG,GetGValue(vRGB));
            inc(sB,GetBValue(vRGB));
         end;
        FMap[i,j]:=RGB(sr div (Hcoef*Wcoef), sg div (Hcoef*Wcoef), sb div (Hcoef*Wcoef));
      end;
     Synchronize(IncBar);
  end;
    //fcomplete:=true;
end;

procedure TminiTh.IncBar;
begin
   fbar.Position:=fbar.Position+1;
end;

end.
