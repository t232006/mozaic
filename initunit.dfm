object initForm: TinitForm
  Left = 810
  Top = 440
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = #1089#1086#1079#1076#1072#1085#1080#1077' '#1088#1072#1073#1086#1095#1077#1081' '#1086#1073#1083#1072#1089#1090#1080
  ClientHeight = 196
  ClientWidth = 270
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  TextHeight = 13
  object UpDown1: TUpDown
    Left = 97
    Top = 24
    Width = 16
    Height = 21
    Associate = ColCount
    Increment = 5
    Position = 45
    TabOrder = 0
  end
  object UpDown2: TUpDown
    Left = 217
    Top = 24
    Width = 16
    Height = 21
    Associate = RowCount
    Increment = 5
    Position = 30
    TabOrder = 1
  end
  object ColCount: TLabeledEdit
    Left = 32
    Top = 24
    Width = 65
    Height = 21
    EditLabel.Width = 42
    EditLabel.Height = 13
    EditLabel.Caption = #1082#1086#1083#1086#1085#1086#1082
    TabOrder = 2
    Text = '45'
    OnKeyPress = ColCountKeyPress
  end
  object RowCount: TLabeledEdit
    Left = 152
    Top = 24
    Width = 65
    Height = 21
    EditLabel.Width = 29
    EditLabel.Height = 13
    EditLabel.Caption = #1089#1090#1088#1086#1082
    TabOrder = 4
    Text = '30'
    OnKeyPress = ColCountKeyPress
  end
  object BitBtn1: TBitBtn
    Left = 32
    Top = 136
    Width = 75
    Height = 25
    Enabled = False
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 5
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 152
    Top = 136
    Width = 75
    Height = 25
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 6
    OnClick = BitBtn2Click
  end
  object Button1: TButton
    Left = 152
    Top = 78
    Width = 75
    Height = 25
    Caption = #1082#1072#1088#1090#1080#1085#1082#1072
    TabOrder = 3
    OnClick = Button1Click
  end
  object progrBar: TProgressBar
    Left = 0
    Top = 179
    Width = 270
    Height = 17
    Align = alBottom
    TabOrder = 7
    ExplicitTop = 178
    ExplicitWidth = 266
  end
  object ColorCount: TComboBox
    Left = 32
    Top = 80
    Width = 65
    Height = 21
    DropDownCount = 5
    ItemIndex = 1
    TabOrder = 8
    Text = '8'
    Items.Strings = (
      '4'
      '8'
      '16'
      '32'
      '64')
  end
  object pictureD: TOpenPictureDialog
    Options = [ofEnableSizing]
    Left = 120
    Top = 56
  end
end
