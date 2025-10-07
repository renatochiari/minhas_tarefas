unit Models.Services.Contracts.Service;

interface

uses
  Models.Entities.Base;

type
    IService = interface
        function Salvar(entity: TBaseEntity): Boolean;
        function Excluir(entity: TBaseEntity): Boolean;
        function GetById(id: string): TBaseEntity;
    end;

implementation

end.
