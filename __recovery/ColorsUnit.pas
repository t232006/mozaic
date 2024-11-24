unit ColorsUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, System.Generics.Collections;

type
  TColorsForm = class(TForm)
    Dg: TDrawGrid;
    procedure FormActivate(Sender: TObject);
    procedure DgDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
  private
    Fpallete: TList<TColor>;
  public
      property Pallete: TList<TColor> write Fpallete;
  end;

var
  ColorsForm: TColorsForm;

implementation

{$R *.dfm}

procedure TColorsForm.DgDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var s:string;
begin
      if ACol mod 2 =0 then
      begin
        dg.Canvas.Brush.Color:=Fpallete[(ACol div 2)*8+ARow];

        dg.Canvas.Rectangle(Rect);
      end else
      begin
        s:=inttostr(Fpallete[(ACol div 2)*8+ARow]);
        dg.Canvas.TextRect(Rect,s,[]);
      end;
end;

procedure TColorsForm.FormActivate(Sender: TObject);
var s:string; re:Trect;
begin
  dg.RowCount:=8;
  dg.ColCount:=2*(Fpallete.Count div 8);
  if dg.ColCount=0 then dg.ColCount:=2;

  //dg.Canvas.Rectangle(0,0,10,15);
  for var i := 0 to (dg.ColCount div 2)-1 do
    for var j := 0 to 7 do
    try
    begin
      dg.Canvas.Brush.Color:=Fpallete[i*8+j];

      dg.Canvas.Rectangle(dg.CellRect(i*2,j));
      s:=inttostr(Fpallete[i*8+j]);
      re:= dg.CellRect(i*2+1,j);
      dg.Canvas.TextRect(re,s,[]);
    end;
    finally

    end;
end;

end.
