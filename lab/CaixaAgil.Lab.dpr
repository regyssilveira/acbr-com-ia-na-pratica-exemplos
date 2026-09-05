program CaixaAgil.Lab;

{$APPTYPE CONSOLE}

uses
  System.Classes,
  System.IOUtils,
  System.SysUtils,
  CaixaAgil.Application.Demo in '..\project\CaixaAgil\src\CaixaAgil.Application.Demo.pas',
  CaixaAgil.Application.Emission in '..\project\CaixaAgil\src\CaixaAgil.Application.Emission.pas',
  CaixaAgil.Domain.Emission in '..\project\CaixaAgil\src\CaixaAgil.Domain.Emission.pas',
  CaixaAgil.Domain.Sale in '..\project\CaixaAgil\src\CaixaAgil.Domain.Sale.pas',
  CaixaAgil.Infrastructure in '..\project\CaixaAgil\src\CaixaAgil.Infrastructure.pas';

var
  Lines: TStringList;
  Line: string;
begin
  Lines := TStringList.Create;
  try
    RunLocalDemonstration(Lines, TPath.Combine(ExtractFilePath(ParamStr(0)), 'output'));
    for Line in Lines do Writeln(Line);
  finally Lines.Free; end;
end.
