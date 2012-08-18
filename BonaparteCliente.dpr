program BonaparteCliente;

uses
  Forms,
  FrmCardapio in 'Forms\FrmCardapio.pas' {Frm_Cardapio},
  DataModuleCliente in 'Data Module\DataModuleCliente.pas' {DataModule1: TDataModule},
  UClsFuncao in 'Classes\UClsFuncao.pas',
  FrmNotaFiscal in 'Forms\FrmNotaFiscal.pas' {Frm_NotaFiscal};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Bonaparte';
  Application.CreateForm(TFrm_Cardapio, Frm_Cardapio);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TFrm_NotaFiscal, Frm_NotaFiscal);
  Application.Run;
end.
