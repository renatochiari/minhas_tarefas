unit Views.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  Views.Generics.Base, FMX.Layouts, Models.Utils.Contracts.Observer;

type
  TMainView = class(TBaseView, IObserver)
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public
    procedure AtualizarObserver;

  end;

var
  MainView: TMainView;

implementation

{$R *.fmx}

uses Views.Login, Views.Tarefas, Models.Utils.Sessao;

{ TMainView }

procedure TMainView.AtualizarObserver;
begin
    if (TSessao.ObterInstancia.Ativa) then
        ShowView(TTarefasView)
    else
        ShowView(TLoginView);
end;

procedure TMainView.FormCreate(Sender: TObject);
begin
    inherited;
    TSessao.ObterInstancia.AddObserver(Self);
end;

procedure TMainView.FormShow(Sender: TObject);
begin
    inherited;
    ShowView(TLoginView);
end;

end.
