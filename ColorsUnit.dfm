object ColorsForm: TColorsForm
  Left = 0
  Top = 0
  Caption = 'ColorsForm'
  ClientHeight = 294
  ClientWidth = 341
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnActivate = FormActivate
  OnClose = FormClose
  TextHeight = 15
  object Dg: TDrawGrid
    Tag = -1
    Left = 0
    Top = 0
    Width = 341
    Height = 265
    Align = alClient
    Color = clScrollBar
    ColCount = 2
    DrawingStyle = gdsClassic
    FixedCols = 0
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goFixedColDefAlign]
    TabOrder = 0
    OnDrawCell = DgDrawCell
    OnMouseUp = DgMouseUp
    OnSelectCell = DgSelectCell
    ExplicitWidth = 331
    ExplicitHeight = 247
    RowHeights = (
      26
      24
      25
      24
      24)
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 265
    Width = 341
    Height = 29
    Align = alBottom
    ButtonHeight = 54
    ButtonWidth = 55
    Caption = 'ToolBar1'
    TabOrder = 1
    ExplicitTop = 247
    ExplicitWidth = 331
    object ToolButton1: TToolButton
      Tag = 1
      Left = 0
      Top = 0
      AllowAllUp = True
      Caption = #1085#1086#1084#1077#1088#1072
      Down = True
      Grouped = True
      ImageIndex = 0
      OnClick = ToolButton1Click
    end
    object ToolButton2: TToolButton
      Tag = 2
      Left = 55
      Top = 0
      AllowAllUp = True
      Caption = #1082#1086#1076#1099
      Grouped = True
      ImageIndex = 1
      OnClick = ToolButton1Click
    end
    object ToolButton3: TToolButton
      Tag = 3
      Left = 110
      Top = 0
      AllowAllUp = True
      Caption = #1082#1086#1083#1080#1095#1077#1089#1090#1074#1086
      Grouped = True
      ImageIndex = 2
      OnClick = ToolButton1Click
    end
    object ToolButton4: TToolButton
      Left = 165
      Top = 0
      Caption = 'ToolButton4'
      ImageIndex = 0
    end
  end
  object ColorDialog1: TColorDialog
    Left = 104
    Top = 192
  end
end
