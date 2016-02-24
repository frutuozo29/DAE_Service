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
      Top = 39
      Height = 30
      Caption = 'Configura'#231#245'es'
      Collapsed = True
      TabOrder = 1
      OnExpand = onGrupoExpande
      ExpandedHeight = 111
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
    end
    object cpInicializacao: TCategoryPanel
      AlignWithMargins = True
      Top = 3
      Height = 30
      BiDiMode = bdLeftToRight
      Caption = 'Inicializa'#231#227'o'
      Collapsed = True
      ParentBiDiMode = False
      TabOrder = 0
      OnExpand = onGrupoExpande
      ExpandedHeight = 111
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
