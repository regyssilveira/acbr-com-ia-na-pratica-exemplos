unit CaixaAgil.Domain.Emission;

interface

type
  TEmissionState = (
    esDraft,
    esValidated,
    esSubmitted,
    esAuthorized,
    esRejected,
    esFailed
  );

  TEmissionResult = record
  private
    FState: TEmissionState;
    FStatusCode: Integer;
    FReason: string;
  public
    class function Create(AState: TEmissionState; AStatusCode: Integer;
      const AReason: string): TEmissionResult; static;
    property State: TEmissionState read FState;
    property StatusCode: Integer read FStatusCode;
    property Reason: string read FReason;
  end;

implementation

class function TEmissionResult.Create(AState: TEmissionState;
  AStatusCode: Integer; const AReason: string): TEmissionResult;
begin
  Result.FState := AState;
  Result.FStatusCode := AStatusCode;
  Result.FReason := AReason;
end;

end.
