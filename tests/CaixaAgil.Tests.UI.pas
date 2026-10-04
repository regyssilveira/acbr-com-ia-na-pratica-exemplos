unit CaixaAgil.Tests.UI;

interface

uses
  DUnitX.TestFramework;

type
  [TestFixture]
  TUITests = class
  public
    [Test] procedure ButtonIsDisabledAndRestored;
    [Test] procedure ReentrantClickDoesNotRunAgain;
    [Test] procedure FailureRestoresButtonAndAllowsRetry;
  end;

implementation

uses
  System.SysUtils,
  Vcl.Forms,
  CaixaAgil.App;

type
  TControlledForm = class(TfrmPrincipal)
  public
    Calls: Integer;
    TryReentry, RaiseFailure, SawDisabled: Boolean;
  protected
    procedure ExecuteLocalLaboratory; override;
  end;

procedure TControlledForm.ExecuteLocalLaboratory;
begin
  Inc(Calls);
  SawDisabled := not btnVerificarAmbiente.Enabled;
  if TryReentry then
    btnVerificarAmbienteClick(Self);
  if RaiseFailure then
    raise Exception.Create('Simulated local failure');
end;

procedure TUITests.ButtonIsDisabledAndRestored;
var
  Form: TControlledForm;
begin
  Form := TControlledForm.Create(nil);
  try
    Form.btnVerificarAmbienteClick(Form);
    Assert.IsTrue(Form.SawDisabled);
    Assert.IsTrue(Form.btnVerificarAmbiente.Enabled);
    Assert.AreEqual(1, Form.Calls);
  finally
    Form.Free;
  end;
end;

procedure TUITests.ReentrantClickDoesNotRunAgain;
var
  Form: TControlledForm;
begin
  Form := TControlledForm.Create(nil);
  try
    Form.TryReentry := True;
    Form.btnVerificarAmbienteClick(Form);
    Assert.AreEqual(1, Form.Calls);
    Assert.IsTrue(Form.SawDisabled);
    Assert.IsTrue(Form.btnVerificarAmbiente.Enabled);
  finally
    Form.Free;
  end;
end;

procedure TUITests.FailureRestoresButtonAndAllowsRetry;
var
  Form: TControlledForm;
  FailureObserved: Boolean;
begin
  Form := TControlledForm.Create(nil);
  try
    Form.RaiseFailure := True;
    FailureObserved := False;
    try
      Form.btnVerificarAmbienteClick(Form);
    except
      on E: Exception do
        FailureObserved := E.Message = 'Simulated local failure';
    end;
    Assert.IsTrue(FailureObserved);
    Assert.IsTrue(Form.btnVerificarAmbiente.Enabled);
    Form.RaiseFailure := False;
    Form.btnVerificarAmbienteClick(Form);
    Assert.AreEqual(2, Form.Calls);
  finally
    Form.Free;
  end;
end;

initialization
  TDUnitX.RegisterTestFixture(TUITests);
end.
