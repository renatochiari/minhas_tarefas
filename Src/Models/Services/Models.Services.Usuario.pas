unit Models.Services.Usuario;

interface

uses
  Models.Repositories.Contracts.Repository, Models.Entities.Usuario,
  Models.Utils.Sessao, Models.Services.Contracts.Service, Models.Entities.Base;

type
    TUsuarioService = class(TInterfacedObject, IService)
    private
      constructor Create;

    public
      class function New: TUsuarioService;
      function Salvar(entity: TBaseEntity): Boolean;
      function Excluir(entity: TBaseEntity): Boolean;
      function GetById(id: string): TBaseEntity;
      function GetByEmail(email: string): TUsuarioEntity;
      function Login(email, senha: string): Boolean;

    end;

implementation

{ TUsuarioService }

uses Models.Repositories.GenericRepository, System.SysUtils;

constructor TUsuarioService.Create;
begin
     inherited;
end;

function TUsuarioService.Excluir(entity: TBaseEntity): Boolean;
begin
     Result := False;

     if (GetById(entity.Id) = nil) then
     begin
          raise Exception.Create('Usuário não localizado');
     end;

     try
          Result := TGenericRepository.New(entity).Delete;

     except on e: Exception do
          raise Exception.Create('Problemas ao excluir usuário: '+e.Message);
     end;
end;

function TUsuarioService.GetByEmail(email: string): TUsuarioEntity;
begin
    Result := nil;

    if (email.Trim.IsEmpty) then
        Exit;

    var usuario := TUsuarioEntity.Create('');
    try
        usuario.Email := email;
        var consulta := TGenericRepository.New(usuario).Select;
        if (consulta.IsEmpty) then
            Exit;

        Result := TUsuarioEntity(consulta[0]);

    finally
        usuario.Free;
    end;
end;

function TUsuarioService.GetById(id: string): TBaseEntity;
begin
     Result := nil;

     if (id.Trim.IsEmpty) then
        Exit;

     var consulta := TGenericRepository.New(TUsuarioEntity.Create(id)).Select;
     if (consulta.IsEmpty) then
        Exit;

     Result := consulta[0] as TUsuarioEntity;
end;

function TUsuarioService.Login(email, senha: string): Boolean;
begin
    Result := False;

    if (email.IsEmpty or senha.IsEmpty) then
    begin
        raise Exception.Create('Informe o e-mail e a senha');
        Exit;
    end;

    var usuario := GetByEmail(email);
    if (not Assigned(usuario) or not usuario.Senha.Equals(senha)) then
    begin
        raise Exception.Create('E-mail ou senha incorretos');
        Exit;
    end;

    TSessao.ObterInstancia.Logout;
    TSessao.ObterInstancia.Usuario := usuario;
    Result := TSessao.ObterInstancia.Ativa;
end;

function TUsuarioService.Salvar(entity: TBaseEntity): Boolean;
begin
    Result := False;

    if (not entity.EhValido) then
    begin
        raise Exception.Create('Dados inválidos:'+sLineBreak+entity.Notificacoes.Text);
        Exit;
    end;

    try
        if (GetById(entity.Id) = nil) then
        begin
            if (GetByEmail(TUsuarioEntity(entity).Email) <> nil) then
            begin
                raise Exception.Create('E-mail já utilizado por outro usuário!');
                Exit;
            end;

            Result := TGenericRepository.New(entity).Insert;
        end
        else
            Result := TGenericRepository.New(entity).Update;

    except on e: Exception do
        raise Exception.Create('Problemas ao gravar usuário: '+e.Message);
    end;
end;

class function TUsuarioService.New: TUsuarioService;
begin
     Result := Self.Create;
end;

end.
