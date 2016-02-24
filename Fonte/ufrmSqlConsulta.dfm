inherited frmSqlConsulta: TfrmSqlConsulta
  Caption = 'SQL da Consulta'
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnForm: TPanel
    object Panel1: TPanel
      Left = 1
      Top = 298
      Width = 454
      Height = 41
      Align = alBottom
      TabOrder = 0
      ExplicitLeft = 136
      ExplicitTop = 152
      ExplicitWidth = 185
      object btnSalvar: TButton
        Left = 376
        Top = 6
        Width = 75
        Height = 25
        Caption = 'Salvar'
        TabOrder = 0
        OnClick = btnSalvarClick
      end
    end
    object mmSQL: TMemo
      Left = 1
      Top = 1
      Width = 454
      Height = 297
      Align = alClient
      TabOrder = 1
      ExplicitLeft = 136
      ExplicitTop = 128
      ExplicitWidth = 185
      ExplicitHeight = 89
    end
  end
end
