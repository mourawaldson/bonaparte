unit UClsPedido;

interface

Type
 TPedido = Class
  Private
    Referencia: Integer;
    Nome_do_Prato: String;
    Preco: Double;
    Descricao: String;
  Public
    ListaPedidos: array of TPedido;
    Function getReferencia: Integer;
    Function getNome_do_Prato: String;
    Function getPreco: Double;
    Function getDescricao: String;
    Procedure setReferencia (R:Integer);
    Procedure setNome_do_Prato (NP: String);
    Procedure setPreco (P:Double);
    Procedure setDescricao (D:String);

   Procedure Armazenar(var I: Integer; R: Integer; NP: String; P: Double; D: String);
   Procedure Excluir(Ref: Integer; I:Integer);

    Constructor Create(R:Integer; NP:String; P:Double; D:String);
    Destructor Free;
end;


implementation

Uses DataModuleCliente, db, SysUtils;


{ TPedido }

procedure TPedido.Armazenar(var I: Integer; R: Integer; NP: String; P: Double; D: String);
begin
  SetLength(ListaPedidos, I+1);
  ListaPedidos[I] := TPedido.Create(R,NP,P,D)
end;

constructor TPedido.Create(R: Integer; NP: String; P: Double; D: String);
begin
  Referencia := R;
  Nome_do_Prato:= NP;
  Preco := P;
  Descricao:= D;
end;

procedure TPedido.Excluir(Ref: Integer; I:Integer);
begin
  ListaPedidos[I].Free;
end;

destructor TPedido.Free;
begin
  Referencia := 0;
  Nome_do_Prato := '';
  Preco := 0;
  Descricao := '';

end;

function TPedido.getDescricao: String;
begin
  Result := Descricao;
end;

function TPedido.getNome_do_Prato: String;
begin
  Result := Nome_do_Prato;
end;

function TPedido.getPreco: Double;
begin
  Result := Preco;
end;

function TPedido.getReferencia: Integer;
begin
  Result := Referencia;
end;

procedure TPedido.setDescricao(D: String);
begin
  Descricao := D;
end;

procedure TPedido.setNome_do_Prato(NP: String);
begin
  Nome_do_Prato := NP;
end;

procedure TPedido.setPreco(P: Double);
begin
  Preco := P;
end;

procedure TPedido.setReferencia(R: Integer);
begin
  Referencia := R;
end;

end.
 