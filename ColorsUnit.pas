unit ColorsUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, System.Generics.Collections;

type
  TColorsForm = class(TForm)
    Dg: TDrawGrid;
    procedure FormPaint(Sender: TObject);
  private
    Fpallete: TList<TColor>;
  public
      property Pallete: TList<TColor> write Fpallete;
  end;

var
  ColorsForm: TColorsForm;

implementation

{$R *.dfm}

procedure TColorsForm.FormPaint(Sender: TObject);
var s:string; re:Trect;
begin
  dg.RowCount:=Fpallete.Count;
  //dg.Canvas.Rectangle(0,0,10,15);
  for var i := 0 to dg.RowCount-1 do
    begin
      dg.Canvas.Brush.Color:=Fpallete[i];

      dg.Canvas.Rectangle(dg.CellRect(0,i));
      s:=inttostr(Fpallete[i]);
      re:= dg.CellRect(1,i);
      dg.Canvas.TextRect(re,s,[]);
    end;
end;

end.
