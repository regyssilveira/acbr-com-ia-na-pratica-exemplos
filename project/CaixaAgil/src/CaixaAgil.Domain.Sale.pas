unit CaixaAgil.Domain.Sale;

interface

uses System.SysUtils;

type
  TSaleItem = record
    Code, Description: string;
    Quantity, UnitPrice: Currency;
    class function Create(const ACode, ADescription: string; AQuantity, AUnitPrice: Currency): TSaleItem; static;
    function Total: Currency;
  end;

  TSale = record
    Number, Series: Integer;
    Items: TArray<TSaleItem>;
    AmountPaid: Currency;
    class function Fictional: TSale; static;
    procedure Validate;
    function Total: Currency;
  end;

implementation

class function TSaleItem.Create(const ACode, ADescription: string; AQuantity, AUnitPrice: Currency): TSaleItem;
begin
  Result.Code := ACode; Result.Description := ADescription;
  Result.Quantity := AQuantity; Result.UnitPrice := AUnitPrice;
end;

function TSaleItem.Total: Currency;
begin
  if Quantity <= 0 then raise EArgumentOutOfRangeException.Create('Quantidade deve ser positiva');
  if UnitPrice < 0 then raise EArgumentOutOfRangeException.Create('Valor unitário não pode ser negativo');
  Result := Quantity * UnitPrice;
end;

class function TSale.Fictional: TSale;
begin
  Result.Number := 42; Result.Series := 1; SetLength(Result.Items, 2);
  Result.Items[0] := TSaleItem.Create('LIVRO-001', 'Produto fictício para homologação', 1, 29.90);
  Result.Items[1] := TSaleItem.Create('ITEM-002', 'Item fictício de laboratório', 2, 4.95);
  Result.AmountPaid := 39.80;
end;

function TSale.Total: Currency;
var Item: TSaleItem;
begin
  Result := 0; for Item in Items do Result := Result + Item.Total;
end;

procedure TSale.Validate;
begin
  if Number <= 0 then raise EArgumentOutOfRangeException.Create('Número da venda deve ser positivo');
  if Length(Items) = 0 then raise EArgumentException.Create('Venda deve possuir ao menos um item');
  if Abs(Total - AmountPaid) > 0.001 then
    raise EArgumentException.CreateFmt('Pagamentos diferem do total em %.2f', [Abs(Total - AmountPaid)]);
end;

end.
