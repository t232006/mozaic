unit ColorsUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, System.Generics.Collections,
  Vcl.ComCtrls, Vcl.ToolWin, System.ImageList, Vcl.ImgList, Vcl.StdCtrls,
  Vcl.ExtCtrls, contrast, auxilaryClasses;

type
  TColorsForm = class(TForm)
    ColorDialog1: TColorDialog;
    dg: TStringGrid;
    rgInform: TRadioGroup;
    selector: TComboBox;
    procedure DgDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
    procedure DgSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DgMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ToolButton1Click(Sender: TObject);
    procedure rgInformClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure selectorCloseUp(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private

    FArPallete:TArray<TPair<TColor,word>>;
    procedure printText(Acol, arow: integer);
    {$j+}
    const pressed: boolean=false;
  public
      //property Pallete: TDictionary<TColor, word> write SetFpallete;
       procedure SetPallete(arpallete:TArray<TPair<TColor,word>> );
       procedure Accomodation;
  end;
const RCOUNT:byte=16; COLWIDTH=75;
var
  ColorsForm: TColorsForm;
  arrow: Tbitmap;

implementation
uses main;

{$R *.dfm}

procedure TColorsForm.Accomodation;
var mycell:TCell;
begin
    dg.ColCount:=length(Farpallete) div RCOUNT;
     if (length(farpallete) mod RCOUNT <> 0) and (dg.ColCount>1)
      then dg.ColCount:=dg.ColCount+1;

      //if dg.ColCount mod 2 <> 0 then dg.ColCount:=dg.ColCount+1;
     for var i := Low(farpallete) to High(farpallete) do

     begin
       mycell:=tcell.Create;
       mycell.color:=farpallete[i].Key;
       mycell.number:=i;
       mycell.amount:=farpallete[i].Value;
       mycell.pressed:=false;
       dg.Objects[(i div RCOUNT), (i mod RCOUNT)]:=mycell;
       //mycell.Destroy;
     end;
end;

procedure TColorsForm.DgDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var s:string; num:word;  curcol: TColor;  //t:TTextformat;
begin
      num:=ACol * RCOUNT + ARow;
      if (length(FarPallete)>num) and (length(farpallete)>0) then
        with dg.Canvas do
        begin
            curcol:=(dg.Objects[aCol,arow] as TCell).color;
            Brush.Color:=curcol;
            Rectangle(System.Classes.Rect(Rect.left,rect.Top,rect.Left+COLWIDTH,rect.Bottom));
            if (dg.Objects[acol, arow] as tcell).pressed then
            begin
               printtext(acol,arow);
               dg.Canvas.draw(dg.CellRect(acol,arow).Left+COLWIDTH+30, dg.CellRect(acol,arow).Top+10,arrow);
            end
            else
                printtext(acol,arow);
            //printtext(acol,arow);
        end;

end;

procedure TColorsForm.DgMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);    //changes the color
  var ce:TPoint; curcol:TColor; row, col: integer;
  //const tr: boolean=true;
  begin
   if button=TMouseButton.mbRight then
   begin
     dg.MouseToCell(x,y, ce.X, ce.y);

       colordialog1.Color:=(dg.Objects[ce.X, ce.y] as tcell).color;
       if colordialog1.Execute then
        begin
          //curcol:=Farpallete[ce.X*RCOUNT+ce.y].Key;
          dg.Canvas.Brush.Color:=colordialog1.Color;
          for row := 0 to dg.RowCount-1 do
          for col := 0 to dg.ColCount-1 do
            with (dg.Objects[col, row] as tcell) do begin
              //if col mod 2 <> 0 then continue;
              if not(dg.Objects[col, row] is tcell) then break; //exit

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

procedure TColorsForm.DgSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
var curCol: Tcolor;
begin
    //if ACol mod 2 = 0 then
    begin
    //insert selection here if requirable
      curcol:=(dg.Objects[acol, arow] as tcell).color;
      (dg.Objects[acol, arow] as tcell).pressed:=not((dg.Objects[acol, arow] as tcell).pressed);
      mosaic.selectColor(curcol, not((dg.Objects[acol, arow] as tcell).pressed));
      dg.Repaint;

    end;
end;

procedure TColorsForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if dg.Tag>-1 then mosaic.selectColor(Farpallete[dg.tag].Key, true);
end;

procedure TColorsForm.FormCreate(Sender: TObject);
begin
  arrow:=TBitmap.Create;
  arrow.LoadFromResourceName(hinstance, 'Arrow_1');
end;

procedure TColorsForm.FormResize(Sender: TObject);
begin
  rcount:=dg.Height div dg.DefaultRowHeight;
  accomodation;
end;

procedure TColorsForm.printText(Acol, arow: integer);
var s:string; re,r:trect; t:TTextformat;
begin
  case rgInform.ItemIndex of
             0: s:=inttostr((dg.Objects[aCol,arow] as TCell).number);
             1: if selector.ItemIndex=0 then
                 s:=(dg.Objects[aCol,arow] as TCell).HexColor
                 else
                 s:=(dg.Objects[acol,arow] as TCell).SimHex;
             2: s:=inttostr((dg.Objects[aCol,arow] as TCell).amount);
             3: s:=(dg.Objects[acol, arow] as TCell).SimName;
             4: s:=inttostr((dg.Objects[acol, arow] as TCell).SimRAL);
  end;
    dg.Canvas.Brush.Color:=dg.Color;
    dg.Canvas.Font.Size:=12;
    dg.Canvas.Font.Name:='Tahoma';
    r:=dg.CellRect(acol,arow) ;
    re:=rect(r.Left+COLWIDTH+10,r.Top,r.Right,r.Bottom);
    dg.Canvas.TextRect(re,re.Left,re.Top,s);
end;

procedure TColorsForm.rgInformClick(Sender: TObject);
begin
  dg.Repaint;
end;

procedure TColorsForm.selectorCloseUp(Sender: TObject);
begin
  with rginform do
  begin
    Items.Clear;
    items.Add('номера');items.Add('цвета');items.Add('количество');
    case selector.itemindex of
    1: begin
      items.Add('названия');
      items.Add('RAL');
    end;
    2: items.Add('названия');
    end;
  end;
end;

procedure TColorsForm.SetPallete(arpallete:TArray<TPair<TColor,word>> );

begin
     FArPallete:=arpallete;
     Accomodation;


end;

procedure TColorsForm.ToolButton1Click(Sender: TObject);
begin
   dg.Tag:=(sender as ttoolbutton).Tag ;
   dg.Repaint;
end;


end.
