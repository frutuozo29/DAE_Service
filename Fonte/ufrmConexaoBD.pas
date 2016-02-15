unit ufrmConexaoBD;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ufrmBasic, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Imaging.jpeg, Vcl.Buttons,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FBDef, FireDAC.Phys.MSSQLDef, FireDAC.Phys.ODBCBase,
  FireDAC.Phys.MSSQL, FireDAC.Phys.IBBase, FireDAC.Phys.FB, Data.DB, FireDAC.Comp.Client;

type
  TfrmConexaoBD = class(TfrmBasic)
    Label7: TLabel;
    edtCaminho: TEdit;
    Label8: TLabel;
    edtUser: TEdit;
    Label9: TLabel;
    edtSenha: TEdit;
    btnConectar: TButton;
    SpeedButton2: TSpeedButton;
    Label1: TLabel;
    cbxTipobanco: TComboBox;
    llbUsuarioPadrao: TLinkLabel;
    procedure llbUsuarioPadraoClick(Sender: TObject);
    procedure btnConectarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConexaoBD: TfrmConexaoBD;

implementation

{$R *.dfm}

uses uMensagem, uDMConexao, uFuncoesIni;

procedure TfrmConexaoBD.btnConectarClick(Sender: TObject);
begin
  inherited;
  if DMConexao.TestarConexao(edtUser.Text, edtSenha.Text, edtCaminho.Text, TDataBaseType(cbxTipobanco.ItemIndex)) then
  begin
    TFuncoesIni.GravarIni('BANCO', 'User_Name', edtUser.Text);
    TFuncoesIni.GravarIni('BANCO', 'Pass', edtSenha.Text);
    TFuncoesIni.GravarIni('BANCO', 'Database', edtCaminho.Text);
    TFuncoesIni.GravarIni('BANCO', 'DatabaseType', cbxTipobanco.ItemIndex.ToString());
    DMConexao.ConectarBanco;
    TMensagem.Informar('Conexão realizada com sucesso!');
    btnSairClick(Nil);
  end;
end;

procedure TfrmConexaoBD.FormShow(Sender: TObject);
begin
  inherited;
  edtUser.Text := TFuncoesIni.LerIni('BANCO', 'User_name');
  edtSenha.Text := TFuncoesIni.LerIni('BANCO', 'Pass');
  edtCaminho.Text := TFuncoesIni.LerIni('BANCO', 'Database');
  cbxTipobanco.ItemIndex := StrToIntDef(TFuncoesIni.LerIni('BANCO', 'DatabaseType'), 0);
end;

procedure TfrmConexaoBD.llbUsuarioPadraoClick(Sender: TObject);
begin
  inherited;
  if TMensagem.Pergunta('Deseja utilizar usuário e senha padrão?') then
  begin
    case cbxTipobanco.ItemIndex of
      0: begin
        edtUser.Text := 'SYSDBA';
        edtSenha.Text := 'masterkey';
      end;
      1: begin
        edtUser.Text := 'sa';
        edtSenha.Text := 'masterkey';
      end;
    end;
  end;
end;

end.
