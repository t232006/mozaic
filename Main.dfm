object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 442
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  TextHeight = 15
  object pg: TPaintGrid
    Left = 0
    Top = 0
    Width = 161
    Height = 161
    DefaultColWidth = 24
    FixedCols = 0
    FixedRows = 0
    TabOrder = 0
    currentColor = clBlack
  end
  object Button1: TButton
    Left = 408
    Top = 288
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
    OnClick = Button1Click
  end
end