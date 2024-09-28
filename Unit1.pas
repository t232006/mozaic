unit Unit1;

interface
uses graphics;
type
TMap = array of array of TColor;
Tcell = packed record
R,G,B,I,J: Byte;
end;
Tarr=array of Tcell;
TMediaSplit = class
  function preparation(AMap: TMap): Tarr;
  procedure splitCol(AColor: Tcolor; var R:byte; var G:byte; var B: byte);
  procedure SortCube(var Cube: Tarr);
end;

implementation

procedure TMediaSplit.splitCol(AColor: Tcolor; var R:byte; var G:byte; var B: byte);
var vRGB: longint;
begin
  vRGB:=ColorToRGB(AColor);
  R:=vRGB and 7;
  G:=vRGB shr 8 and 7;
  B:=vRGB shr 16 and 7;
end;

function TMediaSplit.preparation(AMap: TMap): Tarr;
var i, j: word;
cell: Tcell;
begin
  setlength(result, i*j);
  for i:=0 to High(AMap) do
  for j:=0 to High(AMap[i]) do
  begin
    splitCol(AMap[i,j], cell.R, cell.G, cell.B);
    cell.i:=i; cell.j:=j;
    result[High(AMap)*i+j]:=cell;
                                               //splitCol(AMap[i,j],result[High(AMap)*i+j].R,)
  end;
end;

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
var i, j: word; key:TCell;
begin
    for j:= 2 to length(cube)-1 do
    begin

         key:=cube[j];
         i:=j-1;
         while ((i>=0) and (getVal(cube[j])>getVal(key))) do
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
       if max.R>Cube[i].R then max.R:=Cube[i].R;
       if max.G>Cube[i].G then max.G:=Cube[i].G;
       if max.B>Cube[i].B then max.B:=Cube[i].B;
       if min.B<Cube[i].B then min.B:=Cube[i].B;
       if min.G<Cube[i].G then min.G:=Cube[i].G;
       if min.R<Cube[i].R then min.R:=Cube[i].R;
    end;
    if (((max.R-min.R)>=(max.G-min.G)) and ((max.R-min.R)>=(max.B-min.B))) then sortIns(R) else
    if (max.G-min.G)>=(max.R-min.R) and (max.G-min.G)>=(max.B-min.B) then sortIns(G) else
    sortIns(B);

end;

var Cubes: array of array of Tcell;
function MakeMiddle(miniCube: array of TCell):TCell;
var sr,sg,sb: integer;
    mr:array[byte] of longint;
    mg:array[byte] of longint;
    mb:array[byte] of longint;
begin
    sr:=0; sg:=0; sb:=0;
    for var i:=0 to 255 do
    begin
      mr[i]:=0; mg:=0; mb:=0;
    end;
    for var i:=low(mincube) to high(minicube) do
    begin
       inc(mr[minicube[i].r]);
       inc(mr[minicube[i].g]);
       inc(mr[minicube[i].b]);
    end;
    for var i:=low(mincube) to high(minicube) do
    begin
       sr:=sr+miniCube[i].r*mr[minicube[i].r];
       sg:=sg+miniCube[i].g*mr[minicube[i].g];
       sb:=sb+minicube[i].b*mr[minicube[i].b];
    end;
    result.r:=sr div mr[minicube[i].r];
    result.g:=sg div mr[minicube[i].g];
    result.b:=sb div mr[minicube[i].b];
end;

procedure MakePallete(Cube: array of Tcell, deep: byte);
    var arr1, arr2: array of Tcell;
    i:word;
    begin
       if deep>0 then
       begin
           if length(cube) mod 2 = 0 then
                           setlenght(arr2, length(cube) div 2)
           else
                           setlenght(arr2, (length(cube) div 2)+1);
           setlength(arr1, length(cube) div 2);
           sortCube(Cube);
           for i:=0 to High(cube) div 2 do
                           arr1[i]:=cube[i];
           for i:=i to high(cube) do
                           arr2[i]:=cube[i];
           MakePallete(arr1, dec(deep));
           MakePallete(arr2, dec(deep));
       end else
       begin
           for i:=0 to high(cube) do
           AMap[cube[i].i, cube[i].j]:=RGBTocolor(MakeMiddle(Cube).R, MakeMiddle(Cube).G, MakeMiddle.B);
       end;
    end;
begin
  MakePallete(preparation(Map),6);
end;
end.
