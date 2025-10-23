unit Models.Services.Tarefa;

interface

uses
  Models.Services.Contracts.Service, Models.Entities.Base;

type
    TTarefaService = class(TInterfacedObject, IService)
    private
        constructor Create;

    public
        class function New: TTarefaService;
        function Salvar(entity: TBaseEntity): Boolean;
        function Excluir(entity: TBaseEntity): Boolean;
        function GetById(id: string): TBaseEntity;

    end;

implementation

uses
  System.SysUtils, Models.Repositories.GenericRepository,
  Models.Entities.Tarefa, Models.Utils.Sessao;

{ TTarefaService }

constructor TTarefaService.Create;
begin
    inherited;
end;

function TTarefaService.Excluir(entity: TBaseEntity): Boolean;
begin
    Result := False;

    if (GetById(entity.Id) = nil) then
    begin
         raise Exception.Create('Tarefa não localizada');
    end;

    try
         Result := TGenericRepository.New(entity).Delete;

    except on e: Exception do
         raise Exception.Create('Problemas ao excluir tarefa: '+e.Message);
    end;
end;

function TTarefaService.GetById(id: string): TBaseEntity;
begin
    Result := nil;

    if (id.Trim.IsEmpty) then
       Exit;

    var consulta := TGenericRepository.New(TTarefaEntity.Create(id)).Select;
    if (consulta.IsEmpty) then
       Exit;

    Result := consulta[0] as TTarefaEntity;
end;

class function TTarefaService.New: TTarefaService;
begin
    Result := Self.Create;
end;

function TTarefaService.Salvar(entity: TBaseEntity): Boolean;
begin
    Result := False;

    if (TTarefaEntity(entity).UsuarioId.IsEmpty) then
        TTarefaEntity(entity).UsuarioId := TSessao.ObterInstancia.Usuario.Id;

    if (not entity.EhValido) then
    begin
        raise Exception.Create('Dados inválidos:'+sLineBreak+entity.Notificacoes.Text);
        Exit;
    end;

    try
        if (GetById(entity.Id) = nil) then
            Result := TGenericRepository.New(entity).Insert
        else
            Result := TGenericRepository.New(entity).Update;

    except on e: Exception do
        raise Exception.Create('Problemas ao gravar tarefa: '+e.Message);
    end;
end;

end.
