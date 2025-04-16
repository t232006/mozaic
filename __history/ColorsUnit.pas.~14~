unit ColorsUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, System.Generics.Collections;

type
  TColorsForm = class(TForm)
    Dg: TDrawGrid;
    ColorDialog1: TColorDialog;
    procedure FormActivate(Sender: TObject);
    procedure DgDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
    procedure DgSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DgMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    Fpallete: TList<TColor>;
    {$j+}
    const pressed: boolean=false;
  public
      property Pallete: TList<TColor> write Fpallete;
  end;

var
  ColorsForm: TColorsForm;

implementation
uses main;

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

procedure TColorsForm.DgMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  var ce:TPoint; const tr: boolean=true;
  begin
   if button=TMouseButton.mbRight then
   begin
     dg.MouseToCell(x,y, ce.X, ce.y);
     if ce.X mod 2 = 0 then
     if colordialog1.Execute then
      begin
        dg.Canvas.Brush.Color:=colordialog1.Color;
        dg.Canvas.Rectangle(dg.CellRect(ce.X,ce.Y));
        mosaic.selectColor(Fpallete[ce.X*8+ce.y], true); pressed:=false;
        mosaic.ChangeColor(colordialog1.Color, fpallete[ce.X*8+ce.y]);
        fpallete[ce.X*8+ce.y]:=colordialog1.Color;
        dg.Repaint;
        mosaic.pg.Repaint;
        //dgselectcell(sender,ce.X,ce.Y,tr);

      end;

   end;
end;

procedure TColorsForm.DgSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
    if ACol mod 2 = 0 then
    begin
      if pressed and (dg.tag<>-1) then
        if dg.tag<>acol*8+arow then
        begin
          mosaic.selectColor(Fpallete[dg.tag], true);
          mosaic.selectColor(Fpallete[ACol*8+ARow], false) ;
        end else
        begin
          mosaic.selectColor(Fpallete[ACol*8+ARow], true);
          pressed:=not(pressed);
        end
      else
      begin
        mosaic.selectColor(Fpallete[ACol*8+ARow], false) ;
        pressed:=not(pressed);
      end;
      dg.tag:=acol*8+arow;
    end;
end;

procedure TColorsForm.FormActivate(Sender: TObject);
var s:string; re:Trect;
begin
  dg.RowCount:=8;
  dg.ColCount:=2*Fpallete.Count div 8;
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

procedure TColorsForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   mosaic.selectColor(Fpallete[dg.tag], true);
end;

end.
