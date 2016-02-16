object DMConexao: TDMConexao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 350
  Width = 478
  object FDConnTest: TFDConnection
    LoginPrompt = False
    Left = 264
    Top = 16
  end
  object FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink
    Left = 160
    Top = 16
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 160
    Top = 80
  end
  object FDConn: TFDConnection
    Params.Strings = (
      'Database=C:\Projetos\DAE_Service\Banco\CARGAS32.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=FB')
    LoginPrompt = False
    Left = 48
    Top = 16
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 224
    Top = 160
  end
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 360
    Top = 176
  end
  object FDStanStorageXMLLink1: TFDStanStorageXMLLink
    Left = 336
    Top = 104
  end
  object FDStanStorageBinLink1: TFDStanStorageBinLink
    Left = 248
    Top = 232
  end
end
