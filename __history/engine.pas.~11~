unit engine;

interface
uses Windows, Graphics, classes, math;
type
TMap=array of array of TColor;

  function GetMap(FPicture: TBitmap; ColCount, RowCount, colorCount: integer): TMap;
  function Quantor(num, min, max, colcount: integer):integer;

implementation


function Quantor(num, min, max, colcount: integer):integer;
var koef:integer;
begin
  koef:=(max-min) div colcount;
  if koef>0 then

  result:=min+floor((num-min)/koef)*koef-(koef div 2);
end;

function GetMap(FPicture: TBitmap; ColCount, RowCount, colorCount: integer): TMap;
var Map: TMap;
    i,j, u, v, sR, sG, sB, R, G, B,
    Rmax, Rmin, Gmax, Gmin, Bmax, Bmin:integer;
    WCoef, HCoef: word;
    MyRect:TBitmap;
    vRGB: longint;
begin
  SetLength(Map, ColCount, RowCount);
  WCoef:=FPicture.Width div ColCount;
  HCoef:=FPicture.Height div RowCount;
  myRect:=TBitmap.Create(WCoef, HCoef);
  for I := 0 to RowCount-1 do
  for j := 0 to ColCount-1 do
    begin
       myRect.Canvas.CopyRect(Rect(0,0,myRect.Width,myRect.Height),
                              FPicture.Canvas,
                              Rect(i*Wcoef,j*Hcoef,(i+1)*Wcoef, (j+1)*Hcoef));
       sR:=0; sG:=0; sB:=0;
       Rmax:=GetRValue(ColorToRGB(myRect.Canvas.Pixels[0,0]));
       Gmax:=GetGValue(ColorToRGB(myRect.Canvas.Pixels[0,0]));
       Bmax:=GetBValue(ColorToRGB(myRect.Canvas.Pixels[0,0]));
       Rmin:=Rmax; Gmin:=Gmax; Bmin:=Bmax;
       for u := 0 to myRect.Height-1 do
       for v := 0 to Myrect.Width-1 do
       begin
          vRGB:=ColorToRGB(MyRect.Canvas.Pixels[v,u]);
          R:=GetRValue(vRGB);
          G:=GetGValue(vRGB);
          B:=GetBValue(vRGB);
          if R>Rmax then Rmax:=R;
          if R<Rmin then Rmin:=R;
          if G>Rmax then Gmax:=G;
          if G<Rmin then Gmin:=G;
          if B>Rmax then Bmax:=B;
          if B<Rmin then Bmin:=B;
          inc(sR,R);
          inc(sG,G);
          inc(sB,B);
       end;
       Map[i,j]:=RGB(Quantor(sr div (u*v),rmin, rmax, colcount),
                      Quantor(sg div (u*v),gmin, gmax, colcount),
                      Quantor(sb div (u*v), bmin, bmax, colcount));


    end;
  result:=Map;
end;

end.
