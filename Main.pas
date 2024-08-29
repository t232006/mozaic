unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, PaintGrid, engine,
  Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    pg: TPaintGrid;
    Button1: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    FPicture: TBitmap;
    ColorCount: byte;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  pg.DrawFromMap;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FPicture:=TBitmap.Create;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FPicture.Destroy;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  TMap(pg.ColorMap):=GetMap(FPicture,pg.ColCount,pg.RowCount,ColorCount);
  pg.DrawFromMap;
end;

end.
