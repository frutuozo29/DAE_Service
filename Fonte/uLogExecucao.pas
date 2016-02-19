unit uLogExecucao;

interface

uses System.Classes, System.SysUtils;

type
  TLogExecucao = class
  private
    FArquivo: TStringList;

  public
    constructor Create;
    procedure RegistrarLog(aLog: String);
    property Arquivo: TStringList read FArquivo write FArquivo;
  end;

implementation

{ TLogExecucao }

constructor TLogExecucao.Create;
begin
  Arquivo := TStringList.Create;
end;

procedure TLogExecucao.RegistrarLog(aLog: String);
begin
  if not Assigned(Arquivo) then
    Arquivo := TStringList.Create;

  Arquivo.Add(aLog);
  Arquivo.SaveToFile('C:\Projetos\LogDeExecucao'+ DateToStr(Now));
end;

end.
