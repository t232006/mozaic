object initForm: TinitForm
  Left = 810
  Top = 440
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = #1089#1086#1079#1076#1072#1085#1080#1077' '#1088#1072#1073#1086#1095#1077#1081' '#1086#1073#1083#1072#1089#1090#1080
  ClientHeight = 189
  ClientWidth = 270
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  TextHeight = 13
  object UpDown1: TUpDown
    Left = 97
    Top = 24
    Width = 16
    Height = 21
    Associate = LabeledEdit1
    Increment = 5
    Position = 10
    TabOrder = 0
  end
  object UpDown2: TUpDown
    Left = 217
    Top = 24
    Width = 16
    Height = 21
    Associate = LabeledEdit2
    Increment = 5
    Position = 10
    TabOrder = 1
  end
  object LabeledEdit1: TLabeledEdit
    Left = 32
    Top = 24
    Width = 65
    Height = 21
    EditLabel.Width = 42
    EditLabel.Height = 13
    EditLabel.Caption = #1082#1086#1083#1086#1085#1086#1082
    TabOrder = 2
    Text = '10'
    OnKeyPress = LabeledEdit1KeyPress
  end
  object LabeledEdit2: TLabeledEdit
    Left = 152
    Top = 24
    Width = 65
    Height = 21
    EditLabel.Width = 29
    EditLabel.Height = 13
    EditLabel.Caption = #1089#1090#1088#1086#1082
    TabOrder = 3
    Text = '10'
  end
  object BitBtn1: TBitBtn
    Left = 32
    Top = 136
    Width = 75
    Height = 25
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 4
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 152
    Top = 136
    Width = 75
    Height = 25
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 5
    OnClick = BitBtn2Click
  end
  object LabeledEdit3: TLabeledEdit
    Left = 32
    Top = 80
    Width = 65
    Height = 21
    EditLabel.Width = 35
    EditLabel.Height = 13
    EditLabel.Caption = #1094#1074#1077#1090#1086#1074
    TabOrder = 6
    Text = '2'
    OnChange = LabeledEdit3Change
    OnKeyPress = LabeledEdit3KeyPress
  end
  object UpDown3: TUpDown
    Left = 97
    Top = 80
    Width = 16
    Height = 21
    Associate = LabeledEdit3
    Min = 2
    Position = 2
    TabOrder = 7
  end
  object Button1: TButton
    Left = 152
    Top = 78
    Width = 75
    Height = 25
    Caption = #1082#1072#1088#1090#1080#1085#1082#1072
    TabOrder = 8
    OnClick = Button1Click
  end
  object pictureD: TOpenPictureDialog
    Left = 120
    Top = 56
  end
end
