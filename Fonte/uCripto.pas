unit uCripto;

interface

type

  TCripto = class
  public
    class function Decode(Texto: string): string;
    class function Encode(Texto: string): string;
  end;

implementation

const
  AlfaNumerico: string = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

Class function TCripto.Encode(Texto: string): string;
var
  i, x: Integer;
begin
  for i := 1 to Length(Texto) do
    if (Pos(Texto[i], AlfaNumerico) <> 0) then
      begin
        x := Pos(Texto[i], AlfaNumerico) - 1;
        if (x <= 0) then
          x := 62;
        Texto[i] := AlfaNumerico[x];
      end;
  Result := Texto;
end;

Class function TCripto.Decode(Texto: string): string;
var
  i, x: Integer;
begin
  for i := 1 to Length(Texto) do
    if (Pos(Texto[i], AlfaNumerico) <> 0) then
      begin
        x := Pos(Texto[i], AlfaNumerico) + 1;
        if (x >= 62) then
          x := 1;
        Texto[i] := AlfaNumerico[x];
      end;
  Result := Texto;
end;

end.
