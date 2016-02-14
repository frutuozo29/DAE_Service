unit uSeguranca;

interface

type

  TSeguranca = class
  private
    { private declarations }
    class function Replicate(aChar: AnsiChar; aCount: integer): AnsiString;
    class function PadL(const aString: string; aWidth: integer;
      aFill: AnsiChar = ' '): string;
  protected
    { protected declarations }
  public
    { public declarations }
    class function GerarSenha(const aContraSenha: String): String;
    class function GerarContraSenha(const aContraSenha: String): String;
    class procedure GravarRegistro(aValor: String);
    class function LerRegistro: String;
  end;

implementation

uses SysUtils, StrUtils, uCripto, uRegistry;

const
  CHAVE = 'Chave_I2B';

{ TSeguranca }

class function TSeguranca.GerarContraSenha(const aContraSenha: String): String;
var
  y, m, d: Word;
  char1, char2, char3, char4: integer;
  Temp: String;
begin
  Decodedate(Date, y, m, d);
  char1 := Ord(Char(aContraSenha[1]));
  char2 := Ord(Char(aContraSenha[2]));
  char3 := Ord(Char(aContraSenha[3]));
  char4 := Ord(Char(aContraSenha[4]));
  Temp := Self.PadL(IntToStr((char2 + (char4 * d)) + ((char1 * char3) + y)), 4);
  Result := AnsiReverseString(Copy(Temp, 1, 2)) +
    AnsiReverseString(Copy(Temp, 3, 2));
end;

class function TSeguranca.GerarSenha(const aContraSenha: String): String;
var
  y, m, d: Word;
begin
  Decodedate(Date, y, m, d);
  Result := IntToStr(StrToInt(Copy(aContraSenha, 1, 2)) + d) +
    IntToStr(StrToInt(Copy(aContraSenha, 3, 2)) + m);
  Result := AnsiReverseString(Result);
end;

class procedure TSeguranca.GravarRegistro(aValor: String);
var
  ValorCripto: String;
begin
  ValorCripto := TCripto.Encode(aValor);
  TRegistro.GravarRegistro(CHAVE, ValorCripto);
end;

class function TSeguranca.LerRegistro: String;
var
  Valor: String;
begin
  valor := TRegistro.LerRegistro(CHAVE);
  Result := TCripto.Decode(Valor);
end;

class function TSeguranca.PadL(const aString: string; aWidth: integer;
  aFill: AnsiChar): string;
var
  m: integer;
begin
  Result := aString;
  if Length(Result) > aWidth then
    Result := Copy(Result, 1, aWidth);
  m := aWidth - Length(Result);
  Result := Replicate(aFill, m) + Result;
end;

class function TSeguranca.Replicate(aChar: AnsiChar; aCount: integer)
  : AnsiString;
begin
  setLength(Result, aCount);
  if aCount > 0 then
    fillchar(Result[1], aCount, aChar);
end;

end.
