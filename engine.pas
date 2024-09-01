unit engine;

interface
uses Windows, Graphics, classes, math, dialogs;
type
TMap=array of array of TColor;

  function GetMap(FPicture: TBitmap; ColCount, RowCount, colorCount: integer): TMap;
  function Quantor(num, min, max, colorcount: integer):integer;

implementation

function Quantor(num, min, max, colorcount: integer):integer;
var koef:integer;   cut:byte;
begin
  koef:=(max-min) div colorcount;
  cut:=1;
  if koef>0 then
    cut:=floor((num-min)/koef);
  if cut=0 then cut:=1;
  result:=min+cut*koef-(koef div 2);
end;

function GetMap(FPicture: TBitmap; ColCount, RowCount, colorCount: integer): TMap;
var Map: TMap;
    i,j, u, v, sR, sG, sB, R, G, B,
    Rmax, Rmin, Gmax, Gmin, Bmax, Bmin:integer;
    WCoef, HCoef: word;
    MyRect:TBitmap;
    vRGB: longint;

procedure ColorSplit(c: Tcolor);
begin
  vRGB:=Map[i,j];
       R:=GetRValue(vRGB);
       G:=GetGValue(vRGB);
       B:=GetBValue(vRGB);
end;
begin
  SetLength(Map, RowCount,ColCount);
  WCoef:=FPicture.Width div ColCount;
  HCoef:=FPicture.Height div RowCount;
  if ((Wcoef=0) or (hcoef=0)) then
  begin
    showmessage('Too small picture!');
    exit;
  end;
  myRect:=TBitmap.Create(WCoef, HCoef);
  Rmax:=GetRValue(ColorToRGB(myRect.Canvas.Pixels[0,0]));
  Gmax:=GetGValue(ColorToRGB(myRect.Canvas.Pixels[0,0]));
  Bmax:=GetBValue(ColorToRGB(myRect.Canvas.Pixels[0,0]));
  Rmin:=Rmax; Gmin:=Gmax; Bmin:=Bmax;

  for I := 0 to RowCount-1 do
  for j := 0 to ColCount-1 do
    begin
       myRect.Canvas.CopyRect(Rect(0,0,myRect.Width,MyRect.Height),
                              FPicture.Canvas,
                              Rect(i*Hcoef,j*Wcoef,(i+1)*Hcoef,  (j+1)*Wcoef));
       sR:=0; sG:=0; sB:=0;
       for u := 0 to myRect.Height-1 do
       for v := 0 to Myrect.Width-1 do
       begin
          vRGB:=ColorToRGB(MyRect.Canvas.Pixels[v,u]);
          inc(sR,GetRValue(vRGB));
          inc(sG,GetGValue(vRGB));
          inc(sB,GetBValue(vRGB));
       end;
       Map[i,j]:=RGB(sr div (u*v), sg div (u*v), sb div (u*v));
       ColorSplit(Map[i,j]);
       if R>Rmax then Rmax:=R;
       if R<Rmin then Rmin:=R;
       if G>Gmax then Gmax:=G;
       if G<Gmin then Gmin:=G;
       if B>Bmax then Bmax:=B;
       if B<Bmin then Bmin:=B;

    end;
  for I := 0 to RowCount-1 do
  for j := 0 to ColCount-1 do
  begin
    ColorSplit(Map[i,j]);
    Map[i,j]:=RGB(Quantor(R, Rmin, rMax, colorcount),
                  Quantor(G, Gmin, GMax, colorcount),
                  Quantor(B, Bmin, BMax, colorcount))
  end;
    result:=map;
end;

end.
