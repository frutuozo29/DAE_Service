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
    procedure PrepararEnviarJson;
    procedure EnviarJson(aJson: String);
  public
    { Public declarations }
    procedure ExecutarIntegracao;
  end;

var
  DMApi: TDMApi;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses uDMConexao, REST.JSON, System.JSON, uClassesAPI, uLogExecucao;

{$R *.dfm}

{ TDMApi }

procedure TDMApi.AbreConsulta;
begin
  QryConsulta.Close;
  QryConsulta.Open;
  GetLog.RegistrarLog('Realizando consulta no banco de dados.');
end;

procedure TDMApi.EnviarJson(aJson: String);
var
  Response: String;
  JsonToSend : TStringStream;
  Lista: TStringList;
begin
  GetLog.RegistrarLog('Enviando dados para o Web Service.');
  JsonToSend := TStringStream.Create( UTF8Encode(aJson) );
  Lista := TStringList.Create;
  try
    idHTTP.Request.Method          := 'POST';
    idHTTP.Request.ContentType     := 'application/json';
    idHTTP.Request.ContentEncoding := 'UTF-8';
    try
      Response := idHTTP.Post('http://webapiaccord.elasticbeanstalk.com/Accord/api/Empresa/CadastrarEmpresaComNotaFiscal', JsonToSend);
      Lista.Add(Response);

    except
      on E: Exception do
        GetLog.RegistrarLog('Ocorreu um erro ao enviar os dados. Fim da execução. Erro:'+E.Message);
    end;
  finally
    FreeAndNil(JsonToSend);
    Lista.SaveToFile('C:\projetos\Response.txt');
    FreeAndNil(Lista);
  end;
  GetLog.RegistrarLog('Fim do envio dos dados para o Web Service.');
end;

procedure TDMApi.ExecutarIntegracao;
begin
  GetLog.RegistrarLog('Iniciando o processo de envio dos dados para o Web Service.');
  AbreConsulta;
  if QryConsulta.IsEmpty then
  begin
    GetLog.RegistrarLog('A Consulta não retornou resultado.');
    Exit;
  end;
  PrepararEnviarJson;
  GetLog.RegistrarLog('Fim do processo de envio dos dados para o Web Service.');
  GetLog.RegistrarLog('-------------------------------------------------------');
end;

procedure TDMApi.PrepararEnviarJson;
var
  Empresa: String;
  ArrayJSon:TJSONArray;
  EmpresaNotas: TEmpresaNotas;
//  Lista: TStringList;
begin
  QryConsulta.First;
  try
    ArrayJson := TJSONArray.Create;
//    Lista := TStringList.Create;
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
//    Lista.Add(ArrayJson.ToString);
//    Lista.SaveToFile('C:\Projetos\JsonEmpresa.json');
    GetLog.RegistrarLog('Fim da construção do Json que será enviado para o Web Service.');
    EnviarJson(ArrayJson.ToString);
  finally
    FreeAndNil(EmpresaNotas);
    FreeAndNil(ArrayJSon);
//    FreeAndNil(Lista);
  end;
end;

end.
