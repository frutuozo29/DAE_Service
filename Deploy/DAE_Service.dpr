program DAE_Service;

uses
  Vcl.Forms,
  cTDI in '..\Fonte\cTDI.pas',
  uCripto in '..\Fonte\uCripto.pas',
  ufInicio in '..\Fonte\ufInicio.pas' {fInicio},
  ufPrincipal in '..\Fonte\ufPrincipal.pas' {fPrincipal},
  uFTDI in '..\Fonte\uFTDI.pas',
  uFuncoesIni in '..\Fonte\uFuncoesIni.pas',
  uMensagem in '..\Fonte\uMensagem.pas',
  uRegistry in '..\Fonte\uRegistry.pas',
  uSeguranca in '..\Fonte\uSeguranca.pas',
  uUtils in '..\Fonte\uUtils.pas',
  Vcl.Themes,
  Vcl.Styles,
  ufrmStandard in '..\Fonte\ufrmStandard.pas' {frmStandard},
  ufrmBasic in '..\Fonte\ufrmBasic.pas' {frmBasic},
  ufrmConexaoBD in '..\Fonte\ufrmConexaoBD.pas' {frmConexaoBD},
  uDMConexao in '..\Fonte\uDMConexao.pas' {DMConexao: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Ruby Graphite');
  Application.CreateForm(TDMConexao, DMConexao);
  Application.CreateForm(TfPrincipal, fPrincipal);
  Application.Run;
end.
