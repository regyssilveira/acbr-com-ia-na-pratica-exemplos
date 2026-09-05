program CaixaAgil.Tests;

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  DUnitX.Loggers.Console,
  DUnitX.TestFramework,
  CaixaAgil.Tests.Domain in 'CaixaAgil.Tests.Domain.pas',
  CaixaAgil.Domain.Sale in '..\project\CaixaAgil\src\CaixaAgil.Domain.Sale.pas',
  CaixaAgil.Domain.Emission in '..\project\CaixaAgil\src\CaixaAgil.Domain.Emission.pas',
  CaixaAgil.Infrastructure in '..\project\CaixaAgil\src\CaixaAgil.Infrastructure.pas',
  CaixaAgil.Application.Emission in '..\project\CaixaAgil\src\CaixaAgil.Application.Emission.pas',
  CaixaAgil.Configuration in '..\project\CaixaAgil\src\CaixaAgil.Configuration.pas',
  CaixaAgil.Fiscal.Mapper in '..\project\CaixaAgil\src\CaixaAgil.Fiscal.Mapper.pas';

var
  Runner: ITestRunner;
  Results: IRunResults;
begin
  try
    TDUnitX.CheckCommandLine;
    Runner := TDUnitX.CreateRunner;
    Runner.UseRTTI := True;
    Runner.AddLogger(TDUnitXConsoleLogger.Create(True));
    Results := Runner.Execute;
    if not Results.AllPassed then
      ExitCode := EXIT_ERRORS;
  except
    on E: Exception do
    begin
      Writeln(E.ClassName, ': ', E.Message);
      ExitCode := EXIT_ERRORS;
    end;
  end;
end.
