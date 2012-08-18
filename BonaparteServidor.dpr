program BonaparteServidor;

uses
  Forms,
  FrmCadPratos in 'Forms\FrmCadPratos.pas' {FrmCardapio},
  FrmIncluir in 'Forms\FrmIncluir.pas' {Frm_Incluir},
  DataModule in 'Data Module\DataModule.pas' {DataModule1: TDataModule},
  Cls_Cardapio in 'Classes\Cls_Cardapio.pas',
  FrmEditar in 'Forms\FrmEditar.pas' {Frm_Editar};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Cardápio Virtual - Bonaparte';
  Application.CreateForm(TFrmCardapio, FrmCardapio);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
