unit CaixaAgil.Application.Demo;

interface
uses System.Classes;
procedure RunLocalDemonstration(ALines: TStrings; const AOutputPath: string);

implementation
uses System.IOUtils, System.SysUtils, CaixaAgil.Application.Emission, CaixaAgil.Domain.Emission, CaixaAgil.Domain.Sale, CaixaAgil.Infrastructure;

procedure RunScenario(ALines: TStrings; const AOutputPath: string; AMode: TSimulationMode; const AName: string);
var Service: TEmissionService; Result: TEmissionResult;
begin
  Service := TEmissionService.Create(TSimulatedEmissionGateway.Create(AMode), TSqliteAttemptRepository.Create(TPath.Combine(AOutputPath, 'caixa-agil.sqlite')));
  try
    Result := Service.Emit(TSale.Fictional);
    ALines.Add(Format('%s: %s | código=%d | tentativa=%s', [AName, EmissionStateName(Result.State), Result.StatusCode, Result.AttemptId]));
  finally Service.Free; end;
end;

procedure RunLocalDemonstration(ALines: TStrings; const AOutputPath: string);
begin
  ForceDirectories(AOutputPath);
  ALines.Add('Simulação local - nenhum serviço externo será acessado');
  ALines.Add(Format('Venda fictícia: total R$ %.2f', [TSale.Fictional.Total]));
  RunScenario(ALines, AOutputPath, smAuthorize, 'Cenário autorizado');
  RunScenario(ALines, AOutputPath, smReject, 'Cenário rejeitado');
  RunScenario(ALines, AOutputPath, smTimeout, 'Cenário timeout');
  ALines.Add('Evidência SQLite: ' + TPath.Combine(AOutputPath, 'caixa-agil.sqlite'));
end;

end.
