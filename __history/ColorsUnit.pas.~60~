unit ColorsUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, System.Generics.Collections,
  Vcl.ComCtrls, Vcl.ToolWin, System.ImageList, Vcl.ImgList, Vcl.StdCtrls,
  Vcl.ExtCtrls, contrast, auxilaryClasses, Vcl.Buttons, altPopup;

type
  TColorsForm = class(TForm)
    ColorDialog1: TColorDialog;
    dg: TStringGrid;
    rgInform: TRadioGroup;
    selector: TComboBox;
    PG: TProgressBar;
    SpeedButton1: TSpeedButton;
    SaveDialog1: TSaveDialog;
    ImageList1: TImageList;
    procedure DgDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
    procedure DgSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DgMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ToolButton1Click(Sender: TObject);
    procedure rgInformClick(Sender: TObject);
    procedure selectorCloseUp(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private

    FArPallete:TArray<TPair<TColor,word>>;
    procedure printText(Acol, arow: integer);
    procedure printColor(Color: TColor);
    procedure RepaintBySim(origin: boolean; standart: string);
    {$j+}
    //const pressed: boolean=false;
  public
      //property Pallete: TDictionary<TColor, word> write SetFpallete;
       procedure SetPallete(arpallete:TArray<TPair<TColor,word>> );
  end;
const RCOUNT:byte=16; COLWIDTH=50;
var
  ColorsForm: TColorsForm;

implementation
uses main;

{$R *.dfm}


procedure TColorsForm.DgDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var num:word;  c:TCell; l,r,t,b: Integer;
const RADIUS=5;
begin
      num:=ACol * RCOUNT + ARow;
      if (length(FarPallete)>num) and (length(farpallete)>0) then

        with dg.Canvas do
        begin
          c:=dg.Objects[aCol,arow] as TCell;
          case selector.ItemIndex of
          0: Brush.Color:=c.color;
          1,2,3:
            begin
             c.Standart:=selector.Text;
             Brush.Color:=c.Similar
            end;
          end;

          Rectangle(System.Classes.Rect(Rect.left,rect.Top,rect.Left+COLWIDTH,rect.Bottom));
          printtext(acol,arow);
          if c.pressed then
          begin
            l:=Rect.Left + (COLWIDTH div 2)-RADIUS;
            t:=Rect.Top + (dg.DefaultRowHeight div 2)-RADIUS;
            r:=l+2*RADIUS; b:=t+2*RADIUS;
            brush.Color:=TContrast.rudeContrast(c.Color);
            Ellipse(System.Classes.Rect(l,t,r,b));
          end;
        end;

end;

procedure TColorsForm.DgMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);    //changes the color
  var ce:TPoint; alterpop: TPopupForm;  //r: TRect;
  //const tr: boolean=true;
  begin
   dg.MouseToCell(x,y, ce.X, ce.y);
   if button=TMouseButton.mbRight then
   case selector.itemindex of
   0:
     begin
       //r:=dg.CellRect(ce.x,ce.Y);
       colordialog1.Color:=(dg.Objects[ce.X, ce.y] as tcell).color;
       if colordialog1.Execute then
        begin
            printcolor(colordialog1.Color);
            (dg.Objects[ce.X, ce.y] as tcell).color:=colordialog1.Color;
            dg.Repaint;
        end;
     end;
   1,2,3:
     begin
         alterpop:=TPopupForm.Create(Application,dg.object[ce.x,ce.y] as Tcell);
         alterpop.show;
     end;
   end;
end;

procedure TColorsForm.DgSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
var curCol: Tcolor; c: TCell;
begin


      c:=dg.Objects[acol, arow] as tcell;
      if selector.ItemIndex=0 then
        curcol:=c.color else
        curcol:=c.Similar;
      c.pressed:=not(c.pressed);
      mosaic.selectColor(curcol, not(c.pressed));
      dg.Repaint;
end;

procedure TColorsForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if dg.Tag>-1 then mosaic.selectColor(Farpallete[dg.tag].Key, true);
end;

procedure TColorsForm.FormResize(Sender: TObject);
var mycell:TCell;
begin
    rcount:=(dg.Height-75) div dg.DefaultRowHeight;
    dg.ColCount:=length(Farpallete) div RCOUNT;
    dg.RowCount:=RCOUNT;
    if length(Farpallete)>RCOUNT then dg.ColCount:=dg.ColCount+1;
    dg.DefaultColWidth:=(width-30) div dg.ColCount;


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

