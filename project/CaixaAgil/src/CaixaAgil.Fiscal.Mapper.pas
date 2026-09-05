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
begin
  ASale.Validate;
  FNFe.NotasFiscais.Clear;
  with FNFe.NotasFiscais.Add.NFe do
  begin
    Ide.natOp := 'VENDA FICTICIA DE HOMOLOGACAO';
    Ide.indPag := ipVista;
    Ide.modelo := 65;
    Ide.serie := ASale.Series;
    Ide.nNF := ASale.Number;
    Ide.dEmi := Now;
    Ide.tpNF := tnSaida;
    Ide.tpAmb := taHomologacao;
    Ide.finNFe := fnNormal;
    Ide.tpImp := tiNFCe;
    Ide.indFinal := cfConsumidorFinal;
    Ide.indPres := pcPresencial;

    ItemNumber := 0;
    for Item in ASale.Items do
    begin
      Inc(ItemNumber);
      with Det.New.Prod do
      begin
        nItem := ItemNumber;
        cProd := Item.Code;
        xProd := Item.Description;
        uCom := 'UN';
        qCom := Item.Quantity;
        vUnCom := Item.UnitPrice;
        vProd := Item.Total;
        uTrib := 'UN';
        qTrib := Item.Quantity;
        vUnTrib := Item.UnitPrice;
      end;
    end;

    Total.ICMSTot.vProd := ASale.Total;
    Total.ICMSTot.vNF := ASale.Total;
    Transp.modFrete := mfSemFrete;
    with pag.New do
    begin
      tPag := fpDinheiro;
      vPag := ASale.AmountPaid;
    end;
    InfAdic.infCpl := 'DOCUMENTO DIDATICO - DADOS FICTICIOS';
  end;
end;

end.
