object fInicio: TfInicio
  Left = 0
  Top = 0
  Caption = 'Bem-Vindo'
  ClientHeight = 192
  ClientWidth = 317
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 144
    Width = 317
    Height = 48
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      317
      48)
    object Label1: TLabel
      Left = 80
      Top = 9
      Width = 232
      Height = 13
      Anchors = [akRight, akBottom]
      Caption = 'Copyright '#169' 2015 -  I2B Tecnologia em Sistemas'
    end
    object Label2: TLabel
      Left = 219
      Top = 26
      Width = 93
      Height = 13
      Anchors = [akRight, akBottom]
      Caption = 'All Rights Reserved'
      ExplicitTop = 98
    end
  end
end
