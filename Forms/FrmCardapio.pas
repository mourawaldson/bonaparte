unit FrmCardapio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, jpeg, ExtCtrls, Mask, DBCtrls, XPMan,
  Buttons, DBXpress, FMTBcd, SqlExpr, DB, DBClient, Provider, {FrmNotaFiscal, QRExport,}
  XMLBrokr;

type
  TFrm_Cardapio = class(TForm)
    w: TImage;
    DBGrid1: TDBGrid;
    EditPesquisa: TEdit;
    Label1: TLabel;
    DBEditRef: TDBEdit;
    DBEditPrato: TDBEdit;
    DBEditPreco: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ListBox1: TListBox;
    Label6: TLabel;
    btnIncluir: TBitBtn;
    btnExcluir: TBitBtn;
    BtnCalcular: TBitBtn;
    btnRegistra: TBitBtn;
    XPManifest1: TXPManifest;
    RadioButtonPrato: TRadioButton;
    RadioButtonDescricao: TRadioButton;
    DBMemoDescricao: TDBMemo;
    MemoHTML: TMemo;
    procedure BtnCalcularClick(Sender: TObject);
    procedure EditPesquisaChange(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure EditPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnRegistraClick(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;


var
  Frm_Cardapio: TFrm_Cardapio;
  Acum : Integer;
  Total : Real;
  
implementation

uses DataModuleCliente, UClsFuncao, FrmNotaFiscal;

{$R *.dfm}

procedure TFrm_Cardapio.BtnCalcularClick(Sender: TObject);
begin
  WinExec('calc.exe', SW_SHOW);
end;


procedure TFrm_Cardapio.EditPesquisaChange(Sender: TObject);
Var
  busca: String;

begin

  If (Trim(EditPesquisa.Text) <> '') And (RadioButtonPrato.Checked) Then
    Begin
      busca := EditPesquisa.Text;
      With DataModule1.IBQuery1 Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT * FROM CARDAPIO WHERE Upper(Nome_do_Prato) LIKE ' + QuotedStr('%' + Uppercase(busca) + '%'));
          Open;
          First;
        End;
    End
  Else
  If (Trim(EditPesquisa.Text) <> '') And (RadioButtonDescricao.Checked) Then
    Begin
      busca := EditPesquisa.Text;
      With DataModule1.IBQuery1 Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT * FROM CARDAPIO WHERE Upper(Descricao) LIKE ' + QuotedStr('%' + Uppercase(busca) + '%'));
          Open;
          First;
        End;
    End

  Else
    Begin
      With DataModule1.IBQuery1 Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT * FROM CARDAPIO Order By Codigo asc');
          Open;
          First;
        End;
    End;
   If DataModule1.IBQuery1.IsEmpty Then
    Begin
      ShowMessage('Nenhum prato foi encontrado');
      DataModule1.IBQuery1.Close;
      DataModule1.IBQuery1.SQL.Clear;
      DataModule1.IBQuery1.SQL.Add('SELECT * FROM CARDAPIO ORDER BY CODIGO ASC');
      DataModule1.IBQuery1.Open;
      DataModule1.IBQuery1.First;
      EditPesquisa.Clear;

    End;

end;


procedure TFrm_Cardapio.btnIncluirClick(Sender: TObject);
Begin

  Total := Total + StrToFloat(DBEditPreco.Text);

  If (Length(DBEditRef.Text) = 1) And (Length(DBEditPreco.Text) = 4) Then
    ListBox1.Items.Add('0'+ DBEditRef.Text + ' - ' + DBEditPrato.Text + ' - R$ ' + DBEditPreco.Text + '0')
  Else If (Length(DBEditRef.Text) = 1) And (Length(DBEditPreco.Text) = 5) Then
    ListBox1.Items.Add('0'+ DBEditRef.Text + ' - ' + DBEditPrato.Text + ' - R$ ' + DBEditPreco.Text)
  Else If (Length(DBEditRef.Text) = 2) And (Length(DBEditPreco.Text) = 4) Then
    ListBox1.Items.Add(DBEditRef.Text + ' - ' + DBEditPrato.Text + ' - R$ ' + DBEditPreco.Text + '0')
  Else
    ListBox1.Items.Add(DBEditRef.Text + ' - ' + DBEditPrato.Text + ' - R$ ' + DBEditPreco.Text);


 If (ListBox1.Items.Count = 0) Then
   btnRegistra.Enabled := False
 Else
   btnRegistra.Enabled := True;
end;


procedure TFrm_Cardapio.ListBox1Click(Sender: TObject);
var
 x : integer;
begin
  x:=ListBox1.ItemIndex;
  If (ListBox1.ItemIndex <> -1) Then
    Begin
      If (ListBox1.Selected[x] = True) Then
        btnExcluir.Enabled := True
    End
  Else
    Exit;
end;

procedure TFrm_Cardapio.btnExcluirClick(Sender: TObject);
begin
  ListBox1.DeleteSelected;
  btnExcluir.Enabled := false;
end;

procedure TFrm_Cardapio.EditPesquisaKeyPress(Sender: TObject;
  var Key: Char);
begin
 if not (key in['a'.. 'z', 'A'.. 'Z', #8, #32]) then
  key := #0;
end;

procedure TFrm_Cardapio.FormCreate(Sender: TObject);
begin
  RadioButtonPrato.Checked := True;
  btnExcluir.Enabled := False;
  btnRegistra.Enabled := False;
  Acum := 0;
  ShortDateFormat := 'dd.mm.yyyy';
  DecimalSeparator:= ',';
  DateSeparator := '.';

end;

procedure TFrm_Cardapio.btnRegistraClick(Sender: TObject);
var
  M,J : Integer;
  I : Integer;

begin

  ListBox1.Items.Add('');
  ListBox1.Items.Add('___________________________________________________________________________');
  ListBox1.Items.Add('');

  If (Length(FloatToStr(Total)) = 4) Or (Length(FloatToStr(Total)) = 5) Then
    Begin
      ListBox1.Items.Add('--> Valor total do pedido - R$' + FloatToStr(Total) + '0 <--');
      btnRegistra.Enabled := False;
    End
  Else
    Begin
      ListBox1.Items.Add('--> Valor total do pedido - R$' + FloatToStr(Total) + ' <--');
      btnRegistra.Enabled := False;
    End;

 Acum := Acum + 1;

 MemoHTML.Lines.Add('<html>');
 MemoHTML.Lines.Add('<head>');
 MemoHTML.Lines.Add('<title>Nota Fiscal - Bonaparte</title>');
 MemoHTML.Lines.Add('</head>');
 MemoHTML.Lines.Add('<body>');
 MemoHTML.Lines.Add('<center><table cellspacing="0" cellpadding="1" aling="center">');
 MemoHTML.Lines.Add('<tr>');
 MemoHTML.Lines.Add('<td align="center" colspan="3">Nota Fiscal</td>');
 MemoHTML.Lines.Add('</tr>');
 MemoHTML.Lines.Add('<tr>');
 MemoHTML.Lines.Add('<td colspan="3">&nbsp;</td>');
 MemoHTML.Lines.Add('</tr>');
 MemoHTML.Lines.Add('</table>');
 MemoHTML.Lines.Add('<table cellspacing="0" cellpadding="1" aling="center" border="1">');
 MemoHTML.Lines.Add('<tr>');
 MemoHTML.Lines.Add('<td align="center" width="3%" bgcolor="#c1c1c1">#</td>');
 MemoHTML.Lines.Add('<td align="center" width="30%" bgcolor="#c1c1c1">Nome do Prato</td>');
 MemoHTML.Lines.Add('<td align="center" width="10%" bgcolor="#c1c1c1">Preço R$</td>');
 MemoHTML.Lines.Add('</tr>');

 Begin
  For I := 0 To ListBox1.Count-1 Do
    Begin
      If (ListBox1.Items[I] = '') Then
        Break
      Else
        Begin
         MemoHTML.Lines.Add('<tr>');
         MemoHTML.Lines.Add('<td align="center" width="3%">'+ Copy(ListBox1.Items[I],1,2)+'</td>');
         MemoHTML.Lines.Add('<td align="center" width="30%">'+ Copy(ListBox1.Items[I],6,Length(ListBox1.Items[I])-15)+'</td>');
         MemoHTML.Lines.Add('<td align="center" width="10%">'+ Copy(ListBox1.Items[I],Length(ListBox1.Items[I])-4,5)+'</td>');
         MemoHTML.Lines.Add('</tr>');
        End;
    End;
  End;

 MemoHTML.Lines.Add('<tr>');
 MemoHTML.Lines.Add('<td align="center" width="10%" colspan="3">'+ Copy(ListBox1.Items[I+3],1,Length(ListBox1.Items[I+3])) +'</td>');
 MemoHTML.Lines.Add('</tr>');
 MemoHTML.Lines.Add('</table></center>');
 MemoHTML.Lines.Add('</body>');
 MemoHTML.Lines.Add('</html>');

 MemoHTML.Lines.SaveToFile('C:\Documents and Settings\tarde\Desktop\Projeto LDD\Nota Fiscal '+ IntToStr(Acum) + ' - ' + DateTimeToStr(Date) +'.html');

 MemoHTML.Clear;

  Application.CreateForm(TFrm_NotaFiscal, Frm_NotaFiscal);
  Frm_NotaFiscal.QRMemo.lines.Clear;
    M := listbox1.Items.Count;
      if M > 0 then
        for J := 0 to (M-1) do
        Frm_NotaFiscal.QRMemo.Lines.Insert(J,listbox1.Items.Strings[J]);
        Frm_NotaFiscal.QuickRep.Preview;

  ListBox1.Clear;

end;

end.


