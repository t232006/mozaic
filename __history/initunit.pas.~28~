unit initunit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls,
  Vcl.Mask, Vcl.ExtDlgs, Main, jpeg, engineThread;

type
  TinitForm = class(TForm)
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    ColCount: TLabeledEdit;
    RowCount: TLabeledEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Button1: TButton;
    pictureD: TOpenPictureDialog;
    progrBar: TProgressBar;
    ColorCount: TComboBox;
    procedure BitBtn1Click(Sender: TObject);
    procedure ColCountKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    //procedure progrBarChange(Sender: TObject);
    procedure PassMap(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private

    FPicture: TBitmap;
    //ColorCount: byte;
  public
    th: Tengine;
  end;

var
  initForm: TinitForm;
  //cl:boolean;


implementation

{$R *.dfm}

procedure TinitForm.BitBtn1Click(Sender: TObject);
begin
     //cl:=false;
     mosaic.pg.ColCount:=strtoint(ColCount.Text);
     mosaic.pg.RowCount:=strtoint(RowCount.Text);
     //form1.ColorCount:=strtoint(ColorCount.Text);
//     form1.FPicture.LoadFromFile()
     //form1.Show;
     //initform.hide;
     //for var i := 1 to 4 do
     th:=Tengine.create(fPicture,
                          strtoint(ColCount.Text),
                          strtoint(RowCount.Text),
                          ColorCount.ItemIndex+2,
                          progrBar);
     th.OnFinish:=PassMap;
end;


procedure TinitForm.ColCountKeyPress(Sender: TObject; var Key: Char);
begin
     if (key<'0') or (key>'9') then
      key:='5';
end;

procedure TinitForm.FormCreate(Sender: TObject);
begin
  fpicture:=TBitmap.Create;

end;

procedure TinitForm.FormDestroy(Sender: TObject);
begin
  FPicture.Destroy;
end;

procedure TinitForm.FormShow(Sender: TObject);
begin
  progrbar.Position:=0;
end;

procedure TinitForm.PassMap(Sender: TObject);
begin
    TMap(mosaic.pg.ColorMap):=th.map;
     mosaic.Show;
     initform.hide;
end;

procedure TinitForm.BitBtn2Click(Sender: TObject);
begin
begin
        //cl:=true;
        initform.Close;
end;
end;

procedure TinitForm.Button1Click(Sender: TObject);
var JPEG: TJPEGimage;
begin
  if pictureD.execute then
  begin
    BitBtn1.Enabled:=true;
    if UpperCase(extractfileext(pictured.FileName))='.JPG' then
    begin
       jpeg:=Tjpegimage.Create;
       jpeg.LoadFromFile(pictureD.FileName);
       FPicture.Assign(jpeg);
       jpeg.Destroy;
    end else

    fpicture.loadfromfile(pictureD.FileName);
    //
  end;

end;

end.
