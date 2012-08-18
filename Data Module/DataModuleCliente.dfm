object DataModule1: TDataModule1
  OldCreateOrder = False
  Left = 545
  Top = 439
  Height = 181
  Width = 216
  object IBQuery1: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    Active = True
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'select * from CARDAPIO Order By Codigo asc')
    Left = 16
    Top = 16
  end
  object IBDatabase1: TIBDatabase
    Connected = True
    DatabaseName = '..\Projeto LDD\Banco\CARDAPIO.GDB'
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey')
    LoginPrompt = False
    DefaultTransaction = IBTransaction1
    IdleTimer = 0
    SQLDialect = 3
    TraceFlags = []
    Left = 72
    Top = 16
  end
  object IBTransaction1: TIBTransaction
    Active = True
    DefaultDatabase = IBDatabase1
    AutoStopAction = saNone
    Left = 144
    Top = 16
  end
  object DataSource1: TDataSource
    DataSet = IBQuery1
    Left = 24
    Top = 80
  end
end
