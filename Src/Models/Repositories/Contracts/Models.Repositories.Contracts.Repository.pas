unit Models.Repositories.Contracts.Repository;

interface

uses Models.Entities.Base, System.Generics.Collections;

type
    iRepository = interface
      function Select: TList<TBaseEntity>; overload;
      function Select(condition: string): TList<TBaseEntity>; overload;
      function Insert: Boolean;
      function Update: Boolean;
      function Delete: Boolean;
    end;

implementation

end.
