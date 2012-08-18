unit FrmNotaFiscal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QuickRpt, QRCtrls, ExtCtrls, QRExport, xmldom, XMLIntf,
  msxmldom, XMLDoc;

type
  TFrm_NotaFiscal = class(TForm)
    QuickRep: TQuickRep;
    QRBand2: TQRBand;
    QRMemo: TQRMemo;
    QRBand1: TQRBand;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRImage1: TQRImage;
    QRLabel1: TQRLabel;
    QRSysData1: TQRSysData;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_NotaFiscal: TFrm_NotaFiscal;

implementation

{$R *.dfm}

end.
