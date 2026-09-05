unit CaixaAgil.Infrastructure;

interface

uses CaixaAgil.Domain.Emission, FireDAC.Comp.Client;

type
  IAttemptRepository = interface
    ['{A6A601DF-A12D-4918-BF54-D6B53C9D0DD0}']
    procedure Start(const AAttemptId: string; ASaleNumber: Integer);
    procedure Finish(const AResult: TEmissionResult);
  end;

  TFileAttemptRepository = class(TInterfacedObject, IAttemptRepository)
  private FFileName: string; procedure AppendLine(const ALine: string);
  public
    constructor Create(const AFileName: string);
    procedure Start(const AAttemptId: string; ASaleNumber: Integer);
    procedure Finish(const AResult: TEmissionResult);
  end;

  TSqliteAttemptRepository = class(TInterfacedObject, IAttemptRepository)
  private
    FConnection: TFDConnection;
  public
    constructor Create(const AFileName: string);
    destructor Destroy; override;
    procedure Start(const AAttemptId: string; ASaleNumber: Integer);
    procedure Finish(const AResult: TEmissionResult);
  end;

function SanitizeLog(const AText: string): string;
function EmissionStateName(AState: TEmissionState): string;

implementation

uses System.IOUtils, System.StrUtils, System.SysUtils,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.Async,
  FireDAC.Stan.Def;

function SanitizeLog(const AText: string): string;
begin
  Result := StringReplace(StringReplace(AText, #13, ' ', [rfReplaceAll]), #10, ' ', [rfReplaceAll]);
  if ContainsText(Result, 'password=') then Result := '<mensagem removida por conter segredo>';
end;

function EmissionStateName(AState: TEmissionState): string;
const Names: array[TEmissionState] of string = ('rascunho','validada','enviada','autorizada','rejeitada','falha_tecnica','resultado_incerto');
begin Result := Names[AState]; end;

constructor TFileAttemptRepository.Create(const AFileName: string);
begin inherited Create; FFileName := AFileName; ForceDirectories(ExtractFilePath(FFileName)); end;

procedure TFileAttemptRepository.AppendLine(const ALine: string);
begin TFile.AppendAllText(FFileName, ALine + sLineBreak, TEncoding.UTF8); end;

procedure TFileAttemptRepository.Start(const AAttemptId: string; ASaleNumber: Integer);
begin AppendLine(Format('%s|venda=%d|estado=criada', [AAttemptId, ASaleNumber])); end;

procedure TFileAttemptRepository.Finish(const AResult: TEmissionResult);
begin AppendLine(Format('%s|estado=%s|codigo=%d|motivo=%s', [AResult.AttemptId, EmissionStateName(AResult.State), AResult.StatusCode, SanitizeLog(AResult.Reason)])); end;

constructor TSqliteAttemptRepository.Create(const AFileName: string);
begin
  inherited Create;
  ForceDirectories(ExtractFilePath(AFileName));
  FConnection := TFDConnection.Create(nil);
  FConnection.LoginPrompt := False;
  FConnection.Params.DriverID := 'SQLite';
  FConnection.Params.Database := AFileName;
  FConnection.Connected := True;
  FConnection.ExecSQL('create table if not exists emission_attempts (' +
    'attempt_id text primary key, sale_number integer not null, ' +
    'state text not null, status_code integer, reason text)');
end;

destructor TSqliteAttemptRepository.Destroy;
begin
  FConnection.Free;
  inherited;
end;

procedure TSqliteAttemptRepository.Start(const AAttemptId: string;
  ASaleNumber: Integer);
begin
  FConnection.ExecSQL(
    'insert into emission_attempts(attempt_id,sale_number,state) values(?,?,?)',
    [AAttemptId, ASaleNumber, 'criada']);
end;

procedure TSqliteAttemptRepository.Finish(const AResult: TEmissionResult);
begin
  FConnection.ExecSQL(
    'update emission_attempts set state=?,status_code=?,reason=? where attempt_id=?',
    [EmissionStateName(AResult.State), AResult.StatusCode,
     SanitizeLog(AResult.Reason), AResult.AttemptId]);
end;

end.
