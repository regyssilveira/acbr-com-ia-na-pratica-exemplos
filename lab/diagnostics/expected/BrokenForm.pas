unit BrokenForm;
interface
uses System.Classes, Vcl.Forms, Vcl.StdCtrls, ACBrNFe;
type
  TBrokenForm = class(TForm)
    Button1: TButton;
    ACBrNFe1: TACBrNFe;
    procedure MissingClick(Sender: TObject);
  end;
implementation
{$R *.dfm}
procedure TBrokenForm.MissingClick(Sender: TObject);
begin
end;
end.
