unit Views.Generics.Style;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, FMX.Memo.Types,
  FMX.ScrollBox, FMX.Memo, FMX.DateTimeCtrls;

type
  TStyleView = class(TForm)
    lblPadrao: TLabel;
    edtPadrao: TEdit;
    btnPadrao: TButton;
    styleBook: TStyleBook;
    memPadrao: TMemo;
    edtDatePadrao: TDateEdit;
    edtTimePadrao: TTimeEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  StyleView: TStyleView;

implementation

{$R *.fmx}

end.
