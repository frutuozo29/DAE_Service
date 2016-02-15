object fInicio: TfInicio
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Bem-Vindo'
  ClientHeight = 231
  ClientWidth = 333
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
    Top = 183
    Width = 333
    Height = 48
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 144
    ExplicitWidth = 317
    DesignSize = (
      333
      48)
    object Label1: TLabel
      Left = 96
      Top = 9
      Width = 232
      Height = 13
      Anchors = [akRight, akBottom]
      Caption = 'Copyright '#169' 2015 -  I2B Tecnologia em Sistemas'
      ExplicitLeft = 80
    end
    object Label2: TLabel
      Left = 235
      Top = 26
      Width = 93
      Height = 13
      Anchors = [akRight, akBottom]
      Caption = 'All Rights Reserved'
      ExplicitLeft = 219
      ExplicitTop = 98
    end
  end
end
