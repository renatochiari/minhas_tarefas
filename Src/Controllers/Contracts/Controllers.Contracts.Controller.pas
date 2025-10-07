unit Controllers.Contracts.Controller;

interface

uses Models.Entities.Base;

type
    IController = interface
        function Salvar(entity: TBaseEntity): Boolean;
        function Excluir(entity: TBaseEntity): Boolean;
        function GetById(id: string): TBaseEntity;
    end;

implementation

end.
