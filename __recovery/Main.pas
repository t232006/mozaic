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
    ToolButton4: TToolButton;
    showColor: TToolButton;
    shapebut: TToolButton;
    digitdisign: TToolButton;
    PopupMenu2: TPopupMenu;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
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
    procedure showColorClick(Sender: TObject);
    procedure shapebutClick(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
  private
    map: TMap;
    l: TList<TColor>;
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
begin

    colorsform.pallete:=l;
    //printnumber;
    colorsform.show;
end;

procedure Tmosaic.Button4Click(Sender: TObject);
var mediana: TMediaSplit;
    //w: word;
begin
     l.Free; l:=TList<TColor>.Create;
    if legacy.Checked then

      mediana:=TMediaSplit.create(map,initform.ColorCount.ItemIndex+2,[koef]) else
      mediana:=TMediaSplit.create(map,initform.ColorCount.ItemIndex+2,[]);
    for var i := 0 to pg.RowCount-1 do
      for var j := 0 to pg.ColCount-1 do
        pg.ColorMap[i,j]:=mediana.map[i,j];
    //initForm.th.Quantor;

    pg.DrawFromMap;
    pg.Repaint;
    mediana.Destroy;
end;

procedure Tmosaic.FormActivate(Sender: TObject);
begin
  l.Free; l:=TList<TColor>.Create;
  setlength(map, pg.RowCount, pg.ColCount);
    for var i := 0 to pg.RowCount-1 do
      for var j := 0 to pg.ColCount-1 do
        map[i,j]:=pg.ColorMap[i,j];
  pg.DrawFromMap;
  //PrintNumber;
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

      filestream:=TFileStream.Create(opend.FileName,fmOpenRead);
      filestream.ReadBuffer(buf,4);  pg.ColCount:=buf;
      filestream.ReadBuffer(buf,4);  pg.RowCount:=buf;
      for var i := Low(pg.ColorMap) to High(pg.ColorMap) do
      for var j := Low(pg.ColorMap[i]) to High(pg.ColorMap[i]) do
       filestream.ReadBuffer(pg.ColorMap[i,j],sizeof(TColor));
      filestream.Free;
      pg.Repaint;
    end;
  end;

procedure Tmosaic.N4Click(Sender: TObject);
begin
  digitdisign.ImageIndex:=9;
  PopupMenu2.Tag:=1;
end;

procedure Tmosaic.N5Click(Sender: TObject);
begin
     digitdisign.ImageIndex:=10;
     PopupMenu2.Tag:=2;
end;

procedure Tmosaic.N6Click(Sender: TObject);
begin
    digitdisign.ImageIndex:=11;
    PopupMenu2.Tag:=3;
end;

procedure Tmosaic.pgDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
  State: TGridDrawState);
  var s: string;
begin
  if not(l.Contains(map[ARow,ACol])) then l.Add(map[ARow,ACol]);
  with pg.canvas do
  begin
    Brush.Color:=pg.ColorMap[ARow, ACol];
    Pen.Width:=1;
    Pen.Color:=clBlack;
    Rectangle(Rect );
    s:=inttostr(l.IndexOf(brush.Color));
    Font.Size:=8;
    font.Color:=ContrastColor(brush.Color);
    TextRect(rect,s,[]);
  end;

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

procedure Tmosaic.shapebutClick(Sender: TObject);
begin
  shapebut.Tag:=shapebut.Tag+1;
  if shapebut.tag mod 2 = 0 then shapebut.ImageIndex:=7 else
  shapebut.ImageIndex:=8;
  pg.Repaint;
end;

procedure Tmosaic.showColorClick(Sender: TObject);
begin
  showcolor.Tag:=showcolor.Tag+1;
  if showcolor.tag mod 2 = 0 then showcolor.ImageIndex:=6 else
  showcolor.ImageIndex:=1;
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
