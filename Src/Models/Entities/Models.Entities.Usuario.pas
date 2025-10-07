unit Models.Entities.Usuario;

interface

uses Models.Entities.Base, System.SysUtils, Models.Repositories.Utils.Atributos;

type
    [Tabela('USUARIOS')]
    TUsuarioEntity = class(TBaseEntity)
    private
      [Campo('NOME')]
      FNome: string;
      [Campo('EMAIL')]
      FEmail: string;
      [Campo('SENHA')]
      FSenha: string;
      procedure SetEmail(const Value: string);
      procedure SetNome(const Value: string);
      procedure SetSenha(const Value: string);

    public
      constructor Create; overload;
      constructor Create(id: string; nome, email, senha: string); overload;
      function EhValido: Boolean; override;

      property Nome: string read FNome write SetNome;
      property Email: string read FEmail write SetEmail;
      property Senha: string read FSenha write SetSenha;

    end;

implementation

{ TUsuarioEntity }

constructor TUsuarioEntity.Create;
begin
     inherited;
     FNome := '';
     FEmail := '';
     FSenha := '';
end;

constructor TUsuarioEntity.Create(id: string; nome, email, senha: string);
begin
     inherited Create(id);
     Self.Nome := nome;
     Self.Email := email;
     Self.Senha := senha;
end;

function TUsuarioEntity.EhValido: Boolean;
begin
     inherited;

     if (FEmail.Trim.IsEmpty) then
        Notificacoes.Add('E-mail não informado');

     if (FNome.Trim.IsEmpty) then
        Notificacoes.Add('Nome não informado');

     if (FSenha.Trim.IsEmpty) then
        Notificacoes.Add('Senha não informada');

     Result := Notificacoes.Count = 0;
end;

procedure TUsuarioEntity.SetEmail(const Value: string);
begin
     FEmail := Value.Trim.Substring(0,100);
end;

procedure TUsuarioEntity.SetNome(const Value: string);
begin
     FNome := Value.Trim.Substring(0,60);
end;

procedure TUsuarioEntity.SetSenha(const Value: string);
begin
     FSenha := Value.Trim.Substring(0,100);
end;

end.
