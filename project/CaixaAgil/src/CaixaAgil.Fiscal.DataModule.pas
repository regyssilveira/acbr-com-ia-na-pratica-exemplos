unit CaixaAgil.Fiscal.DataModule;

interface

uses
  System.Classes,
  ACBrNFe;

type
  TdmFiscal = class(TDataModule)
    ACBrNFe: TACBrNFe;
  public
    procedure ConfigurarHomologacao;
    function DescreverAmbiente: string;
  end;

var
  dmFiscal: TdmFiscal;

implementation

uses
  System.SysUtils,
  pcnConversao,
  pcnConversaoNFe;

{$R *.dfm}

procedure TdmFiscal.ConfigurarHomologacao;
begin
  ACBrNFe.Configuracoes.Geral.ModeloDF := TpcnModeloDF.moNFCe;
  ACBrNFe.Configuracoes.WebServices.Ambiente := TpcnTipoAmbiente.taHomologacao;
end;

function TdmFiscal.DescreverAmbiente: string;
begin
  ConfigurarHomologacao;
  Result := Format(
    'Componente: %s%sModelo: NFC-e%sAmbiente: homologação',
    [ACBrNFe.Name, sLineBreak, sLineBreak]);
end;

end.