procedure TColorsForm.printColor(color: TColor);//changes color for selected cells in mainForm
var row, col: integer; c: TCell;
begin
          //dg.Canvas.Brush.Color:=Color;
      for col := 0 to dg.ColCount-1 do
      for row := 0 to dg.RowCount-1 do
      begin
        if not(dg.Objects[col, row] is tcell) then break; //exit
        c:=dg.Objects[col, row] as tcell;
        if c.pressed=false then continue;
        //dg.Canvas.Rectangle(dg.CellRect(col,row));
        mosaic.selectColor(c.Color, true);  //unselect
        if color<>c.Color then
          mosaic.ChangeColor(Color, c.Color) //new color, old color
        else
          mosaic.ChangeColor(Color, c.Similar);
        //color:=colordialog1.Color;
        c.pressed:=false;
      end;
      dg.Repaint;
      mosaic.pg.Repaint;
end;

procedure TColorsForm.printText(Acol, arow: integer);
var s:string; re,r:trect; t:TTextformat;  c:TCell;
begin
  c:=dg.Objects[aCol,arow] as TCell;
  case rgInform.ItemIndex of
             0: s:=inttostr(c.number);
             1: if selector.ItemIndex=0 then
                 s:=c.HexColor
                 else
                 s:=c.SimHex;
             2: s:=inttostr(c.amount);
             3: s:=c.SimName;
             4: s:=c.SimStandartNumber;
  end;
    dg.Canvas.Brush.Color:=dg.Color;
    if length(s)<=20 then dg.Canvas.Font.Size:=12 else
    dg.Canvas.Font.Size:=round(19-8/23*length(s));
    dg.Canvas.Font.Name:='Tahoma';
    r:=dg.CellRect(acol,arow) ;
    re:=rect(r.Left+COLWIDTH+10,r.Top,r.Right,r.Bottom);
    dg.Canvas.TextRect(re,re.Left,re.Top,s);
end;

procedure TColorsForm.RepaintBySim(origin: boolean; standart: string); //repaints mainForm origins of similar colors
var row, col: integer; c: TCell;
begin
    pg.Position:=0;
    for col := 0 to dg.ColCount-1 do
    for row := 0 to dg.RowCount-1 do
      begin
        if not(dg.Objects[col,row] is tcell) then break;
        c:=dg.Objects[col,row] as tcell;
        if not(origin) then
          c.Standart:=standart;
        c.pressed:=true;
        if origin then printcolor(c.Color) else
        printColor(c.Similar);
        pg.StepIt;
      end;
    pg.Position:=0;

end;

procedure TColorsForm.rgInformClick(Sender: TObject);
begin
  dg.Repaint;
end;

procedure TColorsForm.selectorCloseUp(Sender: TObject);
var it: byte;
begin
  with rginform do
  begin
    it:=itemindex;
    Items.Clear;
    items.Add('номера');items.Add('цвета');items.Add('количество');
    pg.Max:=length(FArPallete);
    case selector.itemindex of
    1,3: begin
      items.Add('названия');
      items.Add('номер стандарта');
      repaintbysim(false, selector.Text);
    end;
    2: begin
      items.Add('названия');
      repaintbysim(false, selector.Text);
    end;
    else repaintbysim(true, selector.Text);
    end;
    itemindex:=it;
  end;
  //dg.Repaint;
end;

procedure TColorsForm.SetPallete(arpallete:TArray<TPair<TColor,word>> );

begin
     FArPallete:=arpallete;
     //Accomodation;
end;

procedure TColorsForm.SpeedButton1Click(Sender: TObject);
var saver: TBitmap; r:TRect;
begin
  if SaveDialog1.Execute then
  begin
    saver:=TBitmap.Create;
    saver.Height:=dg.Height; saver.Width:=dg.Width;
    r:=rect(0,0,dg.Width-10, dg.Height-10);
    saver.Canvas.CopyRect(r, dg.Canvas,r);
    saver.SaveToFile(savedialog1.FileName+'.bmp');

  end;
end;

procedure TColorsForm.ToolButton1Click(Sender: TObject);
begin
   dg.Tag:=(sender as ttoolbutton).Tag ;
   dg.Repaint;
end;


end.
