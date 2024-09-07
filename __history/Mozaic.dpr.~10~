program Mozaic;

uses
  Vcl.Forms,
  Main in 'Main.pas' {Form1},
  engine in 'engine.pas',
  initunit in 'initunit.pas' {initForm},
  engineThread in 'engineThread.pas',
  ColorsUnit in 'ColorsUnit.pas' {ColorsForm},
  PaintGrid in '..\My components\PaintGrid\PaintGrid.pas',
  MiniThread in 'MiniThread.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TinitForm, initForm);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TColorsForm, ColorsForm);
  Application.Run;
end.
