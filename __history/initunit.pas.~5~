unit initunit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls,
  Vcl.Mask, Vcl.ExtDlgs, Main;

type
  TinitForm = class(TForm)
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    ColCount: TLabeledEdit;
    RowCount: TLabeledEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ColorCount: TLabeledEdit;
    UpDown3: TUpDown;
    Button1: TButton;
    pictureD: TOpenPictureDialog;
    procedure BitBtn1Click(Sender: TObject);
    procedure ColCountKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn2Click(Sender: TObject);
    procedure ColorCountKeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  initForm: TinitForm;
  //cl:boolean;


implementation

{$R *.dfm}

procedure TinitForm.BitBtn1Click(Sender: TObject);
begin
     //cl:=false;
     form1.pg.ColCount:=strtoint(ColCount.Text);
     form1.pg.RowCount:=strtoint(RowCount.Text);
     form1.ColorCount:=strtoint(ColorCount.Text);
//     form1.FPicture.LoadFromFile()
     form1.Show;
     initform.hide;
end;




procedure TinitForm.ColCountKeyPress(Sender: TObject; var Key: Char);
begin
     if not((key>'0') and (key<'9')) then key:='5';
end;

procedure TinitForm.ColorCountKeyPress(Sender: TObject; var Key: Char);
begin
    if (key<'0') or (key>'9') then key:='1';

end;

procedure TinitForm.BitBtn2Click(Sender: TObject);
begin
begin
        //cl:=true;
        initform.Close;
end;
end;

procedure TinitForm.Button1Click(Sender: TObject);
begin
  if pictureD.execute then
  begin
    BitBtn1.Enabled:=true;
    form1.fpicture.loadfromfile(pictureD.FileName);
  end;

end;

end.
