object ColorsForm: TColorsForm
  Left = 0
  Top = 0
  Caption = 'ColorsForm'
  ClientHeight = 513
  ClientWidth = 659
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 15
  object dg: TStringGrid
    Left = 0
    Top = 0
    Width = 659
    Height = 449
    TabStop = False
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    ColCount = 2
    DefaultColWidth = 164
    DefaultRowHeight = 30
    FixedCols = 0
    RowCount = 16
    FixedRows = 0
    TabOrder = 0
    OnDrawCell = DgDrawCell
    OnMouseUp = DgMouseUp
    OnSelectCell = DgSelectCell
    ExplicitWidth = 548
  end
  object rgInform: TRadioGroup
    Left = 0
    Top = 449
    Width = 547
    Height = 64
    ParentCustomHint = False
    Align = alClient
    BiDiMode = bdLeftToRight
    Color = clBtnFace
    Columns = 5
    Ctl3D = True
    DoubleBuffered = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      #1085#1086#1084#1077#1088#1072
      #1094#1074#1077#1090#1072
      #1082#1086#1083#1080#1095#1077#1089#1090#1074#1086)
    ParentBiDiMode = False
    ParentBackground = False
    ParentColor = False
    ParentCtl3D = False
    ParentDoubleBuffered = False
    ParentFont = False
    ParentShowHint = False
    RadioTabStop = False
    ShowFrame = False
    ShowHint = False
    TabOrder = 1
    OnClick = rgInformClick
    ExplicitTop = 464
    ExplicitWidth = 362
    ExplicitHeight = 49
  end
  object selector: TComboBox
    Left = 547
    Top = 449
    Width = 112
    Height = 23
    Align = alRight
    ItemIndex = 0
    TabOrder = 2
    Text = #1086#1088#1080#1075#1080#1085#1072#1083#1100#1085#1099#1077
    OnCloseUp = selectorCloseUp
    Items.Strings = (
      #1086#1088#1080#1075#1080#1085#1072#1083#1100#1085#1099#1077
      'RAL classic'
      #1090#1088#1072#1076#1080#1094#1080#1086#1085#1085#1099#1077)
    ExplicitLeft = 474
    ExplicitTop = 305
  end
  object ColorDialog1: TColorDialog
    Options = [cdSolidColor, cdAnyColor]
    Left = 104
    Top = 192
  end
end
