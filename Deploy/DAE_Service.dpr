program DAE_Service;

uses
  Vcl.Forms,
  Vcl.Themes,
  Vcl.Styles,
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
  ufrmStandard in '..\Fonte\ufrmStandard.pas' {frmStandard},
  ufrmBasic in '..\Fonte\ufrmBasic.pas' {frmBasic},
  ufrmConexaoBD in '..\Fonte\ufrmConexaoBD.pas' {frmConexaoBD},
  uDMConexao in '..\Fonte\uDMConexao.pas' {DMConexao: TDataModule},
  ufrmConfigAPI in '..\Fonte\ufrmConfigAPI.pas' {frmConfigAPI},
  uAplicacao in '..\Fonte\uAplicacao.pas',
  uDMApi in '..\Fonte\uDMApi.pas' {DMApi: TDataModule},
  uClassesAPI in '..\Fonte\uClassesAPI.pas',
  uLogExecucao in '..\Fonte\uLogExecucao.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Iceberg Classico');
  Application.CreateForm(TDMConexao, DMConexao);
  Application.CreateForm(TDMApi, DMApi);
  Application.CreateForm(TfPrincipal, fPrincipal);
  Application.Run;
end.
