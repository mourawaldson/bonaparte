unit FrmIncluir;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DataModule, Cls_Cardapio, ExtCtrls, Mask,
  DBCtrls;

type
  TFrm_Incluir = class(TForm)
    ImageLogo: TImage;
    LabelCod: TLabel;
    LabelNomePrato: TLabel;
    LabelDescricao: TLabel;
    LabelPreco: TLabel;
    EditCod: TEdit;
    EditNomePrato: TEdit;
    EditPreco: TEdit;
    MemoDescricao: TMemo;
    btnSalvar: TBitBtn;
    btnCancelar: TBitBtn;
    procedure btnSalvarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EditCodKeyPress(Sender: TObject; var Key: Char);
    procedure EditPrecoKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_Incluir: TFrm_Incluir;
  Cardapio  : TCardapio;

implementation

{$R *.dfm}

procedure TFrm_Incluir.btnSalvarClick(Sender: TObject);
begin
  If Trim(EditNomePrato.Text) = '' Then
    Begin
      ShowMessage('Preencha o nome do prato');
      EditNomePrato.SetFocus;
    End
  Else
    Begin
      If Trim(EditPreco.Text) = '' Then
        Begin
          ShowMessage('Preencha o valor do prato');
          EditPreco.SetFocus;
        End
      Else
        If Trim(MemoDescricao.Text) = '' Then
          Begin
            ShowMessage('Preencha uma breve descrição sobre o prato');
            MemoDescricao.SetFocus;
          End
        Else
          Begin
            Cardapio := TCardapio.Create;
            Cardapio.SetCodigo(StrToInt(EditCod.Text));
            Cardapio.SetNome_do_Prato(EditNomePrato.Text);
            Cardapio.SetDescricao(MemoDescricao.Text);
            Cardapio.SetPreco(StrToFloat(EditPreco.Text));
            Cardapio.Inserir;
            EditCod.Text := IntToStr(Cardapio.ProximoCodigo);
            Cardapio.CarregarDataSet;
            EditNomePrato.Clear;
            EditPreco.Clear;
            MemoDescricao.Clear;
            ShowMessage('Prato inserido com sucesso!');
            EditNomePrato.SetFocus;
            Cardapio.Free;
          End;
    End;
end;

procedure TFrm_Incluir.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrm_Incluir.EditCodKeyPress(Sender: TObject; var Key: Char);
begin
  If (EditNomePrato.Text <> '') And (EditPreco.Text <> '') And (MemoDescricao.Text <> '') Then
    btnSalvar.Enabled := True
  Else
    btnSalvar.Enabled := False;

  If Not (Key In ['0'..'9', #8]) Then
    Key := #0;
end;

procedure TFrm_Incluir.EditPrecoKeyPress(Sender: TObject; var Key: Char);
begin
  If Not (Key In ['0'..'9', #8, #44]) Then
    Key := #0;
end;

procedure TFrm_Incluir.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFrm_Incluir.FormCreate(Sender: TObject);
begin
  EditCod.Text := IntToStr(Cardapio.ProximoCodigo);
end;

end.
