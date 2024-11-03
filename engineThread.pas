unit engineThread;

interface

uses Windows, Graphics, classes, math, dialogs,
System.Generics.Collections, comctrls, winapi.Messages, MediaClass;

const PROC=1;
//nst wmaddproc=wm_user+123+$10;
type
TMap=array of array of TColor;

  Tengine = class
  private
    fColCount, fRowCount, fColorCount: integer;
    fPicture: TBitmap;
    fPicImage: array of array of TColor;
    fMap: TMap;
    fbar: TProgressBar;
    FColCont: TList<TColor>;
    Fpool: 0..proc;
    FFinish: boolean;
    FOnFinish: TNotifyEvent;
    //fMediana: TMediaSplit;
    procedure startMap;
    //function Quantor(num, min, max, colorcount: integer):integer;
    procedure GetMap(Sender: TObject); //<==starts when thread terminates
  public
    property OnFinish: TNotifyEvent read FOnFinish write FOnFinish;
    //procedure Quantor;
    constructor create(Picture: TBitmap; ColCount, RowCount,
    colorCount: integer; var bar: TProgressbar);
    destructor destroy;
    property Map: TMap read fMap;
    property ColorConteiner: TList<Tcolor> read FColCont;


  end;

implementation
uses Initunit, MiniThread;
var
miniTh: array [1..PROC] of TMiniTh;
    k:byte;
{ TengineTh }

procedure Tengine.GetMap(Sender: TObject);
var AMap: TMap;
    i,j, R, G, B,
    Rmax, Rmin, Gmax, Gmin, Bmax, Bmin:integer;
    vRGB: longint;
    k: byte;

procedure ColorSplit(c: Tcolor);
begin
  vRGB:=c;
       R:=GetRValue(vRGB);
       G:=GetGValue(vRGB);
       B:=GetBValue(vRGB);
end;

begin
  inc(FPool);
  if FPool<PROC then exit;
  SetLength(AMap, fRowCount,fColCount);
  for k := 1 to proc do
    for I := (High(minith[k].map) div PROC)*(k-1) to (High(minith[k].map) div PROC)*k do
    for j := 0 to High(minith[k].Map[i]) do
       AMap[i,j]:=Minith[k].map[i,j];



  for I := 0 to FRowCount-1 do
  for j := 0 to FcolCount-1 do
  begin
    Rmax:=GetRValue(ColorToRGB(AMap[0,0]));
    Gmax:=GetGValue(ColorToRGB(AMap[0,0]));
    Bmax:=GetBValue(ColorToRGB(AMap[0,0]));
    Rmin:=Rmax; Gmin:=Gmax; Bmin:=Bmax;
     ColorSplit(AMap[i,j]);
     if R>Rmax then Rmax:=R;
     if R<Rmin then Rmin:=R;
     if G>Gmax then Gmax:=G;
     if G<Gmin then Gmin:=G;
     if B>Bmax then Bmax:=B;
     if B<Bmin then Bmin:=B;
  end;


  for I := 0 to fRowCount-1 do
  for j := 0 to fColCount-1 do
  begin
    if not(FColcont.Contains(AMap[i,j])) then FColCont.Add(AMap[i,j]);
  end;
    fmap:=AMap;
    if assigned(FOnFinish) then FOnFinish(self);
    //initform.ProgrBar.Position:=initform.ProgrBar.Position;

end;

{procedure Tengine.Quantor;
var Mediana: TMediaSplit;
begin
  Mediana:=TMediaSplit.create(fMap,fcolorCount);
  for var i := 0 to pg.RowCount-1 do
      for var j := 0 to pg.ColCount-1 do
        fMap[i,j]:=mediana.map[i,j];
  Mediana.free;
end;        }

constructor Tengine.create(Picture: TBitmap; ColCount, RowCount,
  colorCount: integer; var bar: TProgressBar);
begin
   //inherited Create(false);
   fpicture:=Picture;
   fcolcount:=colcount;
   frowcount:=rowcount;
   fcolorCount:=colorCount;
   fcolCont:=TList<Tcolor>.Create;
   //OnTerminate:=ATermProc;
   fbar:=bar;
   fPool:=0;
   startMap; //<== start
end;

destructor Tengine.destroy;
begin
  fColCont.Destroy;
end;

procedure Tengine.startMap;
begin
  if ((FPicture.Width div fColCount=0) or (FPicture.Height div fRowCount=0)) then
  begin
    showmessage('Too small picture!');
    exit;
  end;
  //===============
  fBar.Max:=frowCount;
  //===============

  for k := 1 to PROC do    //threads starts immidiatelly
    minith[k]:=TMinith.create(Fpicture, fColcount, frowCount, fbar,
    k, GetMap);
end;

{function Tengine.Quantor(num, min, max, colorcount: integer): integer;
var koef:integer;   cut:byte;
begin
  koef:=(max-min) div colorcount;
  cut:=1;
  if koef>0 then
    cut:=floor((num-min)/koef);
  if cut=0 then cut:=1;
  result:=min+cut*koef-(koef div 2);
end;}

end.
