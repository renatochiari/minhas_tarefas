unit Models.Connections.Contracts.Connection;

interface

uses
    Data.DB;

type
    iConnection = interface
      function Connection: TCustomConnection;
    end;

implementation

end.
