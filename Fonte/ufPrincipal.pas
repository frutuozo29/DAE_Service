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
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure AppEventsMinimize(Sender: TObject);
    procedure TrayIconDblClick(Sender: TObject);
    procedure onGrupoExpande(Sender: TObject);
    procedure btnConfigBDClick(Sender: TObject);
    procedure btnConfigAPIClick(Sender: TObject);
    procedure btnIniciarServicoClick(Sender: TObject);
    procedure btnPararServicoClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure TimerExecucaoTimer(Sender: TObject);
    procedure AppEventsException(Sender: TObject; E: Exception);
  private
    { Private declarations }
    FFTDI: TFTDI;
    procedure Status;
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

uses ufrmConexaoBD, ufrmConfigAPI, uAplicacao, uDMApi, uRegistry, IwSystem, uFuncoesIni, System.DateUtils, uLogExecucao;

procedure TfPrincipal.AppEventsException(Sender: TObject; E: Exception);
begin
  GetLog.RegistrarLog('----------------------------');
  GetLog.RegistrarLog('Ocorreu um erro na aplicação. Erro: '+ E.Message);
  GetLog.RegistrarLog('----------------------------');
end;

procedure TfPrincipal.AppEventsMinimize(Sender: TObject);
begin
  Self.Hide;
  Self.WindowState := wsMinimized;
  TrayIcon.Visible := True;
  TrayIcon.Animate := True;
  TrayIcon.ShowBalloonHint;
end;

procedure TfPrincipal.btnConfigAPIClick(Sender: TObject);
begin
  FTDI.GetTDI.MostrarFormulario(TfrmConfigAPI, False);
end;

procedure TfPrincipal.btnConfigBDClick(Sender: TObject);
begin
  FTDI.GetTDI.MostrarFormulario(TfrmConexaoBD, False);
end;

procedure TfPrincipal.btnIniciarServicoClick(Sender: TObject);
begin
  if not GetAplicacao.StatusDoServico then
  begin
    GetAplicacao.StatusDoServico := True;
    Status;
  end;
end;

procedure TfPrincipal.btnPararServicoClick(Sender: TObject);
begin
  if GetAplicacao.StatusDoServico then
  begin
    GetAplicacao.StatusDoServico := False;
    Status;
  end;
end;

procedure TfPrincipal.Button1Click(Sender: TObject);
begin
  DMApi.ExecutarIntegracao;
end;

procedure TfPrincipal.FormCreate(Sender: TObject);
begin
  FTDI := TFTDI.create(Self, TfInicio);
  Status;

  TRegistro.RunOnStartup('DAEService', gsAppPath + gsAppName + '.exe');
end;

procedure TfPrincipal.TimerExecucaoTimer(Sender: TObject);
var
  HoraEnvio, DataHoraUltimoEnvio: TDateTime;
begin
  DataHoraUltimoEnvio := StrToDateTime( TFuncoesIni.LerIni('CONFIGURACAO_API', 'DataHoraUltimoEnvio', '0') );
  HoraEnvio := StrToTimeDef(TFuncoesIni.LerIni('CONFIGURACAO_API','HoraEnvio'), Now);

  if (DateOf(DataHoraUltimoEnvio) = DateOf(Now)) then
    Exit;


  if FormatDateTime('hh:mm', HoraEnvio) = FormatDateTime('hh:mm', now) then
  begin
    DMApi.ExecutarIntegracao;
    TFuncoesIni.GravarIni('CONFIGURACAO_API', 'DataHoraUltimoEnvio', DateTimeToStr(Now));
  end;
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

procedure TfPrincipal.Status;
var
  aStatus: Boolean;
begin
  aStatus := GetAplicacao.StatusDoServico;
  btnIniciarServico.Enabled := not aStatus;
  btnPararServico.Enabled := aStatus;
end;

end.
