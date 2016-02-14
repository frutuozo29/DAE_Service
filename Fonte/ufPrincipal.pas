unit ufPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, uFTDI, ufInicio, Vcl.AppEvnts;

type
  TfPrincipal = class(TForm)
    Menu: TCategoryPanelGroup;
    cpInicializacao: TCategoryPanel;
    cpConfiguracoes: TCategoryPanel;
    btnIniciarServico: TButton;
    btnPararServico: TButton;
    AppEvents: TApplicationEvents;
    TrayIcon: TTrayIcon;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure AppEventsMinimize(Sender: TObject);
    procedure TrayIconDblClick(Sender: TObject);
    procedure onGrupoExpande(Sender: TObject);
  private
    FFTDI: TFTDI;

    { Private declarations }
  public
    { Public declarations }
    property FTDI: TFTDI read FFTDI write FFTDI;
  end;

var
  fPrincipal: TfPrincipal;

implementation

{$R *.dfm}

procedure TfPrincipal.AppEventsMinimize(Sender: TObject);
begin
  Self.Hide;
  Self.WindowState := wsMinimized;
  TrayIcon.Visible := True;
  TrayIcon.Animate := True;
  TrayIcon.ShowBalloonHint;
end;

procedure TfPrincipal.FormCreate(Sender: TObject);
begin
  FTDI := TFTDI.create(Self, TfInicio);
end;

procedure TfPrincipal.TrayIconDblClick(Sender: TObject);
begin
  TrayIcon.Visible := False;
  Show;
  WindowState := wsNormal;
  Application.BringToFront;
end;

procedure TfPrincipal.onGrupoExpande(Sender: TObject);
begin
  Menu.CollapseAll;
  TCategoryPanel(Sender).OnExpand := nil;
  TCategoryPanel(Sender).Expand;
  TCategoryPanel(Sender).OnExpand := onGrupoExpande;
end;

end.
