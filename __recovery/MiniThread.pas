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
     procedure GetMap22;
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

end;

procedure TminiTh.Execute;
begin
  self.getmap22;
end;

procedure TminiTh.GetMap22;
var
  i,j, xx: integer;
  MyRect: TBitmap;
  WCoef, HCoef, u, v: word;
  sR, sG, sB, vRGB: longint;
  pb: pbytearray;
begin
  //fthnum := 1;
  SetLength(FMap, fRowCount div PROC, fColCount);
  //FPicture.SaveToFile('pic.bmp');  <==5)
  WCoef := fPicture.Width div fColCount;
  HCoef := fPicture.Height div fRowCount;
  fpicture.PixelFormat:=pf24bit;
  {myRect := TBitmap.Create;
  myRect.Width  := WCoef;
  myRect.Height := HCoef;  }
  for I := 0 to fRowCount-1 do
  begin
    for j := 0 to fColCount-1 do
    begin
      sR:=0; sG:=0; sB:=0;
      for u := i*Hcoef to (i+1)*Hcoef-1 do
      begin
        pb := fPicture.ScanLine[u];
        for v := j*Wcoef to (j+1)*Wcoef-1 do // Тут надо границы проверить, чтобы точно не выходили за пределы картинки
        begin
          xx := v*3;
          Inc(sB, pb[xx  ]); // Здесь надо проверить, действительно ли берутся правильные цвета
          Inc(sG, pb[xx+1]);
          Inc(sR, pb[xx+2]);
         end;
      end;
      FMap[i,j]:=RGB(sr div (Wcoef*Hcoef), sg div (Wcoef*Hcoef), sb div (Wcoef*Hcoef));
    end;
    Synchronize(IncBar);
  end;
end;

procedure TminiTh.GetMap;
var i,j:integer;       l:TColor;
  WCoef, HCoef, u, v: word;
  rowStart, rowFinish: word;
   sR, sG, sB, vRGB, R, G, B: longint;
   myRect: TBitmap;
begin
  rowStart:=(fRowCount div proc) * (fthnum-1);
  rowFinish:=(fRowCount div proc) * fthnum;
  SetLength(FMap, fRowCount, fColCount);
  //myRect:=TBitmap.Create(WCoef, HCoef);
  //FPicture.SaveToFile('pic.bmp');
  WCoef:=FPicture.Width div fColCount;
  HCoef:=FPicture.Height div fRowCount;
  Fpicture.Canvas.Lock;
  for I := RowStart to RowFinish-1 do
  begin
    for j := 0 to fColCount-1 do
      begin
         {myRect.Canvas.Lock;
         myRect.Canvas.CopyRect(Rect(0,0,myRect.Width,MyRect.Height),
                                FPicture.Canvas,
                                Rect(j*Wcoef,i*Hcoef,(j+1)*Wcoef,(i+1)*Hcoef  ));
         myRect.Canvas.Unlock;}
         sR:=0; sG:=0; sB:=0;
         //myRect.SaveToFile('f'+inttostr(i)+inttostr(j)+'.bmp');
         for u := i*Hcoef to (i+1)*Hcoef-1 do
         for v := j*Wcoef to (j+1)*Wcoef-1 do
         begin
            vRGB:=ColorToRGB(fPicture.Canvas.Pixels[v,u]);  //<--1) fPicture.Canvas.Pixels[i,j]=-1
            R:= GetRValue(vRGB); G:=GetGValue(vRGB); B:=GetBValue(vRGB);
            inc(sR, R);
            inc(sG, G);
            inc(sB, B);
         end;
         //FPicture.SaveToFile('pic.bmp');    //<== 4)
        FMap[i,j]:=RGB(sr div (Wcoef*Hcoef), sg div (Wcoef*Hcoef), sb div (Wcoef*Hcoef));
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