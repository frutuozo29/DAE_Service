object fPrincipal: TfPrincipal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'DAE-Service'
  ClientHeight = 500
  ClientWidth = 680
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Menu: TCategoryPanelGroup
    Left = 0
    Top = 0
    Height = 500
    VertScrollBar.Tracking = True
    HeaderFont.Charset = DEFAULT_CHARSET
    HeaderFont.Color = clWindowText
    HeaderFont.Height = -11
    HeaderFont.Name = 'Tahoma'
    HeaderFont.Style = []
    TabOrder = 0
    object cpConfiguracoes: TCategoryPanel
      AlignWithMargins = True
      Top = 120
      Height = 177
      Caption = 'Configura'#231#245'es'
      TabOrder = 1
      OnExpand = onGrupoExpande
      object btnConfigBD: TButton
        Left = 0
        Top = 0
        Width = 190
        Height = 41
        Align = alTop
        Caption = 'Banco de Dados'
        TabOrder = 0
        OnClick = btnConfigBDClick
      end
      object btnConfigAPI: TButton
        Left = 0
        Top = 41
        Width = 190
        Height = 41
        Align = alTop
        Caption = 'Configura'#231#245'es da API'
        TabOrder = 1
        OnClick = btnConfigAPIClick
      end
      object Button1: TButton
        Left = 56
        Top = 104
        Width = 75
        Height = 25
        Caption = 'Button1'
        TabOrder = 2
        OnClick = Button1Click
      end
    end
    object cpInicializacao: TCategoryPanel
      AlignWithMargins = True
      Top = 3
      Height = 111
      BiDiMode = bdLeftToRight
      Caption = 'Inicializa'#231#227'o'
      ParentBiDiMode = False
      TabOrder = 0
      OnExpand = onGrupoExpande
      object btnIniciarServico: TButton
        Left = 0
        Top = 0
        Width = 190
        Height = 41
        Align = alTop
        Caption = 'Iniciar Servi'#231'o'
        TabOrder = 0
        OnClick = btnIniciarServicoClick
      end
      object btnPararServico: TButton
        Left = 0
        Top = 41
        Width = 190
        Height = 41
        Align = alTop
        Caption = 'Parar Servi'#231'o'
        TabOrder = 1
        OnClick = btnPararServicoClick
      end
    end
  end
  object AppEvents: TApplicationEvents
    OnException = AppEventsException
    OnMinimize = AppEventsMinimize
    Left = 312
    Top = 8
  end
  object TrayIcon: TTrayIcon
    Animate = True
    BalloonHint = 'Servi'#231'o rodando...'
    BalloonTitle = 'DAE-Service'
    Visible = True
    OnDblClick = TrayIconDblClick
    Left = 376
    Top = 8
  end
  object TimerExecucao: TTimer
    OnTimer = TimerExecucaoTimer
    Left = 464
    Top = 32
  end
  object FDGUIxErrorDialog1: TFDGUIxErrorDialog
    Provider = 'Forms'
    Left = 320
    Top = 72
  end
end
