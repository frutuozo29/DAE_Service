unit uDMApi;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP;

type
  TDMApi = class(TDataModule)
    QryConsulta: TFDQuery;
    QryConsultaNOME: TStringField;
    QryConsultaCGCCPF: TStringField;
    QryConsultaNF: TStringField;
    QryConsultaEMAIL: TStringField;
    QryConsultaCHAVENFE: TStringField;
    IdHTTP: TIdHTTP;
  private
    { Private declarations }
    procedure AbreConsulta;
    function PrepararEnviarJson: Boolean;
    function EnviarJson(aJson: String): Boolean;
  public
    { Public declarations }
    function ExecutarIntegracao: Boolean;
    procedure EnviarEmail(aCorpo: String);
  end;

var
  DMApi: TDMApi;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses uDMConexao, REST.JSON, System.JSON, iwSystem, uClassesAPI, uLogExecucao, uFuncoesIni, uEnviaEmail;

{$R *.dfm}

{ TDMApi }

procedure TDMApi.AbreConsulta;
begin
  QryConsulta.Close;
  if FileExists(gsAppPath+ '\Consulta.sql') then
  begin
    QryConsulta.SQL.LoadFromFile(gsAppPath+ '\Consulta.sql');
    try
      QryConsulta.Open;
    except
      on e: Exception do
        GetLog.RegistrarLog('Erro ao Abrir SQL. Erro: '+ E.Message);
    end;
  end
  else
    GetLog.RegistrarLog('SQL de consulta não foi encontrado na pasta da aplicação.');
  GetLog.RegistrarLog('Realizando consulta no banco de dados.');
end;

procedure TDMApi.EnviarEmail(aCorpo: String);
var
  email: TEnviarEmail;
begin
  try
    email := TEnviarEmail.Create;
    email.Host := TFuncoesIni.LerIni('CONFIGURACAO_API','ServidorSmtp');
    email.Email := TFuncoesIni.LerIni('CONFIGURACAO_API','UsuarioSmtp');
    email.Senha := TFuncoesIni.LerIni('CONFIGURACAO_API','SenhaSmtp');
    email.Port := StrToIntDef(TFuncoesIni.LerIni('CONFIGURACAO_API','PortaSmtp'), 546);
    email.EmailDestino := TFuncoesIni.LerIni('CONFIGURACAO_API','EmailErro');
    email.TituloEmail := '';
  finally
    FreeAndNil(email);
  end;

end;

function TDMApi.EnviarJson(aJson: String): Boolean;
var
  Response: String;
  JsonToSend : TStringStream;
begin
  Result := False;
  GetLog.RegistrarLog('Enviando dados para o Web Service.');
  JsonToSend := TStringStream.Create( UTF8Encode(aJson) );
  try
    idHTTP.Request.Method          := 'POST';
    idHTTP.Request.ContentType     := 'application/json';
    idHTTP.Request.ContentEncoding := 'UTF-8';
    try
      Response := idHTTP.Post('http://webapiaccord.elasticbeanstalk.com/Accord/api/Empresa/CadastrarEmpresaComNotaFiscal', JsonToSend);
      Result := True;
    except
      on E: Exception do
      begin
        Result := False;
        GetLog.RegistrarLog('Ocorreu um erro ao enviar os dados. Fim da execução. Erro:'+E.Message);
      end;
    end;
  finally
    FreeAndNil(JsonToSend);
  end;
  GetLog.RegistrarLog('Fim do envio dos dados para o Web Service.');
end;

function TDMApi.ExecutarIntegracao: Boolean;
var
  QtdeTentativas, Tentativas: Integer;
begin
  Result := False;
  Tentativas := 0;
  QtdeTentativas := StrToIntDef( TFuncoesIni.LerIni('CONFIGURACAO_API', 'TentativasEnvio', '1'), 1);

  while not (QtdeTentativas = Tentativas) or Result do
  begin
    Inc(Tentativas);
    GetLog.RegistrarLog('Iniciando o processo de envio dos dados para o Web Service.');
    AbreConsulta;
    if QryConsulta.IsEmpty then
    begin
      GetLog.RegistrarLog('A Consulta não retornou resultado.');
      GetLog.RegistrarLog('Fim do processo de envio dos dados para o Web Service.');
      GetLog.RegistrarLog('-------------------------------------------------------');
      Exit;
    end;
    Result := PrepararEnviarJson;
    GetLog.RegistrarLog('Fim do processo de envio dos dados para o Web Service.');
    GetLog.RegistrarLog('-------------------------------------------------------');
  end;
end;

function TDMApi.PrepararEnviarJson: Boolean;
var
  Empresa: String;
  ArrayJSon:TJSONArray;
  EmpresaNotas: TEmpresaNotas;
begin
  Result := False;
  QryConsulta.First;
  try
    try
      ArrayJson := TJSONArray.Create;
      GetLog.RegistrarLog('Iniciando a construção do Json que será enviado para o Web Service.');
      while not QryConsulta.Eof do
      begin
        if Empresa <> QryConsultaCGCCPF.AsString then
        begin
          Empresa := QryConsultaCGCCPF.AsString;
          EmpresaNotas := TEmpresaNotas.Create;
          EmpresaNotas.Empresa.Nome := QryConsultaNOME.AsString;
          EmpresaNotas.Empresa.CNPJ := QryConsultaCGCCPF.AsString;
          EmpresaNotas.Empresa.Email := QryConsultaEMAIL.AsString;
        end;

        EmpresaNotas.AddElementOnArray(QryConsultaCHAVENFE.AsString);
        QryConsulta.Next;
        if (Empresa <> QryConsultaCGCCPF.AsString) or (QryConsulta.Eof) then
          ArrayJSon.AddElement(TJSON.ObjectToJsonObject(EmpresaNotas));
      end;
      GetLog.RegistrarLog('Fim da construção do Json que será enviado para o Web Service.');
    except
      on E: Exception do
      begin
        Result := False;
        GetLog.RegistrarLog('Ocorreu um erro ao criar o Json de envio para o Web Service.');
        Exit;
      end;
    end;
    Result := EnviarJson(ArrayJson.ToString);
  finally
    FreeAndNil(EmpresaNotas);
    FreeAndNil(ArrayJSon);
  end;
end;

end.
