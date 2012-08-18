unit FrmEditar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Cls_Cardapio;

type
  TFrm_Editar = class(TForm)
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
    procedure FormCreate(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure EditPrecoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_Editar: TFrm_Editar;
  Cardapio : TCardapio;

implementation

uses FrmCadPratos, Mask;

{$R *.dfm}

procedure TFrm_Editar.FormCreate(Sender: TObject);
begin
  EditCod.Text := FrmCardapio.DBEditCod.Text;
  EditNomePrato.Text := FrmCardapio.DBEditNomePrato.Text;
  EditPreco.Text := FrmCardapio.DBEditValor.Text;
  MemoDescricao.Text := FrmCardapio.DBMemoDescricao.Text;
end;

procedure TFrm_Editar.btnSalvarClick(Sender: TObject);
begin  If (EditNomePrato.Text = '') Then
    Begin
      ShowMessage('Preencha o nome do prato');
      EditNomePrato.SetFocus;
    End
  Else
    If (EditPreco.Text = '') Then
      Begin
        ShowMessage('Preencha o valor do prato');
        EditPreco.SetFocus;
      End
    Else
      If (MemoDescricao.Text = '') Then
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
          Cardapio.Alterar(StrToInt(EditCod.Text));
          Cardapio.CarregarDataSet;
          FrmCardapio.EditPesqCod.Clear;
          FrmCardapio.EditPesqNomePrato.Clear;
          FrmCardapio.EditPesqPreco.Clear;
          FrmCardapio.MemoPesqDescricao.Clear;
          FrmCardapio.EditPesqCod.SetFocus;
          ShowMessage('Informações alteradas com sucesso');
          Cardapio.Free;
          Frm_Editar.Close;
        End;
end;

procedure TFrm_Editar.btnCancelarClick(Sender: TObject);
begin
  FrmCardapio.EditPesqCod.Clear;
  FrmCardapio.EditPesqNomePrato.Clear;
  FrmCardapio.EditPesqPreco.Clear;
  FrmCardapio.MemoPesqDescricao.Clear;
  FrmCardapio.EditPesqCod.SetFocus;
  Close;
end;

procedure TFrm_Editar.EditPrecoKeyPress(Sender: TObject; var Key: Char);
begin
  If Not (Key In ['0'..'9', #8, #44]) Then
    Key := #0;
end;

end.
