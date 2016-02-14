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
  end;

implementation

uses System.Win.Registry, Winapi.Windows, System.SysUtils;

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

end.
