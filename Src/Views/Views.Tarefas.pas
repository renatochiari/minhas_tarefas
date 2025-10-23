unit Views.Tarefas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  Views.Generics.Base, FMX.Layouts, FMX.Controls.Presentation;

type
  TTarefasView = class(TBaseView)
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TarefasView: TTarefasView;

implementation

{$R *.fmx}

uses Models.Utils.Sessao, Views.CadastroTarefa, Controllers.Tarefa,
  Models.Entities.Tarefa;

procedure TTarefasView.Button1Click(Sender: TObject);
begin
    TSessao.ObterInstancia.Logout;
end;

procedure TTarefasView.Button2Click(Sender: TObject);
begin

    var form := TTarefaCadastroView.Create(TTarefaController.Create, TTarefaEntity.Create);
    try
        form.ShowModal;
    finally
        form.Free;
    end;
end;

end.
