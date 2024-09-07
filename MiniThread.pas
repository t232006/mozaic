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
     procedure GetMap;
     procedure IncBar;
  public
     property complete: boolean read fComplete;
     property Map: TMap read fMap;
     constructor create(Picture: TBitmap; ColCount, RowCount: integer;
     var bar: TProgressBar;
     thNum:byte;
     ATermProc: TNotifyEvent);overload;
  protected
     procedure Execute; override;

  end;

implementation
{ TminiTh }

constructor TminiTh.create(Picture: TBitmap;
ColCount, RowCount:integer; var bar: TprogressBar;
thnum:byte; ATermProc: TNotifyEvent);
begin
  inherited Create(false);
  fPicture:=Picture;
  fColcount:=Colcount;
  frowcount:=RowCount;
  fthnum:=thnum;
  fcomplete:=false;
  fbar:=bar;
  OnTerminate:=ATermProc;
end;

procedure TminiTh.Execute;
begin
  self.getmap;
end;

procedure TminiTh.GetMap;
var i,j:integer;
 MyRect:TBitmap;
  WCoef, HCoef, u, v: word;
   sR, sG, sB, vRGB: longint;
begin

  SetLength(FMap, fRowCount div PROC,fColCount);
  //FPicture.SaveToFile('pic.bmp');
  WCoef:=FPicture.Width div fColCount;
  HCoef:=FPicture.Height div fRowCount;
  myRect:=TBitmap.Create(WCoef, HCoef);
  for I := 0 to (fRowCount div PROC)*fthnum-1 do
  begin
    for j := 0 to fColCount-1 do
      begin
         myRect.Canvas.CopyRect(Rect(0,0,myRect.Width,MyRect.Height),
                                FPicture.Canvas,
                                Rect(j*Wcoef,i*Hcoef,(j+1)*Wcoef,(i+1)*Hcoef  ));
         sR:=0; sG:=0; sB:=0;
         myRect.SaveToFile('f'+inttostr(i)+inttostr(j)+'.bmp');
         for u := 0 to myRect.Height-1 do
         for v := 0 to Myrect.Width-1 do
         begin
            vRGB:=ColorToRGB(MyRect.Canvas.Pixels[v,u]);
            inc(sR,GetRValue(vRGB));
            inc(sG,GetGValue(vRGB));
            inc(sB,GetBValue(vRGB));
         end;
        FMap[i,j]:=RGB(sr div (u*v), sg div (u*v), sb div (u*v));

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
