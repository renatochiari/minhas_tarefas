unit Models.Connections.Contracts.DataSet;

interface

uses
    System.Generics.Collections, Data.DB;

type
    iDataSet = interface
      function Open(const sql: string; const params: TDictionary<string, Variant>): TDataSet;
      procedure ExecSQL(const sql: string; const params: TDictionary<string, Variant>);
    end;

implementation

end.
