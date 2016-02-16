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

uses uDMConexao, REST.JSON, System.JSON, uClassesAPI;

{$R *.dfm}

{ TDMApi }

procedure TDMApi.AbreConsulta;
begin
  QryConsulta.Close;
  QryConsulta.Open;
end;

procedure TDMApi.EnviarJson(aJson: String);
var
  Response: String;
  JsonToSend : TStringStream;
  Lista: TStringList;
begin
  JsonToSend := TStringStream.Create( UTF8Encode(aJson) );
  Lista := TStringList.Create;
  try
    idHTTP.Request.Method          := 'POST';
    idHTTP.Request.ContentType     := 'application/json';
    idHTTP.Request.ContentEncoding := 'utf-8';

    try
      Response := idHTTP.Post('http://webapiaccord.elasticbeanstalk.com/Accord/api/Empresa/CadastrarEmpresaComNotaFiscal', JsonToSend);
      Lista.Add(Response);

    except
      on E: Exception do
        Lista.Add(E.Message);
    end;
  finally
    Lista.SaveToFile('C:\projetos\Response.txt');
    FreeAndNil(JsonToSend);
    FreeAndNil(Lista);
  end;
end;

procedure TDMApi.ExecutarIntegracao;
begin
  AbreConsulta;
  if QryConsulta.IsEmpty then
    Exit;
  PrepararEnviarJson;
end;

procedure TDMApi.PrepararEnviarJson;
var
  Json, Empresa: String;
  ArrayJSon:TJSONArray;
  EmpresaNotas: TEmpresaNotas;
  Lista: TStringList;
begin
  QryConsulta.First;
  try
    ArrayJson := TJSONArray.Create;
    Lista := TStringList.Create;
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
    Lista.Add(ArrayJson.ToString);
    Lista.SaveToFile('C:\Projetos\JsonEmpresa.json');
    EnviarJson(ArrayJson.ToString);
  finally
    FreeAndNil(EmpresaNotas);
    FreeAndNil(ArrayJSon);
    FreeAndNil(Lista);
  end;
end;

end.
