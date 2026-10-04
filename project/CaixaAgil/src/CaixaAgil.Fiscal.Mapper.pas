unit CaixaAgil.Fiscal.Mapper;

interface

uses
  ACBrNFe,
  CaixaAgil.Domain.Sale;

type
  { Mapeia somente campos técnicos. Emitente e tributação exigem um perfil
    aprovado e não são inventados pelo exemplo. O resultado não pode ser
    enviado ou validado como documento fiscal completo. }
  TTechnicalNFCeMapper = class
  private
    FNFe: TACBrNFe;
  public
    constructor Create(ANFe: TACBrNFe);
    procedure MapDraft(const ASale: TSale);
  end;

implementation

uses
  System.SysUtils,
  ACBrNFeNotasFiscais,
  pcnConversao,
  pcnConversaoNFe;

constructor TTechnicalNFCeMapper.Create(ANFe: TACBrNFe);
begin
  inherited Create;
  if not Assigned(ANFe) then
    raise EArgumentNilException.Create('Componente ACBrNFe não informado');
  FNFe := ANFe;
end;

procedure TTechnicalNFCeMapper.MapDraft(const ASale: TSale);
var
  Item: TSaleItem;
  ItemNumber: Integer;
  Nota: NotaFiscal;
begin
  ASale.Validate;
  FNFe.NotasFiscais.Clear;
  Nota := FNFe.NotasFiscais.Add;
  Nota.NFe.Ide.natOp := 'VENDA FICTICIA DE HOMOLOGACAO';
  Nota.NFe.Ide.indPag := ipVista;
  Nota.NFe.Ide.modelo := 65;
  Nota.NFe.Ide.serie := ASale.Series;
  Nota.NFe.Ide.nNF := ASale.Number;
  Nota.NFe.Ide.dEmi := Now;
  Nota.NFe.Ide.tpNF := tnSaida;
  Nota.NFe.Ide.tpAmb := taHomologacao;
  Nota.NFe.Ide.finNFe := fnNormal;
  Nota.NFe.Ide.tpImp := tiNFCe;
  Nota.NFe.Ide.indFinal := cfConsumidorFinal;
  Nota.NFe.Ide.indPres := pcPresencial;
  ItemNumber := 0;
  for Item in ASale.Items do
  begin
    Nota.NFe.Det.New;
    Inc(ItemNumber);
    Nota.NFe.Det[ItemNumber - 1].Prod.nItem := ItemNumber;
    Nota.NFe.Det[ItemNumber - 1].Prod.cProd := Item.Code;
    Nota.NFe.Det[ItemNumber - 1].Prod.xProd := Item.Description;
    Nota.NFe.Det[ItemNumber - 1].Prod.uCom := 'UN';
    Nota.NFe.Det[ItemNumber - 1].Prod.qCom := Item.Quantity;
    Nota.NFe.Det[ItemNumber - 1].Prod.vUnCom := Item.UnitPrice;
    Nota.NFe.Det[ItemNumber - 1].Prod.vProd := Item.Total;
    Nota.NFe.Det[ItemNumber - 1].Prod.uTrib := 'UN';
    Nota.NFe.Det[ItemNumber - 1].Prod.qTrib := Item.Quantity;
    Nota.NFe.Det[ItemNumber - 1].Prod.vUnTrib := Item.UnitPrice;
  end;
  Nota.NFe.Total.ICMSTot.vProd := ASale.Total;
  Nota.NFe.Total.ICMSTot.vNF := ASale.Total;
  Nota.NFe.Transp.modFrete := mfSemFrete;
  Nota.NFe.pag.New;
  Nota.NFe.pag[0].tPag := fpDinheiro;
  Nota.NFe.pag[0].vPag := ASale.AmountPaid;
  Nota.NFe.InfAdic.infCpl := 'DOCUMENTO DIDATICO - DADOS FICTICIOS';
end;

end.
