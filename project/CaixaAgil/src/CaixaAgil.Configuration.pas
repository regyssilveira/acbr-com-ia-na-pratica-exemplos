unit CaixaAgil.Configuration;

interface

type
  TFiscalConfiguration = record
    Environment, State, SchemaPath, OutputPath, CertificateFile: string;
    class function LoadFromIni(const AFileName: string): TFiscalConfiguration; static;
    procedure ValidateLocal(ARequireCertificate: Boolean = False);
  end;

implementation

uses System.IOUtils, System.IniFiles, System.SysUtils;

class function TFiscalConfiguration.LoadFromIni(const AFileName: string): TFiscalConfiguration;
var Ini: TIniFile;
begin
  if not TFile.Exists(AFileName) then raise EFileNotFoundException.CreateFmt('Arquivo de configuração não encontrado: %s', [AFileName]);
  Ini := TIniFile.Create(AFileName);
  try
    Result.Environment := Ini.ReadString('Fiscal', 'Environment', '');
    Result.State := Ini.ReadString('Fiscal', 'State', '');
    Result.SchemaPath := Ini.ReadString('Fiscal', 'SchemaPath', '');
    Result.OutputPath := Ini.ReadString('Fiscal', 'OutputPath', '');
    Result.CertificateFile := Ini.ReadString('Certificate', 'File', '');
  finally Ini.Free; end;
end;

procedure TFiscalConfiguration.ValidateLocal(ARequireCertificate: Boolean);
begin
  if not SameText(Environment, 'homologation') then raise EArgumentException.Create('Somente homologação é permitida no projeto didático');
  if Length(Trim(State)) <> 2 then raise EArgumentException.Create('UF deve conter duas letras');
  if (SchemaPath <> '') and not TDirectory.Exists(SchemaPath) then raise EDirectoryNotFoundException.CreateFmt('Pasta de schemas não encontrada: %s', [SchemaPath]);
  if OutputPath = '' then raise EArgumentException.Create('Pasta de saída não informada');
  if ARequireCertificate and ((CertificateFile = '') or not TFile.Exists(CertificateFile)) then
    raise EFileNotFoundException.Create('Certificado não configurado para integração externa');
end;

end.
