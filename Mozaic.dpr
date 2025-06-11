program Mozaic;

{$R *.dres}

uses
  Vcl.Forms,
  Main in 'Main.pas' {mosaic},
  initunit in 'initunit.pas' {initForm},
  engineThread in 'engineThread.pas',
  ColorsUnit in 'ColorsUnit.pas' {ColorsForm},
  MiniThread in 'MiniThread.pas',
  MediaClass in 'MediaClass.pas',
  contrast in 'contrast.pas',
  resolution in 'resolution.pas',
  shapebut in 'shapebut.pas' {ShapeButton: TFrame},
  auxilaryClasses in 'auxilaryClasses.pas',
  PaintGrid in '..\My components\PaintGrid\PaintGrid.pas',
  AltPopup in 'AltPopup.pas' {PopupForm},
  OKCANCL1 in 'c:\program files (x86)\embarcadero\studio\23.0\ObjRepos\EN\DelphiWin32\OKCANCL1.PAS' {OKBottomDlg};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TinitForm, initForm);
  Application.CreateForm(Tmosaic, mosaic);
  Application.CreateForm(TColorsForm, ColorsForm);
  //Application.CreateForm(TPopupForm, PopupForm);
  Application.Run;
end.
