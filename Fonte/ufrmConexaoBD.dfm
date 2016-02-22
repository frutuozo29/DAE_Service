inherited frmConexaoBD: TfrmConexaoBD
  Caption = 'Banco de Dados'
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnTop: TPanel
    inherited lblNomeForm: TLabel
      Width = 235
      Caption = 'Tela de Configura'#231#227'o do Banco de Dados'
      ExplicitWidth = 235
    end
  end
  inherited pnForm: TPanel
    object Label7: TLabel
      Left = 41
      Top = 41
      Width = 45
      Height = 13
      Caption = 'Caminho:'
    end
    object Label8: TLabel
      Left = 46
      Top = 72
      Width = 40
      Height = 13
      Caption = 'Usu'#225'rio:'
    end
    object Label9: TLabel
      Left = 227
      Top = 72
      Width = 34
      Height = 13
      Caption = 'Senha:'
    end
    object SpeedButton2: TSpeedButton
      Left = 428
      Top = 37
      Width = 23
      Height = 22
      Caption = '...'
      OnClick = SpeedButton2Click
    end
    object Label1: TLabel
      Left = 5
      Top = 11
      Width = 81
      Height = 13
      Caption = 'Banco de Dados:'
    end
    object edtCaminho: TEdit
      Left = 89
      Top = 38
      Width = 338
      Height = 21
      AutoSize = False
      TabOrder = 1
    end
    object edtUser: TEdit
      Left = 89
      Top = 69
      Width = 130
      Height = 21
      AutoSize = False
      TabOrder = 2
    end
    object edtSenha: TEdit
      Left = 265
      Top = 69
      Width = 130
      Height = 21
      AutoSize = False
      PasswordChar = '*'
      TabOrder = 3
    end
    object btnConectar: TButton
      Left = 398
      Top = 68
      Width = 53
      Height = 22
      Caption = 'Conectar'
      TabOrder = 4
      OnClick = btnConectarClick
    end
    object cbxTipobanco: TComboBox
      Left = 89
      Top = 8
      Width = 90
      Height = 22
      Style = csOwnerDrawFixed
      ItemIndex = 0
      TabOrder = 0
      Text = 'Firebird'
      Items.Strings = (
        'Firebird'
        'SQL Server')
    end
    object llbUsuarioPadrao: TLinkLabel
      Left = 5
      Top = 98
      Width = 199
      Height = 17
      Caption = '<a>Utilizar usu'#225'rio e senha padr'#227'o do banco</a>'
      TabOrder = 5
      OnClick = llbUsuarioPadraoClick
    end
  end
  object FileOpenDialog: TFileOpenDialog
    DefaultFolder = 'C:\'
    FavoriteLinks = <>
    FileTypes = <>
    OkButtonLabel = 'Selecionar'
    Options = []
    Left = 216
    Top = 192
  end
end
