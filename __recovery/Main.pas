unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, PaintGrid,
  Vcl.StdCtrls, colorsUnit, mediaClass, System.Generics.Collections, math,
  Vcl.ComCtrls, Vcl.ToolWin, System.ImageList, Vcl.ImgList;

type
  TForm1 = class(TForm)
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    pg: TPaintGrid;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ScrollBox1: TScrollBox;
    ImageList1: TImageList;
    legacy: TCheckBox;
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
  public
    //FcolorCont: TList<TColor>;
  end;

var
  Form1: TForm1;

implementation
uses initunit;
{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  pg.DrawFromMap;
end;

procedure TForm1.Button2Click(Sender: TObject);
var saver: TBitmap;
begin
  saver:=Tbitmap.Create(pg.width, pg.Height);
  saver.Canvas.CopyRect(rect(0,0,pg.Width,pg.Height),pg.Canvas,rect(0,0,pg.Width,pg.Height));
  saver.SaveToFile('picture.bmp');
end;

procedure TForm1.Button3Click(Sender: TObject);
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

procedure TForm1.Button4Click(Sender: TObject);
var mediana: TMediaSplit;
    //w: word;
begin
     //w:= 2 shl ();
    if legacy.Checked then
      mediana:=TMediaSplit.create(map,initform.ColorCount.ItemIndex+2,[koef])
    else
      mediana:=TMediaSplit.create(map,initform.ColorCount.ItemIndex+2,[]);
    for var i := 0 to pg.RowCount-1 do
      for var j := 0 to pg.ColCount-1 do
        pg.ColorMap[i,j]:=mediana.map[i,j];
    //initForm.th.Quantor;

    pg.DrawFromMap;
    mediana.Destroy;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  setlength(map, pg.RowCount, pg.ColCount);
    for var i := 0 to pg.RowCount-1 do
      for var j := 0 to pg.ColCount-1 do
        map[i,j]:=pg.ColorMap[i,j];
  pg.DrawFromMap;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  initform.show;
end;

procedure TForm1.pgDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
  State: TGridDrawState);
begin
  pg.Canvas.Brush.Color:=pg.ColorMap[ARow, ACol];
  pg.Canvas.Rectangle(Rect);
end;

end.
