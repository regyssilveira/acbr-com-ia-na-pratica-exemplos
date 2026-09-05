unit CaixaAgil.Domain.Emission;

interface

type
  TEmissionState = (
    esDraft,
    esValidated,
    esSubmitted,
    esAuthorized,
    esRejected,
    esTechnicalFailure,
    esUncertainResult
  );

  TEmissionResult = record
  private
    FState: TEmissionState;
    FStatusCode: Integer;
    FReason: string;
    FAttemptId: string;
  public
    class function Create(AState: TEmissionState; AStatusCode: Integer;
      const AReason: string; const AAttemptId: string = ''): TEmissionResult; static;
    property State: TEmissionState read FState;
    property StatusCode: Integer read FStatusCode;
    property Reason: string read FReason;
    property AttemptId: string read FAttemptId;
  end;

implementation

class function TEmissionResult.Create(AState: TEmissionState;
  AStatusCode: Integer; const AReason, AAttemptId: string): TEmissionResult;
begin
  Result.FState := AState;
  Result.FStatusCode := AStatusCode;
  Result.FReason := AReason;
  Result.FAttemptId := AAttemptId;
end;

end.
