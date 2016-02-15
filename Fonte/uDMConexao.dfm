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
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=MSSQL')
    LoginPrompt = False
    Left = 48
    Top = 16
  end
end
