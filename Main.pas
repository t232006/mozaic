unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, PaintGrid,
  Vcl.StdCtrls, colorsUnit, mediaClass, System.Generics.Collections, math,
  Vcl.ComCtrls, Vcl.ToolWin, System.ImageList, Vcl.ImgList, Vcl.Menus;

type
  Tmosaic = class(TForm)
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    ToolBar: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ScrollBox1: TScrollBox;
    ImageList1: TImageList;
    legacy: TCheckBox;
    pg: TPaintGrid;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    saveD: TSaveDialog;
    N3: TMenuItem;
    OpenD: TOpenDialog;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure pgDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
    procedure N2Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
  private
    map: TMap;
    function ContrastColor(AColor: TColor): TColor;
  public
    procedure SelectColor(color: TColor; unselect: boolean);
    procedure ChangeColor(newColor: TColor; oldColor: TColor);
  end;

var
  mosaic: Tmosaic;

implementation
uses initunit;
{$R *.dfm}

procedure Tmosaic.Button1Click(Sender: TObject);
begin
  pg.DrawFromMap;
end;

procedure Tmosaic.Button2Click(Sender: TObject);
var a:TPoint;
begin

   GetCursorPos(a);
  PopupMenu1.Popup(a.x,a.Y);

end;

procedure Tmosaic.Button3Click(Sender: TObject);
var pallette: array of TColor;
    l: TList<TColor>;
begin
    l:=TList<TColor>.Create;
    for var i := Low(map) to High(map) do
      for var j := Low(map[i]) to High(map[i]) do
          if not(l.Contains(map[i,j])) then l.Add(map[i,j]);
    colorsform.pallete:=l;
    colorsform.show;
end;

procedure Tmosaic.Button4Click(Sender: TObject);
var mediana: TMediaSplit;
    //w: word;
begin
     //w:= 2 shl ();
    if legacy.Checked then

      mediana:=TMediaSplit.create(map,initform.ColorCount.ItemIndex+2,[koef]) else
      mediana:=TMediaSplit.create(map,initform.ColorCount.ItemIndex+2,[]);
    for var i := 0 to pg.RowCount-1 do
      for var j := 0 to pg.ColCount-1 do
        pg.ColorMap[i,j]:=mediana.map[i,j];
    //initForm.th.Quantor;

    pg.DrawFromMap;
    mediana.Destroy;
end;

procedure Tmosaic.FormActivate(Sender: TObject);
begin
  setlength(map, pg.RowCount, pg.ColCount);
    for var i := 0 to pg.RowCount-1 do
      for var j := 0 to pg.ColCount-1 do
        map[i,j]:=pg.ColorMap[i,j];
  pg.DrawFromMap;
end;

procedure Tmosaic.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  initform.show;
end;

procedure Tmosaic.N1Click(Sender: TObject);
var //memstream: TMemoryStream;
    filestream: TfileStream;
begin
  if saved.Execute then
  begin
      filestream:=TFileStream.Create(saved.FileName+'.moz',fmcreate);
      filestream.Write(pg.ColCount,sizeof(integer));
      filestream.Write(pg.RowCount,sizeof(integer));
      for var i := Low(pg.ColorMap) to High(pg.ColorMap) do
      for var j := Low(pg.ColorMap[i]) to High(pg.ColorMap[i]) do
       filestream.Write(pg.ColorMap[i,j],sizeof(TColor));
      filestream.Free;
  end;
end;

procedure Tmosaic.N2Click(Sender: TObject);
    var saver: TBitmap;
begin
  saver:=Tbitmap.Create(pg.width, pg.Height);
  saver.Canvas.CopyRect(rect(0,0,pg.Width,pg.Height),pg.Canvas,rect(0,0,pg.Width,pg.Height));
  saver.SaveToFile('picture.bmp');
end;

procedure Tmosaic.N3Click(Sender: TObject);
var filestream: TFileStream;
    buf:integer;
    begin
    if opend.Execute() then
    begin

      filestream:=TFileStream.Create(saved.FileName,fmOpenRead);
      filestream.ReadBuffer(buf,4);  pg.ColCount:=buf;
      filestream.ReadBuffer(buf,4);  pg.RowCount:=buf;
      for var i := Low(pg.ColorMap) to High(pg.ColorMap) do
      for var j := Low(pg.ColorMap[i]) to High(pg.ColorMap[i]) do
       filestream.ReadBuffer(pg.ColorMap[i,j],sizeof(TColor));
      filestream.Free;
      pg.Repaint;
    end;
  end;

procedure Tmosaic.pgDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
  State: TGridDrawState);
begin
  pg.Canvas.Brush.Color:=pg.ColorMap[ARow, ACol];
  pg.Canvas.Pen.Width:=1;
  pg.Canvas.Pen.Color:=clBlack;
  pg.Canvas.Rectangle(Rect );
end;

procedure Tmosaic.SelectColor(color: TColor; unselect: boolean);
begin

  pg.Canvas.Brush.Color:=color;

  for var i := 0 to High(pg.ColorMap) do
    for var j := 0 to High(pg.ColorMap[i]) do
        if pg.ColorMap[i,j]=color then
        with pg.Canvas do
        begin
          if unselect then
          begin
            Pen.Width:=2;
            Pen.Color:=pg.Color;
            Rectangle(pg.CellRect(j,i));
            Pen.Width:=1;
            Pen.Color:=0;
          end
          else
          begin
            Pen.Width:=2;
            Pen.Color:=ContrastColor(color);
          end;

          Rectangle(pg.CellRect(j,i));
        end;
end;

procedure Tmosaic.ChangeColor(newColor, oldColor: TColor);
begin
  pg.Canvas.Brush.Color:=Newcolor;
  for var i := 0 to High(pg.ColorMap) do
    for var j := 0 to High(pg.ColorMap[i]) do
        if pg.ColorMap[i,j]=oldcolor then
        begin
          pg.ColorMap[i,j]:=newcolor;
        end;
end;

function Tmosaic.ContrastColor(AColor: TColor): TColor;
const TolerSq = 16 * 16;
begin
 if Sqr(GetRValue(AColor) - $80) + Sqr(GetGValue(AColor) - $80)
  + Sqr(GetBValue(AColor) - $80) < TolerSq then
  Result := (AColor + $7F7F7F) and $FFFFFF
 else
  Result := AColor xor $FFFFFF;
end;



end.
