unit uEnviaEmail;

interface

uses IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase,
  IdSMTP, IdMessage, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack,
  IdSSL, IdSSLOpenSSL, Vcl.Dialogs;

type
  TEnviarEmail = class
  private
    FEmail: String;
    FPort: Integer;
    FRemetente: String;
    FSenha: String;
    FHost: String;
    FCorpoEmail: String;
    FTituloEmail: String;
    FEmailDestino: String;
  public
    property Host: String read FHost write FHost;
    property Email: String read FEmail write FEmail;
    property Senha: String read FSenha write FSenha;
    property Port: Integer read FPort write FPort;
    property Remetente: String read FRemetente write FRemetente;
    property EmailDestino: String read FEmailDestino write FEmailDestino;
    property TituloEmail: String read FTituloEmail write FTituloEmail;
    property CorpoEmail: String read FCorpoEmail write FCorpoEmail;

    function EnviarEmail(): String;

    constructor Create(AHost, AEmail, ASenha, ARemetente, AEmailDestino,
      ATituloEmail, ACorpoEmail: String; APort: Integer;
      AEnviarAuto: Boolean = False); Overload;
  end;

function MontaMensagemEmail(AParams: array of String): WideString;

implementation

uses
  System.SysUtils;

{ TEnviarEmail }

constructor TEnviarEmail.Create(AHost, AEmail, ASenha, ARemetente,
  AEmailDestino, ATituloEmail, ACorpoEmail: String; APort: Integer;
  AEnviarAuto: Boolean);
begin
  FHost := AHost;
  FEmail := AEmail;
  FSenha := ASenha;
  FRemetente := ARemetente;
  FEmailDestino := AEmailDestino;
  FTituloEmail := ATituloEmail;
  FCorpoEmail := ACorpoEmail;
  FPort := APort;

  if AEnviarAuto then
    EnviarEmail();
end;

function TEnviarEmail.EnviarEmail(): String;
Var
  SMTPCon: TIdSMTP;
  SMTPMsg: TIdMessage;
  SMTPIOHandler: TIdSSLIOHandlerSocketOpenSSL;
begin
  try
    // Criando os Objetos para Envio
    SMTPCon := TIdSMTP.Create();
    SMTPMsg := TIdMessage.Create();
    SMTPIOHandler := TIdSSLIOHandlerSocketOpenSSL.Create();
    // Configurando o SMTP de conexão
    with SMTPCon do
    begin
      Host := FHost;
      Port := FPort;
      Username := FEmail;
      Password := FSenha;
      IOHandler := SMTPIOHandler;
      UseTLS := utUseExplicitTLS;
    end;
    // Configurando o SMTP de Envio
    with SMTPIOHandler do
    begin
      Destination := FEmailDestino;
      Host := FHost;
      Port := FPort;
      SSLOptions.Method := sslvTLSv1;
      SSLOptions.Mode := sslmUnassigned;
      SSLOptions.VerifyMode := [];
      SSLOptions.VerifyDepth := 0;
    end;
    // Configirando a MSG
    with SMTPMsg do
    begin
      Recipients.EMailAddresses := FEmailDestino;
      Subject := FTituloEmail;
      From.Address := FRemetente;
      Body.Add(FCorpoEmail);
    end;
    try
      SMTPCon.Connect();
      SMTPCon.Send(SMTPMsg);
      SMTPCon.Disconnect();
      Result := 'E-mail enviado com sucesso.';
    except
      Result := 'Ocorreu uma falha no envio do E-mail';
    end;
  finally
    FreeAndNil(SMTPCon);
    FreeAndNil(SMTPMsg);
    FreeAndNil(SMTPIOHandler);
  end;

end;

function MontaMensagemEmail(AParams: array of String): WideString;
begin
  Result := 'Olá ' + AParams[0] + #13 +
    'Suas credenciais para acesso ao sistema' + #13 + 'Login : ' + AParams[1] +
    #13 + 'Senha : ' + AParams[2] + #13 + #13 + #13 + #13 + '*** ATENÇÃO ***' +
    #13 + 'Por questões de segurança sugerimos que altere sua senha ao logar no sistema.'
    + #13 + #13 + 'Atenciosamente.'#13 + 'Equipe de Suporte - AptnessDoc';
end;

end.
