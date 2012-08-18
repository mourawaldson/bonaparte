unit Cls_Cardapio;

interface


Type
 TCardapio = Class

 Private
  Codigo        : Integer;
  Nome_do_Prato : String[30];
  Descricao     : String[255];
  Preco         : Real;

 Public
  Function GetCodigo        : Integer;
  Function GetNome_do_Prato : String;
  Function GetDescricao     : String;
  Function GetPreco         : Real;

  Procedure SetCodigo        (Cod   : Integer);
  Procedure SetNome_do_Prato (Prato : String);
  Procedure SetDescricao     (Des   : String);
  Procedure SetPreco         (ValPreco : Real);

  Procedure Inserir;
  Procedure Excluir;
  Procedure Alterar(Cod:Integer);
  Procedure CarregarDataSet;
  Function ProximoCodigo: Integer;

End;

implementation

uses DataModule, db, SysUtils, SqlExpr, IBQuery, Math;

{ TCardapio }


procedure TCardapio.Inserir;
begin

 Try

  With DataModule1.IBQueryCardapio Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('Insert Into Cardapio (Codigo,Nome_do_Prato,Descricao,Preco) Values (:pCod,:pPrato,:pDes,:pPreco)');
      ParamByName('pCod').AsInteger  := Codigo;
      ParamByName('pPrato').AsString := Nome_do_Prato;
      ParamByName('pDes').AsString   := Descricao;
      ParamByName('pPreco').AsFloat  := Preco;
      ExecSQL;
      DataModule1.IBTransactionCardapio.Commit;
    End;

 Except
  On E: Exception Do
    Begin
      DataModule1.IBTransactionCardapio.Rollback;
      Raise Exception.Create('Erro ao inserir um prato');
    End;
    
 End;

end;

procedure TCardapio.Alterar(Cod: Integer);
begin

 Try

   With DataModule1.IBQueryCardapio Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('Update Cardapio Set Nome_do_Prato=:pPrato,Descricao=:pDes,Preco=:pPreco Where Codigo=:pCod');
      ParamByName('pPrato').AsString := Nome_do_Prato;
      ParamByName('pDes').AsString   := Descricao;
      ParamByName('pPreco').AsFloat  := Preco;
      ParamByName('pCod').AsInteger  := Codigo;
      ExecSQL;
    End;

 Except
  Raise Exception.Create('Erro ao alterar informações do prato');
 End;

end;

procedure TCardapio.Excluir;
begin

 Try

  With DataModule1.IBQueryCardapio Do
    Begin
     Close;
     SQL.Clear;
     SQL.Add('Delete From Cardapio Where Codigo =:pCod');
     ParamByName('pCod').AsInteger := Codigo;
     ExecSQL;
    End;

 Except
  Raise Exception.Create('Erro ao remover um prato');
 End;

end;

procedure TCardapio.CarregarDataSet;
begin

 Try

  With DataModule1.IBQueryCardapio Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('Select * From Cardapio Order By Codigo asc');
      Open;
    End;

 Except
  Raise Exception.Create('Erro ao carregar data set dos pratos');
 End

end;

function TCardapio.GetCodigo: Integer;
begin
  Result := Codigo;
end;

function TCardapio.GetDescricao: String;
begin
  Result := Descricao;
end;

function TCardapio.GetNome_do_Prato: String;
begin
  Result := Nome_do_Prato;
end;

function TCardapio.GetPreco: Real;
begin
  Result := Preco;
end;

procedure TCardapio.SetCodigo(Cod: Integer);
begin
  Codigo := Cod;
end;

procedure TCardapio.SetDescricao(Des: String);
begin
  Descricao := Des;
end;

procedure TCardapio.SetNome_do_Prato(Prato: String);
begin
  Nome_do_Prato := Prato;
end;

procedure TCardapio.SetPreco(ValPreco: Real);
begin
  Preco := ValPreco;
end;

function TCardapio.ProximoCodigo: Integer;
begin
  Try

    With DataModule1.IBQueryCardapioAux Do
      Begin
        Active := False;
        SQL.Clear;
        SQL.Add('Select max (Codigo) From Cardapio');
        Active := True;
        If (IsEmpty) Then
          Result := 1
        Else
          Result := FieldByName('max').AsInteger + 1;
        End;
    Except
      On E: Exception Do
      Raise Exception.Create('Erro ao gerar próximo código');
    End;

end;

end.
