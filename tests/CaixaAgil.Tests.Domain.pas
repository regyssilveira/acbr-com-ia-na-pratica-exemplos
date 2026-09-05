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
  end;

implementation

uses
  System.SysUtils,
  CaixaAgil.Application.Emission,
  CaixaAgil.Configuration,
  CaixaAgil.Domain.Emission,
  CaixaAgil.Domain.Sale,
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

initialization
  TDUnitX.RegisterTestFixture(TDomainTests);

end.
