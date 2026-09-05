program CaixaAgil;

uses
  Vcl.Forms,
  CaixaAgil.App in 'src\CaixaAgil.App.pas' {frmPrincipal},
  CaixaAgil.Fiscal.DataModule in 'src\CaixaAgil.Fiscal.DataModule.pas' {dmFiscal: TDataModule},
  CaixaAgil.Domain.Emission in 'src\CaixaAgil.Domain.Emission.pas';

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmFiscal, dmFiscal);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
