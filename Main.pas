unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, PaintGrid,
  Vcl.StdCtrls, colorsUnit, mediaClass, System.Generics.Collections, math,
  Vcl.ComCtrls, Vcl.ToolWin, System.ImageList, Vcl.ImgList;

type
  Tmosaic = class(TForm)
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ScrollBox1: TScrollBox;
    ImageList1: TImageList;
    legacy: TCheckBox;
    pg: TPaintGrid;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure pgDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
  private
    map: TMap;
    function ContrastColor(AColor: TColor): TColor;
  public
    procedure SelectColor(color: TColor; unselect: boolean);
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
var saver: TBitmap;
begin
  saver:=Tbitmap.Create(pg.width, pg.Height);
  saver.Canvas.CopyRect(rect(0,0,pg.Width,pg.Height),pg.Canvas,rect(0,0,pg.Width,pg.Height));
  saver.SaveToFile('picture.bmp');
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
