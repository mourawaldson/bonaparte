unit UClsFuncao;

interface
Type
  TFuncao = Class

  Public
  Codigo        : Integer;
  Nome_do_Prato : String[30];
  Descricao     : String[255];
  Preco         : Real;

  Function GetNome_do_Prato : String;

  //Function Localizar(pNome: String):Boolean;

  
End;

implementation

uses  DataModuleCliente, db, SysUtils;

{ TFuncao }

function TFuncao.GetNome_do_Prato: String;
begin
  Result := Nome_do_Prato;
end;


end.
 