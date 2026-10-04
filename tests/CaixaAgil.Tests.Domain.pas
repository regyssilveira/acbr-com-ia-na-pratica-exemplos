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
    [Test] procedure ZeroQuantityIsRejected;
    [Test] procedure PaymentDifferenceIsRejected;
    [Test] procedure TimeoutBecomesUncertainResult;
    [Test] procedure LogSanitizerRemovesPassword;
    [Test] procedure ProductionConfigurationIsRejected;
    [Test] procedure MissingSchemaDirectoryIsRejected;
    [Test] procedure ExampleConfigurationLoadsAndValidates;
    [Test] procedure TechnicalMapperCreatesDraftInACBr;
    [Test] procedure ReentrantEmissionIsBlocked;
    [Test] procedure InvalidSaleDoesNotReachGateway;
    [Test] procedure PersistenceFailureDoesNotReturnSuccess;
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
  TControlledGateway = class(TInterfacedObject, IEmissionGateway)
  public
    SubmitCount: Integer;
    BeforeReturn: TProc;
    function Submit(const ASale: TSale; const AAttemptId: string): TEmissionResult;
  end;
  TRecordingRepository = class(TInterfacedObject, IAttemptRepository)
  public
    StartCount, FinishCount: Integer;
    RaiseOnFinish, ResultStored: Boolean;
    procedure Start(const AAttemptId: string; ASaleNumber: Integer);
    procedure Finish(const AResult: TEmissionResult);
  end;
  TMemoryRepository = class(TInterfacedObject, IAttemptRepository)
  public
    procedure Start(const AAttemptId: string; ASaleNumber: Integer);
    procedure Finish(const AResult: TEmissionResult);
  end;

function TControlledGateway.Submit(const ASale: TSale; const AAttemptId: string): TEmissionResult;
begin
  Inc(SubmitCount);
  if Assigned(BeforeReturn) then BeforeReturn();
  Result := TEmissionResult.Create(esAuthorized, 100, 'Resultado fictício', AAttemptId);
end;

procedure TRecordingRepository.Start(const AAttemptId: string; ASaleNumber: Integer);
begin
  Inc(StartCount);
end;

procedure TRecordingRepository.Finish(const AResult: TEmissionResult);
begin
  Inc(FinishCount);
  if RaiseOnFinish then raise EInvalidOp.Create('Falha fictícia de persistência');
  ResultStored := True;
end;

procedure TDomainTests.ReentrantEmissionIsBlocked;
var Gateway: TControlledGateway; Repository: TRecordingRepository;
    Service: TEmissionService;
begin
  Gateway := TControlledGateway.Create;
  Repository := TRecordingRepository.Create;
  Service := TEmissionService.Create(Gateway, Repository);
  try
    Gateway.BeforeReturn := procedure begin
      Assert.WillRaise(procedure begin Service.Emit(TSale.Fictional); end, EInvalidOp);
    end;
    Service.Emit(TSale.Fictional);
    Assert.AreEqual(1, Gateway.SubmitCount);
    Assert.AreEqual(1, Repository.StartCount);
  finally Service.Free; end;
end;

procedure TDomainTests.InvalidSaleDoesNotReachGateway;
var Gateway: TControlledGateway; Repository: TRecordingRepository;
    Service: TEmissionService; Sale: TSale;
begin
  Gateway := TControlledGateway.Create;
  Repository := TRecordingRepository.Create;
  Service := TEmissionService.Create(Gateway, Repository);
  try
    Sale := TSale.Fictional;
    SetLength(Sale.Items, 0);
    Assert.WillRaise(procedure begin Service.Emit(Sale); end, EArgumentException);
    Assert.AreEqual(0, Gateway.SubmitCount);
    Assert.AreEqual(0, Repository.StartCount);
  finally Service.Free; end;
end;

procedure TDomainTests.PersistenceFailureDoesNotReturnSuccess;
var Gateway: TControlledGateway; Repository: TRecordingRepository;
    Service: TEmissionService;
begin
  Gateway := TControlledGateway.Create;
  Repository := TRecordingRepository.Create;
  Repository.RaiseOnFinish := True;
  Service := TEmissionService.Create(Gateway, Repository);
  try
    Assert.WillRaise(procedure begin Service.Emit(TSale.Fictional); end, EInvalidOp);
    Assert.AreEqual(1, Gateway.SubmitCount);
    Assert.AreEqual(1, Repository.FinishCount);
    Assert.IsFalse(Repository.ResultStored);
  finally Service.Free; end;
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

procedure TDomainTests.ZeroQuantityIsRejected;
var Sale: TSale;
begin
  Sale := TSale.Fictional;
  Sale.Items[0].Quantity := 0;
  Assert.WillRaise(procedure begin Sale.Validate; end, EArgumentOutOfRangeException);
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

procedure TDomainTests.MissingSchemaDirectoryIsRejected;
var Config: TFiscalConfiguration;
begin
  Config.Environment := 'homologation';
  Config.State := 'MG';
  Config.SchemaPath := TPath.Combine(TPath.GetTempPath, 'caixa-agil-schema-inexistente-' + TGUID.NewGuid.ToString);
  Config.OutputPath := 'output';
  Assert.WillRaise(procedure begin Config.ValidateLocal(False); end, EDirectoryNotFoundException);
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
