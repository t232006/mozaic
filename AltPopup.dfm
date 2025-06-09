object PopupForm: TPopupForm
  Left = 0
  Top = 0
  Caption = 'PopupForm'
  ClientHeight = 477
  ClientWidth = 736
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object Shape2: TShape
    Left = 23
    Top = 12
    Width = 97
    Height = 57
  end
  object Shape3: TShape
    Left = 126
    Top = 12
    Width = 97
    Height = 57
  end
  object DBCtrlGrid1: TDBCtrlGrid
    Left = 0
    Top = 81
    Width = 736
    Height = 396
    Align = alBottom
    DataSource = DataSource
    PanelHeight = 66
    PanelWidth = 719
    TabOrder = 0
    RowCount = 6
    OnClick = DBCtrlGrid1Click
    OnPaintPanel = DBCtrlGrid1PaintPanel
    object Shape1: TShape
      Left = 15
      Top = 4
      Width = 97
      Height = 57
    end
    object DBText1: TDBText
      Left = 320
      Top = 16
      Width = 329
      Height = 33
      DataField = 'name'
      DataSource = DataSource
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object DBText2: TDBText
      Left = 184
      Top = 4
      Width = 65
      Height = 17
      DataSource = DataSource
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object DBText3: TDBText
      Left = 184
      Top = 22
      Width = 65
      Height = 17
      DataSource = DataSource
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object DBText4: TDBText
      Left = 184
      Top = 40
      Width = 65
      Height = 17
      DataSource = DataSource
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 160
      Top = 4
      Width = 6
      Height = 21
      Caption = 'r'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 160
      Top = 22
      Width = 9
      Height = 21
      Caption = 'g'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 160
      Top = 40
      Width = 9
      Height = 21
      Caption = 'b'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object DBText5: TDBText
      Left = 544
      Top = 40
      Width = 65
      Height = 17
      DataSource = DataSource
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsItalic]
      ParentFont = False
    end
  end
  object DataSource: TDataSource
    Left = 592
    Top = 8
  end
end
