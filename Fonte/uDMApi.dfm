object DMApi: TDMApi
  OldCreateOrder = False
  Height = 310
  Width = 488
  object QryConsulta: TFDQuery
    Connection = DMConexao.FDConn
    SQL.Strings = (
      'select DEST.NOME, DEST.CGCCPF, NFR.NF, DEST.EMAIL, NFR.CHAVENFE'
      'from MNF'
      
        'left join TRB on MNF.EMP_CODIGO = TRB.EMP_CODIGO and MNF.CODIGO ' +
        '= TRB.MNF_CODIGO'
      
        'left join CNH on TRB.EMP_CODIGO_CNH = CNH.EMP_CODIGO and TRB.CNH' +
        '_SERIE = CNH.SERIE and TRB.CNH_CTRC = CNH.CTRC'
      
        'left join NFR on NFR.EMP_CODIGO = CNH.EMP_CODIGO and NFR.CNH_SER' +
        'IE = CNH.SERIE and NFR.CNH_CTRC = CNH.CTRC'
      'left join CLI DEST on DEST.CGCCPF = CNH.CLI_CGCCPF_DEST'
      'where NFR.CHAVENFE is not null'
      'order by CGCCPF')
    Left = 168
    Top = 72
    object QryConsultaNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 40
    end
    object QryConsultaCGCCPF: TStringField
      FieldName = 'CGCCPF'
      Origin = 'CGCCPF'
      Size = 14
    end
    object QryConsultaNF: TStringField
      FieldName = 'NF'
      Origin = 'NF'
      Size = 10
    end
    object QryConsultaEMAIL: TStringField
      FieldName = 'EMAIL'
      Origin = 'EMAIL'
      Size = 80
    end
    object QryConsultaCHAVENFE: TStringField
      FieldName = 'CHAVENFE'
      Origin = 'CHAVENFE'
      Size = 44
    end
  end
  object IdHTTP: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 232
    Top = 136
  end
end
