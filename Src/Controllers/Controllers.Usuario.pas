unit Controllers.Usuario;

interface

uses Models.Services.Usuario, Models.Entities.Usuario,
  Controllers.Contracts.Controller, Models.Entities.Base;

type
    TUsuarioController = class(TInterfacedObject, IController)
    private

    public
        function Salvar(entity: TBaseEntity): Boolean;
        function Excluir(entity: TBaseEntity): Boolean;
        function GetById(id: string): TBaseEntity;
        function Login(email, senha: string): Boolean;

    end;

implementation

uses
  System.SysUtils;

{ TUsuarioController }

function TUsuarioController.Excluir(entity: TBaseEntity): Boolean;
begin
    Result := False;

    try
        Result := TUsuarioService.New.Excluir(entity);
    except
        raise;
    end;
end;

function TUsuarioController.GetById(id: string): TBaseEntity;
begin
    Result := nil;

    try
        Result := TUsuarioService.New.GetById(id);
    except
        raise;
    end;
end;

function TUsuarioController.Login(email, senha: string): Boolean;
begin
    Result := False;

    try
        Result := TUsuarioService.New.Login(email, senha);
    except
        raise;
    end;
end;

function TUsuarioController.Salvar(entity: TBaseEntity): Boolean;
begin
    Result := False;

    try
        Result := TUsuarioService.New.Salvar(entity);
    except
        raise;
    end;
end;

end.
