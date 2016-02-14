unit uMensagem;

interface

type

  TMensagem = class
  private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    class procedure Informar(aMsg: String);
    class function Pergunta(aMsg: String): Boolean;
  end;

implementation

uses
  Vcl.Dialogs, System.UITypes;

{ TMensagem }

class procedure TMensagem.Informar(aMsg: String);
begin
  MessageDlg(aMsg, mtInformation, [mbOK], 0);
end;

class function TMensagem.Pergunta(aMsg: String): Boolean;
begin
  Result := False;
  if MessageDlg(aMsg, mtConfirmation, [mbYes, mbNo],0 ) = mrYes then
    Result := True;
end;

end.
