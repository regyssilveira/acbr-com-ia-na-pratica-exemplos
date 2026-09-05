unit CaixaAgil.App;

interface

uses
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
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  CaixaAgil.Fiscal.DataModule;

{$R *.dfm}

procedure TfrmPrincipal.btnVerificarAmbienteClick(Sender: TObject);
begin
  memResultado.Lines.Text := dmFiscal.DescreverAmbiente;
end;

end.
