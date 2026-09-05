program CaixaAgil;

uses
  Vcl.Forms,
  CaixaAgil.App in 'src\CaixaAgil.App.pas' {frmPrincipal},
  CaixaAgil.Fiscal.DataModule in 'src\CaixaAgil.Fiscal.DataModule.pas' {dmFiscal: TDataModule},
  CaixaAgil.Domain.Emission in 'src\CaixaAgil.Domain.Emission.pas',
  CaixaAgil.Domain.Sale in 'src\CaixaAgil.Domain.Sale.pas',
  CaixaAgil.Configuration in 'src\CaixaAgil.Configuration.pas',
  CaixaAgil.Infrastructure in 'src\CaixaAgil.Infrastructure.pas',
  CaixaAgil.Application.Emission in 'src\CaixaAgil.Application.Emission.pas',
  CaixaAgil.Application.Demo in 'src\CaixaAgil.Application.Demo.pas',
  CaixaAgil.Fiscal.Mapper in 'src\CaixaAgil.Fiscal.Mapper.pas';

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmFiscal, dmFiscal);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
