unit AltPopup;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, Data.FMTBcd, Data.SqlExpr,
  FireDAC.Comp.Client, ColorsUnit, auxilaryClasses;

type
  TAlterPalette = class(TForm)
    DBGrid1: TDBGrid;
    DataSource: TDataSource;
  private
    { Private declarations }
  public
    procedure Envoke(Cell:TCell);
  end;

var
  AlterPalette: TAlterPalette;

implementation

{$R *.dfm}

procedure TAlterPalette.Envoke(Cell: TCell);
begin
  cell.querymode:=all;
  DataSource.dataset:=Cell.Query;
  self.show;
end;

end.
