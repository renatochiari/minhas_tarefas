unit Controllers.Tarefa;

interface

uses
  Controllers.Contracts.Controller, Models.Entities.Base;

type
    TTarefaController = class(TInterfacedObject, IController)
    private

    public
        function Salvar(entity: TBaseEntity): Boolean;
        function Excluir(entity: TBaseEntity): Boolean;
        function GetById(id: string): TBaseEntity;
    end;

implementation

uses
  Models.Services.Tarefa;

{ TTarefaController }

function TTarefaController.Excluir(entity: TBaseEntity): Boolean;
begin
    Result := False;

    try
        Result := TTarefaService.New.Excluir(entity);
    except
        raise;
    end;
end;

function TTarefaController.GetById(id: string): TBaseEntity;
begin
    Result := nil;

    try
        Result := TTarefaService.New.GetById(id);
    except
        raise;
    end;
end;

function TTarefaController.Salvar(entity: TBaseEntity): Boolean;
begin
    Result := False;

    try
        Result := TTarefaService.New.Salvar(entity);
    except
        raise;
    end;
end;

end.
