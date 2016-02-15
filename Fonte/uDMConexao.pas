unit uDMConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, Data.DB, FireDAC.Comp.Client,
  FireDAC.Phys.MSSQLDef, FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.Phys.FB, FireDAC.Phys.ODBCBase,
  FireDAC.Phys.MSSQL;

type
  TDataBaseType = (tdbFirebird, tdbSQLServer);

  TDMConexao = class(TDataModule)
    FDConnTest: TFDConnection;
    FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    FDConn: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ConectarBanco;
    function TestarConexao(User, Pass, DataBase: String; Banco: TDataBaseType): Boolean;
  end;

var
  DMConexao: TDMConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses uMensagem, uFuncoesIni;

{$R *.dfm}

procedure TDMConexao.ConectarBanco;
var
  Banco: Integer;
begin
  Banco := StrToIntDef(TFuncoesIni.LerIni('BANCO', 'DatabaseType'), 0);
  FDConn.Connected := False;
  if Banco = 0 then
    FDConn.DriverName := 'FB'
  else
    FDConn.DriverName := 'MSSQL';
  FDConn.Params.Values['User_Name'] := TFuncoesIni.LerIni('BANCO', 'User_name');
  FDConn.Params.Values['Password'] := TFuncoesIni.LerIni('BANCO', 'Pass');
  FDConn.Params.Values['Database'] := TFuncoesIni.LerIni('BANCO', 'Database');
  try
    FDConn.Connected := True;
  Except
    on e: Exception do
      TMensagem.Informar('Falha na Configuração do banco de dados!' + #13#10 + e.Message);
  end;
end;

procedure TDMConexao.DataModuleCreate(Sender: TObject);
begin
  ConectarBanco;
end;

function TDMConexao.TestarConexao(User, Pass, DataBase: String; Banco: TDataBaseType): Boolean;
begin
  if Banco = tdbFirebird then
    FDConnTest.DriverName := 'FB'
  else
    FDConnTest.DriverName := 'MSSQL';
  FDConnTest.Params.Values['User_Name'] := User;
  FDConnTest.Params.Values['Password'] := Pass;
  FDConnTest.Params.Values['Database'] := DataBase;
  try
    FDConnTest.Connected := True;
    FDConnTest.Connected := False;
    result := True;
  Except
    on e: Exception do
    begin
      result := False;
      TMensagem.Informar('Falha na Configuração !' + #13#10 + e.Message);
    end;
  end;
end;


end.
