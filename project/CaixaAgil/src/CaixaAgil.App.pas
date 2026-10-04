unit CaixaAgil.App;

interface

uses
  CaixaAgil.Configuration,
  System.Classes,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.StdCtrls;

type
  TfrmPrincipal = class(TForm)
    lblTitulo: TLabel;
    lblAmbiente: TLabel;
    btnVerificarAmbiente: TButton;
    memResultado: TMemo;
    procedure btnVerificarAmbienteClick(Sender: TObject);
  private
    FExecutingLaboratory: Boolean;
  protected
    procedure ExecuteLocalLaboratory; virtual;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  System.IOUtils,
  System.SysUtils,
  CaixaAgil.Application.Demo,
  CaixaAgil.Fiscal.DataModule;

{$R *.dfm}

procedure TfrmPrincipal.btnVerificarAmbienteClick(Sender: TObject);
var
  WasEnabled: Boolean;
begin
  if FExecutingLaboratory then
    Exit;
  WasEnabled := btnVerificarAmbiente.Enabled;
  FExecutingLaboratory := True;
  try
    btnVerificarAmbiente.Enabled := False;
    ExecuteLocalLaboratory;
  finally
    btnVerificarAmbiente.Enabled := WasEnabled;
    FExecutingLaboratory := False;
  end;
end;

procedure TfrmPrincipal.ExecuteLocalLaboratory;
var
  Config: TFiscalConfiguration;
  ConfigFile: string;
  OutputPath: string;
begin
  memResultado.Clear;
  memResultado.Lines.Add(dmFiscal.DescreverAmbiente);
  memResultado.Lines.Add('');
  ConfigFile := TPath.Combine(ExtractFilePath(ParamStr(0)), 'config\appsettings.local.ini');
  if not TFile.Exists(ConfigFile) then
    ConfigFile := TPath.Combine(ExtractFilePath(ParamStr(0)), 'config\appsettings.example.ini');
  Config := TFiscalConfiguration.LoadFromIni(ConfigFile);
  Config.ValidateLocal(False);
  OutputPath := Config.OutputPath;
  if TPath.IsRelativePath(OutputPath) then
    OutputPath := TPath.Combine(ExtractFilePath(ParamStr(0)), OutputPath);
  memResultado.Lines.Add('Configuração validada: ' + ConfigFile);
  RunLocalDemonstration(memResultado.Lines, OutputPath);
end;

end.
