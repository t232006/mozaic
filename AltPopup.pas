unit AltPopup;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, Data.FMTBcd, Data.SqlExpr,
  FireDAC.Comp.Client, auxilaryClasses, Vcl.StdCtrls, Vcl.DBCtrls,
  Vcl.ExtCtrls, Vcl.DBCGrids;

type
  TPopupForm = class(TForm)
    DataSource: TDataSource;
    DBCtrlGrid1: TDBCtrlGrid;
    Shape1: TShape;
    DBText1: TDBText;
    constructor Create(owner: Tcomponent; cell: TCell);  overload;
    procedure DBCtrlGrid1PaintPanel(DBCtrlGrid: TDBCtrlGrid; Index: Integer);
    procedure FormCreate(Sender: TObject);
  private

    FCell: TCell;
  public
  end;

var
  PopupForm: TPopupForm;

implementation
uses ColorsUnit;

{$R *.dfm}


constructor TPopupForm.Create(owner: Tcomponent; cell: TCell);
begin
    inherited Create(owner);
    FCell:=cell;
end;

procedure TPopupForm.DBCtrlGrid1PaintPanel(DBCtrlGrid: TDBCtrlGrid; Index: Integer);
var r,g,b: byte;
begin
  with datasource.dataset do
  begin
    r:=fieldbyname('r').asInteger;
    g:=fieldbyname('g').asInteger;
    b:=fieldbyname('b').asInteger;
    shape1.brush.color:=rgb(r,g,b);
  end;
end;



procedure TPopupForm.FormCreate(Sender: TObject);
begin
  Fcell.state:=smany;
  DataSource.dataset:=Fcell.query;
  dbtext1.DataField:='name';
end;

end.
