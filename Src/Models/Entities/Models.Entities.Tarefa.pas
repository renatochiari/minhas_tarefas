unit Models.Entities.Tarefa;

interface

uses
  Models.Entities.Base, System.SysUtils, Models.Repositories.Utils.Atributos;

type
    [Tabela('TAREFAS')]
    TTarefaEntity = class(TBaseEntity)
    private
        [Campo('USUARIOID')]
        FUsuarioId: string;
        [Campo('DESCRICAO')]
        FDescricao: string;
        [Campo('PRAZO')]
        FPrazo: TDateTime;
        [Campo('CONCLUIDO')]
        FConcluido: Boolean;
        [Campo('DATAHORACONCLUSAO')]
        FDataHoraConclusao: TDateTime;
        procedure SetDescricao(const Value: string);
    procedure SetConcluido(const Value: Boolean);

    public
        constructor Create; overload;
        constructor Create(usuarioId: string); overload;
        constructor Create(id: string; usuarioId: string; descricao: string; prazo: TDateTime; concluido: Boolean; dataHoraConclusao: TDateTime); overload;
        function EhValido: Boolean; override;

        property UsuarioId: string read FUsuarioId write FUsuarioId;
        property Descricao: string read FDescricao write SetDescricao;
        property Prazo: TDateTime read FPrazo write FPrazo;
        property Concluido: Boolean read FConcluido write SetConcluido;
        property DataHoraConclusao: TDateTime read FDataHoraConclusao write FDataHoraConclusao;

    end;

implementation

{ TTarefaEntity }

constructor TTarefaEntity.Create(usuarioId: string);
begin
     inherited;
     FUsuarioId := usuarioId;
     FDescricao := '';
     FPrazo := 0;
     FConcluido := False;
     FDataHoraConclusao := 0;
end;

constructor TTarefaEntity.Create(id, usuarioId: string; descricao: string; prazo: TDateTime; concluido: Boolean; dataHoraConclusao: TDateTime);
begin
     inherited Create(id);
     Self.UsuarioId := usuarioId;
     Self.Descricao := descricao;
     Self.Prazo := prazo;
     Self.Concluido := concluido;
     Self.DataHoraConclusao := dataHoraConclusao;
end;

function TTarefaEntity.EhValido: Boolean;
begin
    inherited;

    if (UsuarioId.Trim.IsEmpty) then
        Notificacoes.Add('Usuário não definido');

    if (Descricao.Trim.IsEmpty) then
        Notificacoes.Add('Descrição não informada');

    if (Prazo = 0) then
        Notificacoes.Add('Prazo não informado');

    Result := Notificacoes.Count = 0;
end;

constructor TTarefaEntity.Create;
begin
     inherited;
     Self.Create('');
end;

procedure TTarefaEntity.SetConcluido(const Value: Boolean);
begin
    FConcluido := Value;

    if (FConcluido and (FDataHoraConclusao = 0)) then
        FDataHoraConclusao := Now
    else
        FDataHoraConclusao := 0;
end;

procedure TTarefaEntity.SetDescricao(const Value: string);
begin
     FDescricao := Value.Trim.Substring(0,2000);
end;

end.
