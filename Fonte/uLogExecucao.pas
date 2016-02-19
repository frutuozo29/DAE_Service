unit uLogExecucao;

interface

uses System.Classes, System.SysUtils;

type
  TLogExecucao = class
  private
    FArquivo: TStringList;
  public
    procedure RegistrarLog(aLog: String);
    property Arquivo: TStringList read FArquivo write FArquivo;
  end;

  function GetLog: TLogExecucao;

implementation

uses IwSystem;

var
  LogExecucao: TLogExecucao;

{ TLogExecucao }

procedure TLogExecucao.RegistrarLog(aLog: String);
var
  nomeArquivo: String;
begin
  try
    nomeArquivo := gsAppPath + 'Log\log_' + FormatDateTime('dd_mm_yyyy', Now) + '.txt';
    if not DirectoryExists(gsAppPath + 'Log\') then
      ForceDirectories(gsAppPath + 'Log\');

    Arquivo := TStringList.Create;
    if FileExists(nomeArquivo) then
      Arquivo.LoadFromFile(nomeArquivo);
    Arquivo.Add('['+DateTimeToStr(Now)+'] ' + aLog);
    Arquivo.SaveToFile(nomeArquivo);
  finally
    FreeAndNil(FArquivo);
  end;
end;

function GetLog: TLogExecucao;
begin
  if not Assigned(LogExecucao) then
    LogExecucao := TLogExecucao.Create;

  Result := LogExecucao;
end;

initialization
  LogExecucao := nil;

finalization
  FreeAndNil(LogExecucao);

end.
