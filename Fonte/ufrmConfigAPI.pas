unit ufrmConfigAPI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ufrmBasic, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TfrmConfigAPI = class(TfrmBasic)
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    Label1: TLabel;
    edtServidor: TEdit;
    llbAjudaSMTP: TLinkLabel;
    Label2: TLabel;
    edtUsuario: TEdit;
    Label3: TLabel;
    edtSenha: TEdit;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    edtEmailsErro: TEdit;
    lblExecucao: TLabel;
    dtpHora: TDateTimePicker;
    procedure llbAjudaSMTPClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure SalvarConfiguracoes;
    procedure LoadConfiguracoes;
  public
    { Public declarations }
  end;

var
  frmConfigAPI: TfrmConfigAPI;

implementation

{$R *.dfm}

uses uMensagem, uFuncoesIni;

procedure TfrmConfigAPI.btnSairClick(Sender: TObject);
begin
  if TMensagem.Pergunta('Salvar configurações?') then
    SalvarConfiguracoes;
  inherited;
end;

procedure TfrmConfigAPI.FormShow(Sender: TObject);
begin
  inherited;
  LoadConfiguracoes;
end;

procedure TfrmConfigAPI.llbAjudaSMTPClick(Sender: TObject);
var
  Ajudinha: TStringList;
begin
  inherited;
  try
    Ajudinha := TStringList.Create;
    Ajudinha.Add('Gmail                                   ');
    Ajudinha.Add('Servidor: smtp.gmail.com                ');
    Ajudinha.Add('   Porta: 465                           ');
    Ajudinha.Add('                                        ');
    Ajudinha.Add('Yahoo                                   ');
    Ajudinha.Add('Servidor: smtp.mail.yahoo.com.br        ');
    Ajudinha.Add('   Porta: 465                           ');
    Ajudinha.Add('                                        ');
    Ajudinha.Add('Hotmail / Live                          ');
    Ajudinha.Add('Servidor: smtp.live.com                 ');
    Ajudinha.Add('   Porta: 587                           ');
    Ajudinha.Add('                                        ');
    Ajudinha.Add('Secrel                                  ');
    Ajudinha.Add('Servidor: smtpaut.secrel.com.br         ');
    Ajudinha.Add('   Porta: 465                           ');
    Ajudinha.Add('                                        ');
    Ajudinha.Add('Informar usuário e senha                ');
    Ajudinha.Add('');
    TMensagem.Informar(Ajudinha.Text);
  finally
    FreeAndNil(Ajudinha);
  end;
end;

procedure TfrmConfigAPI.LoadConfiguracoes;
begin
  edtServidor.Text := TFuncoesIni.LerIni('CONFIGURACAO_API','ServidorSmtp');
  edtUsuario.Text := TFuncoesIni.LerIni('CONFIGURACAO_API','UsuarioSmtp');
  edtSenha.Text := TFuncoesIni.LerIni('CONFIGURACAO_API','SenhaSmtp');
  edtEmailsErro.Text := TFuncoesIni.LerIni('CONFIGURACAO_API','EmailErro');
  dtpHora.Time := StrToTimeDef(TFuncoesIni.LerIni('CONFIGURACAO_API','HoraEnvio'), Now);
end;

procedure TfrmConfigAPI.SalvarConfiguracoes;
begin
  TFuncoesIni.GravarIni('CONFIGURACAO_API','ServidorSmtp', edtServidor.Text);
  TFuncoesIni.GravarIni('CONFIGURACAO_API','UsuarioSmtp', edtUsuario.Text);
  TFuncoesIni.GravarIni('CONFIGURACAO_API','SenhaSmtp', edtSenha.Text);
  TFuncoesIni.GravarIni('CONFIGURACAO_API','EmailErro', edtEmailsErro.Text);
  TFuncoesIni.GravarIni('CONFIGURACAO_API','HoraEnvio', TimeToStr(dtpHora.Time));
end;

end.
