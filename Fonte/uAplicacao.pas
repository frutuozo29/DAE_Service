unit uAplicacao;

interface

type

  TAplicacao = class
  private
    FStatusDoServico: Boolean;
  public
    property StatusDoServico: Boolean read FStatusDoServico write FStatusDoServico;

    constructor Create;
  end;

  function GetAplicacao: TAplicacao;

implementation

uses SysUtils;

var
  Aplicacao: TAplicacao;

{ TAplicacao }

constructor TAplicacao.Create;
begin
  Self.StatusDoServico := True;
end;

function GetAplicacao: TAplicacao;
begin
  if not Assigned(Aplicacao) then
    Aplicacao := TAplicacao.Create;

  Result := Aplicacao;
end;

initialization
  Aplicacao := nil;

finalization
  FreeAndNil(Aplicacao);
end.
