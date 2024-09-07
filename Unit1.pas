unit Unit1;

interface

implementation
type TMap = array of array of TColor;

                Tcell = record

                               R,G,B,I,J: Byte;

                end;

function preparation(AMap: TMap): array of Tcell;

                               i, j: word;

                               cell: Tcell;

                begin

                               setlenght(result, i*j);

                               for i:=0 to High(AMap) do

                               for j:=0 to High(AMap[i]) do

                               begin

                                               splitCol(AMap[i,j],cell.R, cell.G, cell.B);

                                               cell.i:=i; cell.j:=j;

                                               result[High(AMap)*i+j]:=cell;

                                               //splitCol(AMap[i,j],result[High(AMap)*i+j].R,)

                               end;

                end;

procedure SortCube(var Cube: array of Tcell)

var maxR, minR, maxG, minG, maxB, minB: Byte;

procedure sortIns ()

var i, j: word; key:cell;

begin

                for j:= 2 to length(cube)-1 do

                begin

                               key:=cube[j];

                               i:=j-1;

                               while (i>=0 and cube[j].R>key.R) do

                               begin

                                               cube[i+1]:=cube[i];

                                               dec(i);

                               end;

                               cube[i+1]:=key

                end;

end;



begin

                maxR:=cube[0].R; maxB:=cube[0].B; maxG:=cube[0].G;

                minR:=cube[0].R; minB:=cube[0].B; minG:=cube[0].G;

                for var i:=low(Cube) to High(Cube) do

                begin

                               if maxR>Cube[i].R then maxR:=Cube[i].R;

                               if maxG>Cube[i].G then maxG:=Cube[i].G;

                               if maxB>Cube[i].B then maxB:=Cube[i].B;

                               if minB<Cube[i].B then minB:=Cube[i].B;

                               if minG<Cube[i].G then minG:=Cube[i].G;

                               if minR<Cube[i].R then minR:=Cube[i].R;

                end;

                if (maxR-minR)>=(maxG-minG) and (maxR-minR)>=(maxB-minB) then sortIns(R) else

                if (maxG-minG)>=(maxR-minR) and (maxG-minG)>=(maxB-minB) then sortIns(G) else

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
