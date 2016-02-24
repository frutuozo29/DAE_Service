unit ufPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, uFTDI,
  ufInicio, Vcl.AppEvnts, FireDAC.UI.Intf,
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
    btnSQL: TButton;
    procedure FormCreate(Sender: TObject);
    procedure AppEventsMinimize(Sender: TObject);
    procedure TrayIconDblClick(Sender: TObject);
    procedure onGrupoExpande(Sender: TObject);
    procedure btnConfigBDClick(Sender: TObject);
    procedure btnConfigAPIClick(Sender: TObject);
    procedure btnIniciarServicoClick(Sender: TObject);
    procedure btnPararServicoClick(Sender: TObject);
    procedure TimerExecucaoTimer(Sender: TObject);
    procedure AppEventsException(Sender: TObject; E: Exception);
    procedure btnSQLClick(Sender: TObject);
  private
    { Private declarations }
    FFTDI: TFTDI;
    procedure Status;
    function VersaoExe: String;
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

uses ufrmConexaoBD, ufrmConfigAPI, uAplicacao, uDMApi, uRegistry, IwSystem,
  uFuncoesIni, System.DateUtils, uLogExecucao,
  uDMConexao, ufrmSqlConsulta, uMensagem;

procedure TfPrincipal.AppEventsException(Sender: TObject; E: Exception);
begin
  GetLog.RegistrarLog('----------------------------');
  GetLog.RegistrarLog('Ocorreu um erro na aplicação. Erro: ' + E.Message);
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

procedure TfPrincipal.btnSQLClick(Sender: TObject);
var
  Senha: String;
begin
  InputQuery('Informa a senha.', 'Informa a senha.', Senha);

  if Senha.Equals('i2b@2016') then
    FTDI.GetTDI.MostrarFormulario(TfrmSqlConsulta, False)
  else
    TMensagem.Informar('Senha incorreta!');
end;

procedure TfPrincipal.FormCreate(Sender: TObject);
begin
  FTDI := TFTDI.create(Self, TfInicio);
  Status;

  TRegistro.RunOnStartup('DAEService', gsAppPath + gsAppName + '.exe');
  Self.Caption := 'DAE-Service  Versão ' + VersaoExe;
end;

procedure TfPrincipal.TimerExecucaoTimer(Sender: TObject);
var
  HoraEnvio, DataHoraUltimoEnvio: TDateTime;
begin
  DataHoraUltimoEnvio := StrToDateTime(TFuncoesIni.LerIni('CONFIGURACAO_API',
    'DataHoraUltimoEnvio', '0'));
  HoraEnvio := StrToTimeDef(TFuncoesIni.LerIni('CONFIGURACAO_API',
    'HoraEnvio'), Now);

  if (DateOf(DataHoraUltimoEnvio) = DateOf(Now)) then
    Exit;

  if FormatDateTime('hh:mm', HoraEnvio) = FormatDateTime('hh:mm', Now) then
  begin
    if not DMConexao.FDConn.Connected then
    begin
      GetLog.RegistrarLog
        ('O Banco de dados está desconectado, não é possível enviar os dados.');
      TFuncoesIni.GravarIni('CONFIGURACAO_API', 'DataHoraUltimoEnvio',
        DateTimeToStr(Now));
      Exit;
    end;
    DMApi.ExecutarIntegracao;
    TFuncoesIni.GravarIni('CONFIGURACAO_API', 'DataHoraUltimoEnvio',
      DateTimeToStr(Now));
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

Function TfPrincipal.VersaoExe: String;
type
  PFFI = ^vs_FixedFileInfo;
var
  F: PFFI;
  Handle: Dword;
  Len: Longint;
  Data: Pchar;
  Buffer: Pointer;
  Tamanho: Dword;
  Parquivo: Pchar;
  Arquivo: String;
begin
  Arquivo := Application.ExeName;
  Parquivo := StrAlloc(Length(Arquivo) + 1);
  StrPcopy(Parquivo, Arquivo);
  Len := GetFileVersionInfoSize(Parquivo, Handle);
  Result := '';
  if Len > 0 then
  begin
    Data := StrAlloc(Len + 1);
    if GetFileVersionInfo(Parquivo, Handle, Len, Data) then
    begin
      VerQueryValue(Data, '\', Buffer, Tamanho);
      F := PFFI(Buffer);
      Result := Format('%d.%d.%d.%d', [HiWord(F^.dwFileVersionMs),
        LoWord(F^.dwFileVersionMs), HiWord(F^.dwFileVersionLs),
        LoWord(F^.dwFileVersionLs)]);
    end;
    StrDispose(Data);
  end;
  StrDispose(Parquivo);
end;

end.
