unit CaixaAgil.Application.Emission;

interface

uses CaixaAgil.Domain.Emission, CaixaAgil.Domain.Sale, CaixaAgil.Infrastructure;

type
  TSimulationMode = (smAuthorize, smReject, smTimeout);
  IEmissionGateway = interface
    ['{5CE8759B-E919-4DDA-8B25-AC91DD9B5B1E}']
    function Submit(const ASale: TSale; const AAttemptId: string): TEmissionResult;
  end;
  TSimulatedEmissionGateway = class(TInterfacedObject, IEmissionGateway)
  private FMode: TSimulationMode;
  public constructor Create(AMode: TSimulationMode); function Submit(const ASale: TSale; const AAttemptId: string): TEmissionResult;
  end;
  TEmissionService = class
  private FGateway: IEmissionGateway; FRepository: IAttemptRepository; FRunning: Boolean;
  public constructor Create(const AGateway: IEmissionGateway; const ARepository: IAttemptRepository); function Emit(const ASale: TSale): TEmissionResult;
  end;

implementation

uses System.SysUtils;

constructor TSimulatedEmissionGateway.Create(AMode: TSimulationMode);
begin inherited Create; FMode := AMode; end;

function TSimulatedEmissionGateway.Submit(const ASale: TSale; const AAttemptId: string): TEmissionResult;
begin
  case FMode of
    smAuthorize: Result := TEmissionResult.Create(esAuthorized, 100, 'Autorização fictícia de laboratório', AAttemptId);
    smReject: Result := TEmissionResult.Create(esRejected, 999, 'Rejeição fictícia controlada', AAttemptId);
    smTimeout: Result := TEmissionResult.Create(esUncertainResult, 0, 'Timeout simulado após o envio; consultar antes de repetir', AAttemptId);
  else Result := TEmissionResult.Create(esTechnicalFailure, 0, 'Modo de simulação inválido', AAttemptId); end;
end;

constructor TEmissionService.Create(const AGateway: IEmissionGateway; const ARepository: IAttemptRepository);
begin inherited Create; FGateway := AGateway; FRepository := ARepository; end;

function TEmissionService.Emit(const ASale: TSale): TEmissionResult;
var AttemptId: string;
begin
  if FRunning then raise EInvalidOp.Create('Já existe uma emissão em andamento');
  FRunning := True;
  try
    ASale.Validate; AttemptId := TGUID.NewGuid.ToString;
    FRepository.Start(AttemptId, ASale.Number);
    Result := FGateway.Submit(ASale, AttemptId);
    FRepository.Finish(Result);
  finally FRunning := False; end;
end;

end.
