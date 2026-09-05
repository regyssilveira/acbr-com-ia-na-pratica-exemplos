object dmFiscal: TdmFiscal
  Height = 240
  Width = 320
  object ACBrNFe: TACBrNFe
    Configuracoes.Geral.ModeloDF = moNFCe
    Configuracoes.Geral.FormatoAlerta = 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.'
    Configuracoes.Geral.VersaoDF = ve400
    Configuracoes.Arquivos.OrdenacaoPath = <>
    Configuracoes.WebServices.UF = 'MG'
    Configuracoes.WebServices.Ambiente = taHomologacao
    Configuracoes.WebServices.AguardarConsultaRet = 15000
    Configuracoes.WebServices.AjustaAguardaConsultaRet = True
    Configuracoes.WebServices.TimeOut = 20000
    Configuracoes.WebServices.QuebradeLinha = '|'
    Left = 40
    Top = 32
  end
end
