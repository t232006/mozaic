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
  TextHeight = 15
  object Dg: TDrawGrid
    Left = 0
    Top = 0
    Width = 341
    Height = 294
    Align = alClient
    Color = clScrollBar
    ColCount = 2
    DrawingStyle = gdsClassic
    FixedCols = 0
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goFixedColDefAlign]
    TabOrder = 0
    OnDrawCell = DgDrawCell
    ExplicitWidth = 337
    ExplicitHeight = 293
    RowHeights = (
      26
      24
      25
      24
      24)
  end
end
