unit Views.CadastroTarefa;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  Views.Generics.CadastroBase, FMX.Controls.Presentation, FMX.Layouts, FMX.Edit,
  FMX.Memo.Types, FMX.DateTimeCtrls, FMX.ScrollBox, FMX.Memo, DateUtils;

type
  TTarefaCadastroView = class(TBaseCadastroView)
    lblDescricao: TLabel;
    memDescricao: TMemo;
    Label1: TLabel;
    edtPrazoData: TDateEdit;
    edtPrazoHora: TTimeEdit;
  private
    procedure PreencheCampos; override;
    procedure RecuperaCampos; override;

  public
    { Public declarations }
  end;

var
  TarefaCadastroView: TTarefaCadastroView;

implementation

{$R *.fmx}

uses Models.Entities.Tarefa;

{ TTarefaCadastroView }

procedure TTarefaCadastroView.PreencheCampos;
begin
    inherited;
    if (Entity.Id.IsEmpty) then
    begin
        edtPrazoData.Date := Now;
        edtPrazoHora.Time := Now;
        Exit;
    end;

    memDescricao.Lines.Text := TTarefaEntity(Entity).Descricao;
    edtPrazoData.Date := DateOf(TTarefaEntity(Entity).Prazo);
    edtPrazoHora.Time := TimeOf(TTarefaEntity(Entity).Prazo);
end;

procedure TTarefaCadastroView.RecuperaCampos;
begin
    inherited;
    TTarefaEntity(Entity).Descricao := memDescricao.Lines.Text;
    TTarefaEntity(Entity).Prazo := edtPrazoData.Date + edtPrazoHora.Time;
end;

end.'
