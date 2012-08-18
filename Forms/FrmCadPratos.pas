unit FrmCadPratos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, Buttons, Mask, DBCtrls, jpeg, ExtCtrls,
  ComCtrls, DataModule, Cls_Cardapio, DB, SqlExpr;

type
  TFrmCardapio = class(TForm)
    ImageLogo: TImage;
    DBGridPratos: TDBGrid;
    ShapePratos: TShape;
    btnIncluir: TBitBtn;
    ShapePesquisa: TShape;
    DBEditCod: TDBEdit;
    DBEditNomePrato: TDBEdit;
    DBEditValor: TDBEdit;
    LabelCod: TLabel;
    LabelNomePrato: TLabel;
    LabelValor: TLabel;
    LabelDescricao: TLabel;
    DBMemoDescricao: TDBMemo;
    BtnPesquisar: TBitBtn;
    LabelPesqCod: TLabel;
    LabelPesqNomePrato: TLabel;
    LabelPesqValor: TLabel;
    LabelPesqDescricao: TLabel;
    LabelPrato: TLabel;
    LabelPesquisa: TLabel;
    EditPesqCod: TEdit;
    EditPesqNomePrato: TEdit;
    EditPesqPreco: TEdit;
    MemoPesqDescricao: TMemo;
    btnExcluir: TBitBtn;
    BtnEditar: TBitBtn;
    procedure BtnPesquisarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure EditPesqNomePratoChange(Sender: TObject);
    procedure MemoPesqDescricaoChange(Sender: TObject);
    procedure EditPesqCodChange(Sender: TObject);
    procedure EditPesqPrecoChange(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure EditPesqCodKeyPress(Sender: TObject; var Key: Char);
    procedure BtnEditarClick(Sender: TObject);
    procedure EditPesqPrecoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCardapio: TFrmCardapio;
  Cardapio   : TCardapio;

implementation

uses FrmIncluir, Math, FrmEditar, Types;

{$R *.dfm}

procedure TFrmCardapio.BtnPesquisarClick(Sender: TObject);
begin
  If DataModule1.IBQueryCardapio.IsEmpty Then
    ShowMessage('Não é possível pesquisar sem antes ter algum prato cadastrado!')
  Else
    If ((DBGridPratos.Top = 465) And (DBGridPratos.Height = 203)) Then
      Begin
        EditPesqCod.Clear;
        EditPesqNomePrato.Clear;
        EditPesqPreco.Clear;
        MemoPesqDescricao.Clear;
        LabelPesqCod.Visible := False;
        LabelPesqNomePrato.Visible := False;
        LabelPesqValor.Visible := False;
        LabelPesqDescricao.Visible := False;
        LabelPesquisa.Visible := False;
        ShapePesquisa.Visible := False;
        btnExcluir.Visible := False;
        BtnEditar.Visible := False;
        EditPesqCod.Visible := False;
        EditPesqNomePrato.Visible := False;
        EditPesqPreco.Visible := False;
        MemoPesqDescricao.Visible := False;
        DBGridPratos.Top := 328;
        DBGridPratos.Height := 340;
      End
    Else
      Begin
        DBGridPratos.Top := 465;
        DBGridPratos.Height := 203;
        LabelPesqCod.Visible := True;
        LabelPesqNomePrato.Visible := True;
        LabelPesqValor.Visible := True;
        LabelPesqDescricao.Visible := True;
        LabelPesquisa.Visible := True;
        ShapePesquisa.Visible := True;
        btnExcluir.Visible := True;
        BtnEditar.Visible := True;
        EditPesqCod.Visible := True;
        EditPesqNomePrato.Visible := True;
        EditPesqPreco.Visible := True;
        MemoPesqDescricao.Visible := True;
        EditPesqCod.SetFocus;
      End;
end;

procedure TFrmCardapio.btnIncluirClick(Sender: TObject);
begin
  If ((DBGridPratos.Top = 465) And (DBGridPratos.Height = 203)) Then
    Begin
      EditPesqCod.Clear;
      EditPesqNomePrato.Clear;
      EditPesqPreco.Clear;
      MemoPesqDescricao.Clear;
      LabelPesqCod.Visible := False;
      LabelPesqNomePrato.Visible := False;
      LabelPesqValor.Visible := False;
      LabelPesqDescricao.Visible := False;
      LabelPesquisa.Visible := False;
      ShapePesquisa.Visible := False;
      btnExcluir.Visible := False;
      BtnEditar.Visible := False;
      EditPesqCod.Visible := False;
      EditPesqNomePrato.Visible := False;
      EditPesqPreco.Visible := False;
      MemoPesqDescricao.Visible := False;
      DBGridPratos.Top := 328;
      DBGridPratos.Height := 340;
    End;
  Application.CreateForm(TFrm_Incluir, Frm_Incluir);
  Frm_Incluir.ShowModal;
end;

procedure TFrmCardapio.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmCardapio.FormCreate(Sender: TObject);
begin
  Cardapio := TCardapio.Create;
end;

procedure TFrmCardapio.EditPesqNomePratoChange(Sender: TObject);
Var
  NomePrato: String;

begin

  If Trim(EditPesqNomePrato.Text) <> '' Then
    Begin
      NomePrato := EditPesqNomePrato.Text;
      With DataModule1.IBQueryCardapio Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT * FROM CARDAPIO WHERE Upper(Nome_do_Prato) LIKE ' + QuotedStr('%' + Uppercase(NomePrato) + '%'));
          Open;
          First;
          btnExcluir.Enabled := True;
          BtnEditar.Enabled := True;
        End;
    End
  Else
    Begin
      With DataModule1.IBQueryCardapio Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT * FROM CARDAPIO ORDER BY CODIGO ASC');
          Open;
          First;
          btnExcluir.Enabled := False;
          BtnEditar.Enabled := False;
        End;
    End;

  If DataModule1.IBQueryCardapio.IsEmpty Then
    Begin
      btnExcluir.Enabled := False;
      BtnEditar.Enabled := False;
      ShowMessage('Nenhum registro foi encontrado');
      DataModule1.IBQueryCardapio.Close;
      DataModule1.IBQueryCardapio.SQL.Clear;
      DataModule1.IBQueryCardapio.SQL.Add('SELECT * FROM CARDAPIO ORDER BY CODIGO ASC');
      DataModule1.IBQueryCardapio.Open;
      DataModule1.IBQueryCardapio.First;
      EditPesqCod.Clear;
      EditPesqNomePrato.Clear;
      EditPesqPreco.Clear;
      MemoPesqDescricao.Clear;
    End;

end;

procedure TFrmCardapio.MemoPesqDescricaoChange(Sender: TObject);
Var
  Descricao: String;

begin

  If Trim(MemoPesqDescricao.Text) <> '' Then
    Begin
      Descricao := MemoPesqDescricao.Text;
      With DataModule1.IBQueryCardapio Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT * FROM CARDAPIO WHERE Upper(Descricao) LIKE ' + QuotedStr('%' + UpperCase(Descricao) + '%'));
          Open;
          First;
          btnExcluir.Enabled := True;
          BtnEditar.Enabled := True;
        End;
    End
  Else
    Begin
      With DataModule1.IBQueryCardapio Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT * FROM CARDAPIO ORDER BY CODIGO ASC');
          Open;
          First;
          btnExcluir.Enabled := False;
          BtnEditar.Enabled := False;
        End;
    End;

  If DataModule1.IBQueryCardapio.IsEmpty Then
    Begin
      btnExcluir.Enabled := False;
      BtnEditar.Enabled := False;
      ShowMessage('Nenhum registro foi encontrado');
      DataModule1.IBQueryCardapio.Close;
      DataModule1.IBQueryCardapio.SQL.Clear;
      DataModule1.IBQueryCardapio.SQL.Add('SELECT * FROM CARDAPIO ORDER BY CODIGO ASC');
      DataModule1.IBQueryCardapio.Open;
      DataModule1.IBQueryCardapio.First;
      EditPesqCod.Clear;
      EditPesqNomePrato.Clear;
      EditPesqPreco.Clear;
      MemoPesqDescricao.Clear;
    End;

end;

procedure TFrmCardapio.EditPesqCodChange(Sender: TObject);
Var
  Codigo: String;

begin

  If Trim(EditPesqCod.Text) <> '' Then
    Begin
      Codigo := EditPesqCod.Text;
      With DataModule1.IBQueryCardapio Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT * FROM CARDAPIO WHERE Upper(Codigo) LIKE ' + QuotedStr('%' + UpperCase(Codigo) + '%'));
          Open;
          First;
          btnExcluir.Enabled := True;
          BtnEditar.Enabled := True;
        End;
    End
  Else
    Begin
      With DataModule1.IBQueryCardapio Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT * FROM CARDAPIO ORDER BY CODIGO ASC');
          Open;
          First;
          btnExcluir.Enabled := False;
          BtnEditar.Enabled := False;
        End;
    End;

  If DataModule1.IBQueryCardapio.IsEmpty Then
    Begin
      btnExcluir.Enabled := False;
      BtnEditar.Enabled := False;
      ShowMessage('Nenhum registro foi encontrado');
      DataModule1.IBQueryCardapio.Close;
      DataModule1.IBQueryCardapio.SQL.Clear;
      DataModule1.IBQueryCardapio.SQL.Add('SELECT * FROM CARDAPIO ORDER BY CODIGO ASC');
      DataModule1.IBQueryCardapio.Open;
      DataModule1.IBQueryCardapio.First;
      EditPesqCod.Clear;
      EditPesqNomePrato.Clear;
      EditPesqPreco.Clear;
      MemoPesqDescricao.Clear;
    End;

end;

procedure TFrmCardapio.EditPesqPrecoChange(Sender: TObject);
Var
  Preco: String;

begin

  If Trim(EditPesqPreco.Text) <> '' Then
    Begin
      Preco := EditPesqPreco.Text;
      With DataModule1.IBQueryCardapio Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT * FROM CARDAPIO WHERE Upper(Preco) LIKE ' + QuotedStr('%' + UpperCase(Preco) + '%'));
          Open;
          First;
          btnExcluir.Enabled := True;
          BtnEditar.Enabled := False;
        End;
    End
  Else
    Begin
      With DataModule1.IBQueryCardapio Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT * FROM CARDAPIO ORDER BY CODIGO ASC');
          Open;
          First;
          btnExcluir.Enabled := False;
          BtnEditar.Enabled := False;
        End;
    End;

  If DataModule1.IBQueryCardapio.IsEmpty Then
    Begin
      btnExcluir.Enabled := False;
      BtnEditar.Enabled := False;
      ShowMessage('Nenhum registro foi encontrado');
      DataModule1.IBQueryCardapio.Close;
      DataModule1.IBQueryCardapio.SQL.Clear;
      DataModule1.IBQueryCardapio.SQL.Add('SELECT * FROM CARDAPIO ORDER BY CODIGO ASC');
      DataModule1.IBQueryCardapio.Open;
      DataModule1.IBQueryCardapio.First;
      EditPesqCod.Clear;
      EditPesqNomePrato.Clear;
      EditPesqPreco.Clear;
      MemoPesqDescricao.Clear;
    End;

end;

procedure TFrmCardapio.btnExcluirClick(Sender: TObject);
begin
  Cardapio := TCardapio.Create;
  EditPesqCod.Text := DBEditCod.Text;
  Cardapio.SetCodigo(StrToInt(EditPesqCod.Text));
  If Application.MessageBox('Você deseja excluir o prato?', 'Bonaparte', Mb_YesNo+Mb_IconQuestion)=IDYes Then
    Begin
      Cardapio.Excluir;
      EditPesqCod.Clear;
      EditPesqNomePrato.Clear;
      EditPesqPreco.Clear;
      MemoPesqDescricao.Clear;
      EditPesqCod.SetFocus;
      Cardapio.CarregarDataSet;
      Cardapio.Free;
    End
  Else
    Begin
      EditPesqCod.Clear;
      EditPesqNomePrato.Clear;
      EditPesqPreco.Clear;
      MemoPesqDescricao.Clear;
      DataModule1.IBQueryCardapio.Close;
      DataModule1.IBQueryCardapio.SQL.Clear;
      DataModule1.IBQueryCardapio.SQL.Add('SELECT * FROM CARDAPIO ORDER BY CODIGO ASC');
      DataModule1.IBQueryCardapio.Open;
      DataModule1.IBQueryCardapio.First;
      EditPesqCod.SetFocus;
    End;
end;

procedure TFrmCardapio.EditPesqCodKeyPress(Sender: TObject; var Key: Char);
begin
  If Not (Key In ['0'..'9', #8]) Then
    Key := #0;
end;

procedure TFrmCardapio.BtnEditarClick(Sender: TObject);
begin
  Application.CreateForm(TFrm_Editar, Frm_Editar);
  Frm_Editar.ShowModal;
end;

procedure TFrmCardapio.EditPesqPrecoKeyPress(Sender: TObject;
  var Key: Char);
begin
  If Not (Key In ['0'..'9', #8, #44]) Then
    Key := #0;
end;

end.
