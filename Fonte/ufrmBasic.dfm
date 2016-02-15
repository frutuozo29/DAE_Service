inherited frmBasic: TfrmBasic
  Caption = 'frmBasic'
  ExplicitWidth = 462
  ExplicitHeight = 410
  PixelsPerInch = 96
  TextHeight = 13
  object pnTop: TPanel
    Left = 0
    Top = 0
    Width = 456
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lblNomeForm: TLabel
      Left = 9
      Top = 14
      Width = 80
      Height = 16
      Caption = 'Nome da Tela'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object btnSair: TButton
      AlignWithMargins = True
      Left = 419
      Top = 3
      Width = 34
      Height = 35
      Align = alRight
      Caption = 'X'
      DoubleBuffered = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Arial Black'
      Font.Style = [fsBold]
      ImageIndex = 0
      ParentDoubleBuffered = False
      ParentFont = False
      TabOrder = 0
      OnClick = btnSairClick
    end
  end
  object pnForm: TPanel
    Left = 0
    Top = 41
    Width = 456
    Height = 340
    Align = alClient
    TabOrder = 1
  end
end
