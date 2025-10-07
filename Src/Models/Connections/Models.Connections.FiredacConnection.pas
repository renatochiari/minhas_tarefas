unit Models.Connections.FiredacConnection;

interface

uses Models.Connections.Contracts.Connection, Data.DB,
FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
    FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
    FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
    FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat,
    FireDAC.FMXUI.Wait, FireDAC.Comp.UI;

type
    TFiredacConnection = class(TInterfacedObject, iConnection)
    private
      FConnection: TFDConnection;

      constructor Create;
      destructor Destroy; override;

    public
      class function New: iConnection;
      function Connection: TCustomConnection;

    end;

implementation

uses
  System.SysUtils;

{ TFiredacConnection }

function TFiredacConnection.Connection: TCustomConnection;
begin
     Result := FConnection;
end;

constructor TFiredacConnection.Create;
begin
     FConnection := TFDConnection.Create(nil);

     try
          FConnection.Params.Clear;
          FConnection.Params.DriverID := 'SQLite';
          FConnection.Params.Database := 'C:\Dev\Delphi\Projetos\MinhasTarefas\DB\MinhasTarefas.db';
          FConnection.Params.UserName := '';
          FConnection.Params.Password := '';
          FConnection.Params.Add('LockingMode=Normal');

     except
          raise Exception.Create('Problemas ao criar componente de conexão');
     end;
end;

destructor TFiredacConnection.Destroy;
begin
     FConnection.Free;
     inherited;
end;

class function TFiredacConnection.New: iConnection;
begin
     Result := Self.Create;
end;

end.
