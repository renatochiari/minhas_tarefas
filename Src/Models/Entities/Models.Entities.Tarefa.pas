unit Models.Entities.Tarefa;

interface

uses
  Models.Entities.Base, System.SysUtils;

type
    TTarefaEntity = class(TBaseEntity)
    private
      FUsuarioId: string;
      FDescricao: string;
      FPrazo: TDateTime;
      FConcluido: Boolean;
      FDataHoraConclusao: TDateTime;
      procedure SetDescricao(const Value: string);

    public
      constructor Create; overload;
      constructor Create(usuarioId: string); overload;
      constructor Create(id: string; usuarioId: string; descricao: string; prazo: TDateTime; concluido: Boolean; dataHoraConclusao: TDateTime); overload;

      property UsuarioId: string read FUsuarioId write FUsuarioId;
      property Descricao: string read FDescricao write SetDescricao;
      property Prazo: TDateTime read FPrazo write FPrazo;
      property Concluido: Boolean read FConcluido write FConcluido;
      property DataHoraConclusao: TDateTime read FDataHoraConclusao write FDataHoraConclusao;

    end;

implementation

{ TTarefaEntity }

constructor TTarefaEntity.Create(usuarioId: string);
begin
     inherited;
     FUsuarioId := usuarioId; { TODO : implementar pegando o usuário logado a partir da sessão ativa }
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

constructor TTarefaEntity.Create;
begin
     inherited;
     Self.Create('');
end;

procedure TTarefaEntity.SetDescricao(const Value: string);
begin
     FDescricao := Value.Trim.Substring(0,2000);
end;

end.
