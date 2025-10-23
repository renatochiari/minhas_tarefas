unit Models.Connections.FiredacDataSet;

interface

uses Models.Connections.Contracts.DataSet, Data.DB, System.Generics.Collections,
  FireDAC.Comp.Client, Models.Connections.Contracts.Connection;

type
    TFiredacDataSet = class(TInterfacedObject, iDataSet)
    private
      FQuery: TFDQuery;

      procedure AlimentaQuery(sql: string);
      procedure AlimentaParams(params: TDictionary<string, Variant>);

      constructor Create(conn: iConnection);
      destructor Destroy; override;

    public
      class function New(conn: iConnection): iDataSet;
      function Open(const sql: string; const params: TDictionary<string, Variant>): TDataSet;
      procedure ExecSQL(const sql: string; const params: TDictionary<string, Variant>);

    end;

implementation

{ TFiredacDataSet }

procedure TFiredacDataSet.AlimentaParams(params: TDictionary<string, Variant>);
begin
    if (not Assigned(params) or params.IsEmpty) then
       Exit;

    for var param in params do
    begin
        if Assigned(FQuery.ParamByName(param.Key)) then
            FQuery.ParamByName(param.Key).Value := param.Value;
    end;
end;

procedure TFiredacDataSet.AlimentaQuery(sql: string);
begin
     FQuery.Close;
     FQuery.SQL.Clear;
     FQuery.SQL.Add(sql);
end;

constructor TFiredacDataSet.Create(conn: iConnection);
begin
     FQuery := TFDQuery.Create(nil);
     FQuery.Connection := TFDConnection(conn.Connection);
end;

destructor TFiredacDataSet.Destroy;
begin
     FQuery.Free;
     inherited;
end;

procedure TFiredacDataSet.ExecSQL(const sql: string; const params: TDictionary<string, Variant>);
begin
     AlimentaQuery(sql);
     AlimentaParams(params);
     FQuery.ExecSQL;
end;

class function TFiredacDataSet.New(conn: iConnection): iDataSet;
begin
     Result := Self.Create(conn);
end;

function TFiredacDataSet.Open(const sql: string; const params: TDictionary<string, Variant>): TDataSet;
begin
     AlimentaQuery(sql);
     AlimentaParams(params);
     FQuery.Open;
     Result := FQuery;
end;

end.
