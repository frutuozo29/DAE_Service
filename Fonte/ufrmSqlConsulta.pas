unit ufrmSqlConsulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ufrmBasic, Vcl.StdCtrls, Vcl.ExtCtrls, iwsystem;

type
  TfrmSqlConsulta = class(TfrmBasic)
    Panel1: TPanel;
    mmSQL: TMemo;
    btnSalvar: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSqlConsulta: TfrmSqlConsulta;

implementation

{$R *.dfm}

procedure TfrmSqlConsulta.btnSalvarClick(Sender: TObject);
begin
  inherited;
  mmSQL.Lines.SaveToFile(gsAppPath+ '\Consulta.sql');
end;

procedure TfrmSqlConsulta.FormCreate(Sender: TObject);
begin
  inherited;

  if FileExists(gsAppPath+ '\Consulta.sql') then
    mmSQL.Lines.LoadFromFile(gsAppPath+ '\Consulta.sql');

end;

end.
