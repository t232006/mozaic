unit MediaClass;

interface
uses  Graphics, winapi.Windows;
type
TMap = array of array of TColor;
Tcell = packed record
R,G,B,I,J: Byte;
end;
Tarr=array of Tcell;
TMediaSplit = class
  private
  Cubes: array of array of Tcell;
  Fmap: TMap;
  mr: array[byte] of word;
  mg: array[byte] of word;
  mb: array[byte] of word;
  //function preparation(AMap: TMap): Tarr;
  //function splitCol(AColor: Tcolor): Tcell;
  procedure SortCube(var Cube: Tarr);
  function MakeMiddle(miniCube: Tarr):TCell;
  procedure MakePallete(Cube: Tarr; deep: byte);
  public
  property map: TMap read FMap;
  constructor create(Amap: TMap; deep: byte);
end;

implementation

constructor TMediaSplit.create(Amap: TMap; deep: byte);
var cu: TArr; k:integer;
    vRGB: longint;
begin
     Fmap:=Amap;
     k:=0;
     setlength(Cu, length(Amap)*length(Amap[0]));
     {for k := 0 to 255 do
     begin
        mr[k]:=0; mg[k]:=0; mb[k]:=0;
     end;       }
     k:=0;
     for var i := Low(Fmap) to High(Fmap) do
     for var j := Low(fMap[i]) to High(Fmap[i]) do
       begin
        vRGB:=Fmap[i,j];
        Cu[k].R:=vRGB and 255;
        inc(mr[Cu[k].R]);
        Cu[k].G:=vRGB shr 8 and 255;
        inc(mg[Cu[k].G]);
        Cu[k].B:=vRGB shr 16 and 255;
        inc(mb[Cu[k].B]);
        Cu[k].I:=i;
        Cu[k].J:=j;
        inc(k);
       end;
     MakePallete(Cu, deep);

end;

{function TMediaSplit.splitCol(AColor: Tcolor): Tcell;
var vRGB: longint;
begin
  vRGB:=ColorToRGB(AColor);
  result.R:=vRGB and 255;
  result.G:=vRGB shr 8 and 255;
  result.B:=vRGB shr 16 and 255;
end;

{function TMediaSplit.preparation(AMap: TMap): Tarr;
var i, j: word;
cell: Tcell;
begin
  setlength(result, i*j);
  for i:=0 to High(AMap) do
  for j:=0 to High(AMap[i]) do
  begin
    splitCol(AMap[i,j], cell);
    cell.i:=i; cell.j:=j;
    result[High(AMap)*i+j]:=cell;
                                               //splitCol(AMap[i,j],result[High(AMap)*i+j].R,)
  end;
end;}

procedure TMediaSplit.SortCube(var Cube: Tarr);
var max, min: TCell;
procedure sortIns (offset:integer);
function getVal(v:TCell):byte;
var a:^byte;
begin
    a:=@v;
    inc(a, offset);
    result:=Pbyte(a)^;
end;
var i, j: integer; key:TCell;
begin
    for j:= 1 to length(cube)-1 do
    begin

         key:=cube[j];
         i:=j-1;
         while ((i>=0) and (getVal(cube[i])>getVal(key))) do
         begin
             cube[i+1]:=cube[i];
             dec(i);
         end;
         cube[i+1]:=key
    end;
end;

begin
    max.R:=cube[0].R; max.B:=cube[0].B; max.G:=cube[0].G;
    min.R:=cube[0].R; min.B:=cube[0].B; min.G:=cube[0].G;
    for var i:=low(Cube) to High(Cube) do
    begin
       if max.R<Cube[i].R then max.R:=Cube[i].R;
       if max.G<Cube[i].G then max.G:=Cube[i].G;
       if max.B<Cube[i].B then max.B:=Cube[i].B;
       if min.B>Cube[i].B then min.B:=Cube[i].B;
       if min.G>Cube[i].G then min.G:=Cube[i].G;
       if min.R>Cube[i].R then min.R:=Cube[i].R;
    end;
    if (((max.R-min.R)>=(max.G-min.G)) and ((max.R-min.R)>=(max.B-min.B))) then sortIns(0) else
    if (((max.G-min.G)>=(max.R-min.R)) and ((max.G-min.G)>=(max.B-min.B))) then sortIns(1) else
    sortIns(2);

end;


function TMediaSplit.MakeMiddle(miniCube: TArr):TCell;
var sr,sg,sb: integer;  i:byte;
    total: longint;
begin
    sr:=0; sg:=0; sb:=0; //total:=0;
    for i:=low(minicube) to high(minicube) do
    begin
       {sr:=sr+miniCube[i].r*mr[minicube[i].r];
       sg:=sg+miniCube[i].g*mg[minicube[i].g];
       sb:=sb+minicube[i].b*mb[minicube[i].b];
       total:=total+mr[minicube[i].r]+mg[minicube[i].g]+mb[minicube[i].b]; }
       sr:=sr+miniCube[i].R; sg:=sg+minicube[i].G; sb:=sb+minicube[i].B;
    end;
    result.r:=sr div (high(minicube)+1);
    result.g:=sg div (high(minicube)+1);
    result.b:=sb div (high(minicube)+1);
end;

procedure TMediaSplit.MakePallete(Cube: tArr; deep: byte);
    var arr1, arr2: TArr; cell: Tcell;
    i:word;
    begin
       if deep>0 then
       begin
           if length(cube) mod 2 = 0 then
                           setlength(arr2, length(cube) div 2)
           else
                           setlength(arr2, (length(cube) div 2)+1);
           setlength(arr1, length(cube) div 2);
           sortCube(Cube);
           for i:=0 to (length(cube) div 2)-1 do
                           arr1[i]:=cube[i];
           for i:=i to length(cube)-1 do
                           arr2[i-length(arr1)]:=cube[i];
           MakePallete(arr1, deep-1);
           MakePallete(arr2, deep-1);
       end else
       begin
           for i:=0 to high(cube) do
           begin
             cell:=MakeMiddle(Cube);
             FMap[cube[i].i, cube[i].j]:=RGB(cell.R, cell.G, cell.B);
           end;
       end;
    end;
{begin
  MakePallete(preparation(Map),6);
end;}
end.
