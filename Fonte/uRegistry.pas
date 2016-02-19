unit uRegistry;

interface

type
  TRegistro = class
  private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    class function LerRegistro(aChave: String): String;
    class procedure GravarRegistro(aChave, aValor: String);
    class procedure RunOnStartup(ProgTitle, CmdLine: string; RunOnce: boolean = false);
  end;

implementation

uses System.Win.Registry, Winapi.Windows, System.SysUtils, uMensagem;

class procedure TRegistro.GravarRegistro(aChave, aValor: String);
Var
  Registro: TRegistry;
begin
  Registro := nil;
  try
    Registro := TRegistry.Create;
    Registro.RootKey := HKEY_CURRENT_USER;
    if Registro.OpenKey(aChave, true) then
    begin
      Registro.WriteString(aChave, aValor);
    end;
  finally
    Registro.CloseKey;
    FreeAndNil(Registro);
  end;
end;

class function TRegistro.LerRegistro(aChave: String): String;
Var
  Registro: TRegistry;
begin
  Registro := nil;
  try
    Registro := TRegistry.Create;
    Registro.RootKey := HKEY_CURRENT_USER;
    if Registro.OpenKey(aChave, true) then
      Result := Registro.ReadString(aChave);
  finally
    Registro.CloseKey;
    FreeAndNil(Registro);
  end;
end;

class procedure TRegistro.RunOnStartup(ProgTitle, CmdLine: string; RunOnce: boolean = false);
var
  sKey: string;
  Registro: TRegistry;
begin
  if RunOnce then
    sKey := 'Once'
  else
    sKey := '';
  try
    try
      Registro := TRegistry.Create;
      Registro.RootKey := HKEY_LOCAL_MACHINE;
      if Registro.OpenKey('Software\Microsoft\Windows\CurrentVersion\Run' + sKey + #0, false) then
        Registro.WriteString(ProgTitle, CmdLine);
    except
      on E: ERegistryException do
        TMensagem.Informar('Para que a aplicação consiga rodar sempre que o Windows executar é necessário abrir como Administrador!');
    end;
  finally
    FreeAndNil(Registro);
  end;
end;


end.
