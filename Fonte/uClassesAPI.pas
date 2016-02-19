unit uClassesAPI;

interface

type
  TEmpresa = class
  private
    FNome: String;
    FCNPJ: String;
    FEmail: String;
  public
    property Nome: String read FNome write FNome;
    property CNPJ: String read FCNPJ write FCNPJ;
    property Email: String read FEmail write FEmail;
  end;

  TEmpresaNotas = class
  private
    FEmpresa: TEmpresa;
    FNumerosDasNotasFiscais: TArray<String>;
    procedure IncArrayLength;
  public
    constructor Create;
    procedure AddElementOnArray(aElement: String);

    property Empresa: TEmpresa read FEmpresa write FEmpresa;
    property NumerosDasNotasFiscais: TArray<String> read FNumerosDasNotasFiscais write FNumerosDasNotasFiscais;
  end;

implementation

uses Vcl.ComCtrls;

{ TEmpresaNotas }

procedure TEmpresaNotas.AddElementOnArray(aElement: String);
var
  Tamanho: Integer;
begin
  IncArrayLength;
  Tamanho := Length(Self.FNumerosDasNotasFiscais);
  Self.FNumerosDasNotasFiscais[Tamanho -1] := aElement;
end;

constructor TEmpresaNotas.Create;
begin
  Empresa := TEmpresa.Create;
end;

procedure TEmpresaNotas.IncArrayLength;
var
  aLength: Integer;
begin
  aLength := Length(Self.FNumerosDasNotasFiscais);
  SetLength(Self.FNumerosDasNotasFiscais, aLength + 1);
end;

end.
