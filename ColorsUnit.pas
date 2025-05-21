unit ColorsUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, System.Generics.Collections,
  Vcl.ComCtrls, Vcl.ToolWin, System.ImageList, Vcl.ImgList, Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TCell = class
    color: TColor;
    number: byte;
    amount: word;
    pressed: boolean;
    private
    function GetHex:string;
    public
    property HexColor:string read GetHex;
  end;
  TColorsForm = class(TForm)
    ToolBar1: TToolBar;
    ColorDialog1: TColorDialog;
    rgInform: TRadioGroup;
    dg: TStringGrid;
    procedure DgDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
    procedure DgSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DgMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ToolButton1Click(Sender: TObject);
    procedure rgInformClick(Sender: TObject);
  private
    //Fpallete: TDictionary<TColor, word>;
    FArPallete:TArray<TPair<TColor,word>>;

    {$j+}
    const pressed: boolean=false;
  public
      //property Pallete: TDictionary<TColor, word> write SetFpallete;
      procedure SetPallete(pallete: TDictionary<TColor, word>);
  end;

var
  ColorsForm: TColorsForm;

implementation
uses main;

{$R *.dfm}

procedure TColorsForm.DgDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var s:string; num:word;
begin
      num:=(ACol div 2) * 8 + ARow;
      if (length(FarPallete)>num) and (length(farpallete)>0) then
        begin
          //curCol:=Farpallete[num].Key;
          if ACol mod 2 =0 then
          begin
            dg.Canvas.Brush.Color:=(dg.Objects[aCol,arow] as TCell).color;
            dg.Canvas.Rectangle(Rect);
          end else
          begin
             case rgInform.ItemIndex of
             0: s:=inttostr((dg.Objects[aCol-1,arow] as TCell).number);
             1: s:=(dg.Objects[aCol-1,arow] as TCell).HexColor;
             2: s:=inttostr((dg.Objects[aCol-1,arow] as TCell).amount);
             end;
            dg.Canvas.Brush.Color:=dg.Color;
            //dg.Canvas.Font.Size:=12;
            dg.Canvas.Font.Name:='Tahoma';
            dg.Canvas.TextRect(Rect,s,[]);
          end;
        end;
end;

procedure TColorsForm.DgMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);    //changes the color
  var ce:TPoint; curcol:TColor; row, col: integer;
  const tr: boolean=true;
  begin
   if button=TMouseButton.mbRight then
   begin
     dg.MouseToCell(x,y, ce.X, ce.y);
     if ce.X mod 2 = 0 then
     begin
       colordialog1.Color:=(dg.Objects[ce.X, ce.y] as tcell).color;
       if colordialog1.Execute then
        begin
          //curcol:=Farpallete[ce.X*8+ce.y].Key;
          dg.Canvas.Brush.Color:=colordialog1.Color;
          for row := 0 to dg.RowCount-1 do
          for col := 0 to dg.ColCount-1 do
            with (dg.Objects[col, row] as tcell) do begin
              if not(dg.Objects[col, row] is tcell) then break; //exit
              if col mod 2 <> 0 then continue;
              if pressed=false then continue;
              curcol:=color;
              dg.Canvas.Rectangle(dg.CellRect(col,row));
              mosaic.selectColor(curcol, true);
              mosaic.ChangeColor(colordialog1.Color, curcol);
              color:=colordialog1.Color;
              pressed:=false;
            end;
          //curcol:=colordialog1.Color;
          dg.Repaint;
          mosaic.pg.Repaint;
          //dgselectcell(sender,ce.X,ce.Y,tr);
        end;
     end;

   end;
end;

procedure TColorsForm.DgSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
var curCol: Tcolor;
begin
    if ACol mod 2 = 0 then
    begin
      curcol:=(dg.Objects[acol, arow] as tcell).color;
      (dg.Objects[acol, arow] as tcell).pressed:=not((dg.Objects[acol, arow] as tcell).pressed);
      mosaic.selectColor(curcol, not((dg.Objects[acol, arow] as tcell).pressed));       //select
    end;
end;

procedure TColorsForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if dg.Tag>-1 then mosaic.selectColor(Farpallete[dg.tag].Key, true);
end;

procedure TColorsForm.rgInformClick(Sender: TObject);
begin
  dg.Repaint;
end;

procedure TColorsForm.SetPallete(pallete: TDictionary<TColor, word>);
var mycell:TCell;
begin
     FArPallete:=pallete.ToArray;
     //dg.RowCount:=8;
     dg.ColCount:=2*(pallete.Count div 8);
      if dg.ColCount mod 2 <> 0 then dg.ColCount:=dg.ColCount+1;
     for var i := Low(farpallete) to High(farpallete) do

     begin
       mycell:=tcell.Create;
       mycell.color:=farpallete[i].Key;
       mycell.number:=i;
       mycell.amount:=farpallete[i].Value;
       mycell.pressed:=false;
       dg.Objects[2*(i div 8), (i mod 8)]:=mycell;
       //mycell.Destroy;
     end;


end;

procedure TColorsForm.ToolButton1Click(Sender: TObject);
begin
   dg.Tag:=(sender as ttoolbutton).Tag ;
   dg.Repaint;
end;

{ TCell }

function TCell.GetHex: string;
begin
   result:= copy(IntToHex(colortorgb(rgb(getbvalue(color),getgvalue(color),getrvalue(color)))),3,6); //to swap r<->b for true hex representation
end;

end.
