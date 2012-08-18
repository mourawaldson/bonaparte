object DataModule1: TDataModule1
  OldCreateOrder = False
  Left = 203
  Top = 273
  Height = 258
  Width = 268
  object DataSourceCardapio: TDataSource
    DataSet = IBQueryCardapio
    Left = 75
    Top = 111
  end
  object IBQueryCardapio: TIBQuery
    Database = IBDatabaseCardapio
    Transaction = IBTransactionCardapio
    Active = True
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'select * from CARDAPIO Order By Codigo asc')
    Left = 72
    Top = 160
  end
  object IBDatabaseCardapio: TIBDatabase
    Connected = True
    DatabaseName = '..\Projeto LDD\Banco\CARDAPIO.GDB'
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey')
    LoginPrompt = False
    DefaultTransaction = IBTransactionCardapio
    IdleTimer = 0
    SQLDialect = 3
    TraceFlags = []
    Left = 72
    Top = 16
  end
  object IBTransactionCardapio: TIBTransaction
    Active = True
    DefaultDatabase = IBDatabaseCardapio
    AutoStopAction = saNone
    Left = 72
    Top = 64
  end
  object IBQueryCardapioAux: TIBQuery
    Database = IBDatabaseCardapio
    Transaction = IBTransactionCardapio
    BufferChunks = 1000
    CachedUpdates = False
    Left = 168
    Top = 160
  end
end
