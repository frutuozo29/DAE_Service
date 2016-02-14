unit uUtils;

interface

uses System.SysUtils;

type
  TUtil = class
  public
    class function Parse(S: string; Count: Integer; char: String = ';'): string;
    class function TrocarCaracteres(Old, New, aFonte: String): String;
    class function IIf(Expressao, ParteTRUE, ParteFALSE: Variant): Variant;
    class function TrocaVirgPPto(Valor: string): String;
    class function LPad(S: string; Ch: char; Len: Integer): string;
  end;

implementation

class function TUtil.Parse(S: string; Count: Integer;
  char: String = ';'): string;
var
  I: Integer;
  T: string;
begin
  if S[Length(S)] <> char then
    S := S + char;
  for I := 1 to Count do
  begin
    T := Copy(S, 0, Pos(char, S) - 1);
    S := Copy(S, Pos(char, S) + 1, Length(S));
  end;
  Result := T;
end;

class function TUtil.TrocarCaracteres(Old, New, aFonte: String): String;
begin
  Result := StringReplace(aFonte, Old, New, [rfReplaceAll, rfIgnoreCase]);
end;

class function TUtil.TrocaVirgPPto(Valor: string): String;
var
  I: Integer;
begin
  if Valor <> '' then
  begin
    for I := 0 to Length(Valor) do
    begin
      if Valor[I] = ',' then
        Valor[I] := '.';
    end;
  end;
  Result := Valor;
end;

class function TUtil.IIf(Expressao: Variant;
  ParteTRUE, ParteFALSE: Variant): Variant;
begin
  if Expressao then
    Result := ParteTRUE
  else
    Result := ParteFALSE;
end;

class function TUtil.LPad(S: string; Ch: char; Len: Integer): string;
var
  RestLen: Integer;
begin
  Result := S;
  RestLen := Len - Length(S);
  if RestLen < 1 then
    Exit;
  Result := StringOfChar(Ch, RestLen) + S;
end;

end.
