unit CaixaAgil.Tests.Domain;

interface

uses
  DUnitX.TestFramework;

type
  [TestFixture]
  TDomainTests = class
  public
    [Test] procedure FictionalSaleTotalsAndValidates;
    [Test] procedure EmptySaleIsRejected;
    [Test] procedure PaymentDifferenceIsRejected;
    [Test] procedure TimeoutBecomesUncertainResult;
    [Test] procedure LogSanitizerRemovesPassword;
    [Test] procedure ProductionConfigurationIsRejected;
    [Test] procedure ExampleConfigurationLoadsAndValidates;
    [Test] procedure TechnicalMapperCreatesDraftInACBr;
  end;

implementation

uses
  System.SysUtils,
  System.IOUtils,
  ACBrNFe,
  CaixaAgil.Application.Emission,
  CaixaAgil.Configuration,
  CaixaAgil.Domain.Emission,
  CaixaAgil.Domain.Sale,
  CaixaAgil.Fiscal.Mapper,
  CaixaAgil.Infrastructure;

type
  TMemoryRepository = class(TInterfacedObject, IAttemptRepository)
  public
    procedure Start(const AAttemptId: string; ASaleNumber: Integer);
    procedure Finish(const AResult: TEmissionResult);
  end;

procedure TMemoryRepository.Start(const AAttemptId: string; ASaleNumber: Integer);
begin
end;

procedure TMemoryRepository.Finish(const AResult: TEmissionResult);
begin
end;

procedure TDomainTests.FictionalSaleTotalsAndValidates;
var Sale: TSale;
begin
  Sale := TSale.Fictional;
  Sale.Validate;
  Assert.AreEqual<Currency>(39.80, Sale.Total);
end;

procedure TDomainTests.EmptySaleIsRejected;
var Sale: TSale;
begin
  Sale := TSale.Fictional;
  SetLength(Sale.Items, 0);
  Assert.WillRaise(procedure begin Sale.Validate; end, EArgumentException);
end;

procedure TDomainTests.PaymentDifferenceIsRejected;
var Sale: TSale;
begin
  Sale := TSale.Fictional;
  Sale.AmountPaid := Sale.AmountPaid - 0.01;
  Assert.WillRaise(procedure begin Sale.Validate; end, EArgumentException);
end;

procedure TDomainTests.TimeoutBecomesUncertainResult;
var Service: TEmissionService; Result: TEmissionResult;
begin
  Service := TEmissionService.Create(TSimulatedEmissionGateway.Create(smTimeout), TMemoryRepository.Create);
  try
    Result := Service.Emit(TSale.Fictional);
    Assert.AreEqual(Integer(esUncertainResult), Integer(Result.State));
  finally Service.Free; end;
end;

procedure TDomainTests.LogSanitizerRemovesPassword;
begin
  Assert.AreEqual('<mensagem removida por conter segredo>', SanitizeLog('password=nao_expor'));
end;

procedure TDomainTests.ProductionConfigurationIsRejected;
var Config: TFiscalConfiguration;
begin
  Config.Environment := 'production';
  Config.State := 'MG';
  Config.OutputPath := 'output';
  Assert.WillRaise(procedure begin Config.ValidateLocal; end, EArgumentException);
end;

procedure TDomainTests.ExampleConfigurationLoadsAndValidates;
var Config: TFiscalConfiguration; FileName: string;
begin
  FileName := TPath.GetFullPath(
    '..\project\CaixaAgil\config\appsettings.example.ini');
  Config := TFiscalConfiguration.LoadFromIni(FileName);
  Config.ValidateLocal(False);
  Assert.AreEqual('homologation', Config.Environment);
  Assert.AreEqual('MG', Config.State);
end;

procedure TDomainTests.TechnicalMapperCreatesDraftInACBr;
var Component: TACBrNFe; Mapper: TTechnicalNFCeMapper;
begin
  Component := TACBrNFe.Create(nil);
  try
    Mapper := TTechnicalNFCeMapper.Create(Component);
    try
      Mapper.MapDraft(TSale.Fictional);
      Assert.AreEqual(1, Component.NotasFiscais.Count);
      Assert.AreEqual(2, Component.NotasFiscais[0].NFe.Det.Count);
      Assert.AreEqual<Currency>(39.80,
        Component.NotasFiscais[0].NFe.Total.ICMSTot.vNF);
    finally Mapper.Free; end;
  finally Component.Free; end;
end;

initialization
  TDUnitX.RegisterTestFixture(TDomainTests);

end.
