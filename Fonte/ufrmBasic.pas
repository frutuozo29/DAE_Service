unit ufrmBasic;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ufrmStandard, Vcl.ImgList, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls;

type
  TfrmBasic = class(TfrmStandard)
    pnTop: TPanel;
    btnSair: TButton;
    lblNomeForm: TLabel;
    pnForm: TPanel;
    procedure btnSairClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBasic: TfrmBasic;

implementation

{$R *.dfm}

uses ufPrincipal;

procedure TfrmBasic.btnSairClick(Sender: TObject);
begin
  inherited;
  PostMessage(fPrincipal.FTDI.GetHandleTDI, WM_CLOSE_TAB, TPageControl(Self.parent.parent).ActivePage.pageindex, 0);
end;

end.
