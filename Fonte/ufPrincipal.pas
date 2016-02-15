unit ufPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, uFTDI, ufInicio, Vcl.AppEvnts, FireDAC.UI.Intf,
  FireDAC.VCLUI.Error, FireDAC.Stan.Error, FireDAC.Stan.Intf, FireDAC.Comp.UI;

type
  TfPrincipal = class(TForm)
    Menu: TCategoryPanelGroup;
    cpInicializacao: TCategoryPanel;
    cpConfiguracoes: TCategoryPanel;
    btnIniciarServico: TButton;
    btnPararServico: TButton;
    AppEvents: TApplicationEvents;
    TrayIcon: TTrayIcon;
    TimerExecucao: TTimer;
    btnConfigBD: TButton;
    btnConfigAPI: TButton;
    FDGUIxErrorDialog1: TFDGUIxErrorDialog;
    procedure FormCreate(Sender: TObject);
    procedure AppEventsMinimize(Sender: TObject);
    procedure TrayIconDblClick(Sender: TObject);
    procedure onGrupoExpande(Sender: TObject);
    procedure btnConfigBDClick(Sender: TObject);
  private
    FFTDI: TFTDI;

    { Private declarations }
  public
    { Public declarations }
    property FTDI: TFTDI read FFTDI write FFTDI;
  end;

var
  fPrincipal: TfPrincipal;

const
  WM_CLOSE_TAB = WM_USER + 1;

implementation

{$R *.dfm}

uses ufrmConexaoBD;

procedure TfPrincipal.AppEventsMinimize(Sender: TObject);
begin
  Self.Hide;
  Self.WindowState := wsMinimized;
  TrayIcon.Visible := True;
  TrayIcon.Animate := True;
  TrayIcon.ShowBalloonHint;
end;

procedure TfPrincipal.btnConfigBDClick(Sender: TObject);
begin
  FTDI.GetTDI.MostrarFormulario(TfrmConexaoBD, False);
end;

procedure TfPrincipal.FormCreate(Sender: TObject);
begin
  FTDI := TFTDI.create(Self, TfInicio);
end;

procedure TfPrincipal.TrayIconDblClick(Sender: TObject);
begin
  TrayIcon.Visible := False;
  Show;
  WindowState := wsNormal;
  Application.BringToFront;
end;

procedure TfPrincipal.onGrupoExpande(Sender: TObject);
begin
  Menu.CollapseAll;
  TCategoryPanel(Sender).OnExpand := nil;
  TCategoryPanel(Sender).Expand;
  TCategoryPanel(Sender).OnExpand := onGrupoExpande;
end;

end.
