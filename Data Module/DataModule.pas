unit DataModule;

interface

uses
  SysUtils, Classes, FMTBcd, DBXpress, DB, DBClient, SimpleDS, SqlExpr,
  Provider, IBDatabase, IBCustomDataSet, IBQuery;

type
  TDataModule1 = class(TDataModule)
    DataSourceCardapio: TDataSource;
    IBQueryCardapio: TIBQuery;
    IBDatabaseCardapio: TIBDatabase;
    IBTransactionCardapio: TIBTransaction;
    IBQueryCardapioAux: TIBQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{$R *.dfm}

end.
