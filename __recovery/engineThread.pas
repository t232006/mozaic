unit engineThread;

interface

uses Windows, Graphics, classes, math, dialogs,
System.Generics.Collections, comctrls, Forms;

const PROC=3;
type
TMap=array of array of TColor;



  TengineTh = class(TThread)
  private
    fColCount, fRowCount, fColorCount: integer;
    fPicture: TBitmap;
    threadNum: byte;
    fMap: TMap;
    fbar: TProgressBar;
    FColCont: TList<TColor>;
    procedure GetMap;
    function Quantor(num, min, max, colorcount: integer):integer;
  public
    constructor create(Picture: TBitmap; ColCount, RowCount,
    colorCount: integer; var bar: TProgressbar;
    ATermProc: TNotifyEvent);overload;
    destructor destroy;
    property Map: TMap read fMap;
    property ColorConteiner: TList<Tcolor> read FColCont;
  protected
     procedure Execute; override;
  end;

implementation
uses Initunit, MiniThread;
{ TengineTh }

constructor TengineTh.create(Picture: TBitmap; ColCount, RowCount,
  colorCount: integer; var bar: TProgressBar;
    ATermProc: TNotifyEvent);
begin
   inherited Create(false);
   fpicture:=Picture;
   fcolcount:=colcount;
   frowcount:=rowcount;
   fcolorCount:=colorCount;
   fcolCont:=TList<Tcolor>.Create;
   OnTerminate:=ATermProc;
   fbar:=bar;
end;

destructor TengineTh.destroy;
begin
  fColCont.Destroy;
end;

procedure TengineTh.Execute;
begin
   getmap;
end;

procedure TengineTh.GetMap;
var AMap: TMap;
    i,j, R, G, B,
    Rmax, Rmin, Gmax, Gmin, Bmax, Bmin:integer;
    vRGB: longint;
    miniTh: array [1..PROC] of TMiniTh;
    k:byte;
procedure ColorSplit(c: Tcolor);
begin
  vRGB:=c;
       R:=GetRValue(vRGB);
       G:=GetGValue(vRGB);
       B:=GetBValue(vRGB);
end;
begin
  SetLength(AMap, fRowCount,fColCount);

  if ((FPicture.Width div fColCount=0) or (FPicture.Height div fRowCount=0)) then
  begin
    showmessage('Too small picture!');
    exit;
  end;
  //===============
  fBar.Max:=frowCount;
  //===============
  for k := 1 to PROC do
    minith[k]:=TMinith.create(Fpicture, fColcount, frowCount, fbar, k);

  repeat
        Application.ProcessMessages;
  until minith[1].complete and minith[2].complete and minith[3].complete;

  for k := 1 to PROC do
    for I := 0 to High(minith[k].map) do
    for j := 0 to High(minith[k].Map[i]) do
       AMap[i*k,j]:=Minith[k].map[i,j];



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
       //================
       //initform.ProgrBar.Position:=k;
       //inc(k);
       //================

  for I := 0 to fRowCount-1 do
  for j := 0 to fColCount-1 do
  begin
    {ColorSplit(AMap[i,j]);
    AMap[i,j]:=RGB(Quantor(R, Rmin, rMax, fcolorcount),
                  Quantor(G, Gmin, GMax, fcolorcount),
                  Quantor(B, Bmin, BMax, fcolorcount));   }
    if not(FColcont.Contains(AMap[i,j])) then FColCont.Add(AMap[i,j]);

  end;
    fmap:=AMap;
    //initform.ProgrBar.Position:=initform.ProgrBar.Position;

end;

function TengineTh.Quantor(num, min, max, colorcount: integer): integer;
var koef:integer;   cut:byte;
begin
  koef:=(max-min) div colorcount;
  cut:=1;
  if koef>0 then
    cut:=floor((num-min)/koef);
  if cut=0 then cut:=1;
  result:=min+cut*koef-(koef div 2);
end;

{ TminiTh }



end.