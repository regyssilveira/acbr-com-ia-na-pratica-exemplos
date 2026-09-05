object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Caixa Ágil — laboratório ACBr'
  ClientHeight = 360
  ClientWidth = 640
  Position = poScreenCenter
  TextHeight = 15
  object lblTitulo: TLabel
    Left = 24
    Top = 24
    Width = 257
    Height = 23
    Caption = 'Caixa Ágil — ambiente de laboratório'
    Font.Height = -19
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblAmbiente: TLabel
    Left = 24
    Top = 64
    Width = 387
    Height = 15
    Caption = 'Somente dados fictícios e serviços de homologação são permitidos.'
  end
  object btnVerificarAmbiente: TButton
    Left = 24
    Top = 104
    Width = 177
    Height = 33
    Caption = 'Verificar ambiente'
    TabOrder = 0
    OnClick = btnVerificarAmbienteClick
  end
  object memResultado: TMemo
    Left = 24
    Top = 152
    Width = 592
    Height = 177
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
  end
end
