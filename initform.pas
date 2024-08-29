unit initform;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, Vcl.Mask, Vcl.ExtDlgs;

type
  TinitForm = class(TForm)
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    LabeledEdit3: TLabeledEdit;
    UpDown3: TUpDown;
    Button1: TButton;
    pictureD: TOpenPictureDialog;
    procedure BitBtn1Click(Sender: TObject);
    procedure LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn2Click(Sender: TObject);
    procedure LabeledEdit3Change(Sender: TObject);
    procedure LabeledEdit3KeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  initForm: TinitForm;
const cl:boolean=false;


implementation

{$R *.dfm}

procedure TinitForm.BitBtn1Click(Sender: TObject);
begin
     cl:=false;
     form1.hide;
end;




procedure TinitForm.LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
begin
     if not((key>'0') and (key<'9')) then key:='5';
end;

procedure TinitForm.LabeledEdit3KeyPress(Sender: TObject; var Key: Char);
begin
    if (key<'0') or (key>'9') then key:='1';

end;

procedure TinitForm.BitBtn2Click(Sender: TObject);
begin
begin
        cl:=true;
        form1.Close;
end;
end;

procedure TinitForm.Button1Click(Sender: TObject);
begin
  if pictureD.execute then

end;

end.