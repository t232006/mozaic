unit PaintGrid;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Grids, messages,
  graphics, types, extctrls;

type
  TMyShape = (ARectangle, AEllipse);
  TPaintGrid = class(TDrawGrid)
  private
    pressed: boolean;
    FShape: TMyShape;
    //AColCount: LongInt;
    FCurCol: TColor;
    //FColWidth: Integer;
    //FRowHeight: Integer;
    //FOnChange: TNotifyEvent;
    //FShape: TMyShape;
    procedure SizeChanged(OldColCount, OldRowCount: Longint); override;
    procedure ToShape(const Value: TMyShape);
    procedure NewItems(oldRows, newRows, oldCols, newCols: integer);
  protected

    procedure MouseDown(var Msg: TMessage); overload; message WM_LBUTTONDOWN;
    procedure MouseUp(var Msg: TMessage); overload; message WM_LBUTTONUP;
    procedure MouseMove(var Msg: TMessage); overload; message WM_MOUSEMOVE;
    //procedure Activate (var Msg: TMessage); overload; message WM_ACTIVATE;
  public
    //property ColorMap: array of array of TColor read FColorMap write FColorMap;
    ColorMap: array of array of TColor;
    //property OnChange: TNotifyEvent read FOnChange write FOnChange;
    constructor Create(AOwner: TComponent); override;
    procedure DrawFromMap;
  published
    property currentColor: TColor read FCurCol write FCurCol default 0;
    property Shape: TMyShape read FShape write ToShape default ARectangle;
    property ColCount default 5;
    property RowCount default 5;
    property FixedRows default 0;
    property FixedCols default 0;
    property DefaultRowHeight default 12;
    property DefaultColWidth default 12;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Samples', [TPaintGrid]);
end;

{ TPaintGrid }

constructor TPaintGrid.Create(AOwner: TComponent);

begin
  inherited;
  FShape:=ARectangle;
  fixedCols:=0; fixedrows:=0;
  DefaultRowHeight:=12;
  DefaultColWidth:=12;
  Setlength(ColorMap, RowCount, ColCount);
  NewItems(0,RowCount, 0, ColCount);
  Width:=ColCount*(DefaultColWidth+1)+4;
  Height:=Rowcount*(DefaultRowHeight+1)+4;
  //DrawFromMap;
end;

procedure TPaintGrid.SizeChanged(OldColCount, OldRowCount: Longint);
begin
   Setlength(ColorMap, RowCount, ColCount);
   NewItems(OldRowCount, RowCount, OldColCount, ColCount);
   Width:=ColCount*(DefaultColWidth+1)+4;
   Height:=Rowcount*(DefaultRowHeight+1)+4;
end;

procedure TPaintGrid.ToShape(const Value: TMyShape);
begin
  FShape := Value;
  DrawFromMap;
end;

procedure TPaintGrid.DrawFromMap;
var i,j:longint;
begin
  //case FShape of
    //ARectangle:
    begin
       for I := 0 to colCount-1 do
        for j := 0 to rowCount-1 do
      begin
        Canvas.Brush.Color:=ColorMap[j,i];
        if Fshape=Arectangle then
			Canvas.Rectangle(CellRect(i,j) ) else
		 	Canvas.Ellipse(CellRect(i,j));
      end;
   
  
  end;

end;

procedure TPaintGrid.MouseDown(var Msg: TMessage);
begin
   inherited;
   pressed:=true;
end;

procedure TPaintGrid.MouseMove(var Msg: TMessage);
var a: TGridCoord;
begin
  inherited;
  if pressed then
  with canvas do
  begin
    brush.Color:=FcurCol;
    a:=MouseCoord((Msg.LParam) and $FFFF, (Msg.LParam shr 16) and $FFFF);
    if FShape=ARectangle then

    Rectangle(CellRect(a.X, a.Y) ) else
    Ellipse(CellRect(a.X, a.Y));
    ColorMap[a.y,a.x]:=currentColor;

  end;

end;

procedure TPaintGrid.MouseUp(var Msg: TMessage);
begin
   inherited;
   MouseMove(Msg);
   pressed:=false;
end;

procedure TPaintGrid.NewItems(oldRows, newRows, oldCols, newCols: integer);
var i,j: integer;
begin
    for i := oldRows to newRows-1 do
      for j := oldCols to newCols-1 do
        ColorMap[i,j]:=self.Color;
end;

end.

