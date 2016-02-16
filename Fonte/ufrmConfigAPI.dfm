inherited frmConfigAPI: TfrmConfigAPI
  Caption = 'Configura'#231#245'es da API'
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnTop: TPanel
    inherited lblNomeForm: TLabel
      Width = 169
      Caption = 'Tela de Configura'#231#245'es da API'
      ExplicitWidth = 169
    end
  end
  inherited pnForm: TPanel
    ExplicitTop = 44
    object GroupBox1: TGroupBox
      Left = 9
      Top = 6
      Width = 434
      Height = 103
      Caption = '   Servidor de Email  '
      TabOrder = 0
      object Panel1: TPanel
        Left = 2
        Top = 15
        Width = 430
        Height = 86
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        ExplicitHeight = 106
        object Label1: TLabel
          Left = 8
          Top = 9
          Width = 73
          Height = 13
          Caption = 'Servidor SMTP:'
        end
        object Label2: TLabel
          Left = 41
          Top = 34
          Width = 40
          Height = 13
          Caption = 'Usu'#225'rio:'
        end
        object Label3: TLabel
          Left = 47
          Top = 60
          Width = 34
          Height = 13
          Caption = 'Senha:'
        end
        object edtServidor: TEdit
          Left = 84
          Top = 6
          Width = 322
          Height = 21
          TabOrder = 0
        end
        object llbAjudaSMTP: TLinkLabel
          Left = 412
          Top = 5
          Width = 13
          Height = 22
          Caption = '<a>?</a>'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = llbAjudaSMTPClick
        end
        object edtUsuario: TEdit
          Left = 84
          Top = 31
          Width = 221
          Height = 21
          TabOrder = 2
        end
        object edtSenha: TEdit
          Left = 84
          Top = 57
          Width = 125
          Height = 21
          PasswordChar = '*'
          TabOrder = 3
        end
      end
    end
    object GroupBox2: TGroupBox
      Left = 9
      Top = 115
      Width = 434
      Height = 218
      Caption = '   Configura'#231#245'es Gerais   '
      TabOrder = 1
      object Label4: TLabel
        Left = 12
        Top = 24
        Width = 71
        Height = 13
        Caption = 'Emails de Erro:'
      end
      object lblExecucao: TLabel
        Left = 12
        Top = 48
        Width = 71
        Height = 13
        Caption = 'Hora de Envio:'
      end
      object edtEmailsErro: TEdit
        Left = 86
        Top = 21
        Width = 322
        Height = 21
        TabOrder = 0
      end
      object dtpHora: TDateTimePicker
        Left = 86
        Top = 46
        Width = 82
        Height = 21
        Date = 0.333333333333333300
        Time = 0.333333333333333300
        Kind = dtkTime
        TabOrder = 1
      end
    end
  end
end
