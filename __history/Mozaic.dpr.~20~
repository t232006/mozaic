program Mozaic;

uses
  Vcl.Forms,
  Main in 'Main.pas' {mosaic},
  initunit in 'initunit.pas' {initForm},
  engineThread in 'engineThread.pas',
  ColorsUnit in 'ColorsUnit.pas' {ColorsForm},
  MiniThread in 'MiniThread.pas',
  MediaClass in 'MediaClass.pas',
  PaintGrid in '..\myComponents\PaintGrid\PaintGrid.pas',
  contrast in 'contrast.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TinitForm, initForm);
  Application.CreateForm(Tmosaic, mosaic);
  Application.CreateForm(TColorsForm, ColorsForm);
  Application.Run;
end.
