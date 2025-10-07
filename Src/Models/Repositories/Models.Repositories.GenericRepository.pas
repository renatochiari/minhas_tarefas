unit Models.Repositories.GenericRepository;

interface

uses Models.Repositories.Contracts.Repository, System.Generics.Collections, Models.Entities.Base,
  Models.Connections.Contracts.Connection, Models.Connections.Contracts.DataSet,
  Models.Repositories.Utils.GeradorSql, Models.Repositories.Utils.Atributos,
  Data.DB, SysUtils;

type
    TGenericRepository = class(TInterfacedObject, iRepository)
    private
      FEntity: TBaseEntity;
      FConexao: iConnection;
      FDataSet: iDataSet;

      constructor Create(entity: TBaseEntity);
      function DataSetToListEntity(dataSet: TDataSet): TList<TBaseEntity>;

    public
      class function New(entity: TBaseEntity): iRepository;
      function Select: TList<TBaseEntity>; overload;
      function Select(condition: string): TList<TBaseEntity>; overload;
      function Insert: Boolean;
      function Update: Boolean;
      function Delete: Boolean;

    end;

implementation

{ TGenericRepository }

uses Models.Connections.FiredacConnection, Models.Connections.FiredacDataSet, System.Rtti;

constructor TGenericRepository.Create(entity: TBaseEntity);
begin
     FEntity := entity;
     FConexao := TFiredacConnection.New;
     FDataSet := TFiredacDataSet.New(FConexao);
end;

function TGenericRepository.DataSetToListEntity(dataSet: TDataSet): TList<TBaseEntity>;
begin
     Result := TList<TBaseEntity>.Create;

     if (dataSet.IsEmpty) then
        Exit;

     var rttiContext := TRttiContext.Create;
     try
          dataSet.First;
          while (not dataSet.Eof) do
          begin
               var entity := FEntity.NovaInstancia;
               var rttiType := rttiContext.GetType(entity.ClassInfo);

               for var field in rttiType.GetFields do
               begin
                   if (not field.HasAttribute<Campo>) then
                      Continue;

                   if (dataSet.FieldByName(field.GetAttribute<Campo>.Nome) <> nil) then
                      field.SetValue(entity, TValue.FromVariant(dataSet.FieldByName(field.GetAttribute<Campo>.Nome).Value));
               end;

               Result.Add(entity);
               dataSet.Next;
          end;

     finally
         rttiContext.Free;
     end;
end;

function TGenericRepository.Delete: Boolean;
begin
     var params: TDictionary<string, Variant>;
     var sql := TGeradorSql.New(FEntity).Delete(params);
     FDataSet.ExecSQL(sql, params);
end;

function TGenericRepository.Select(condition: string): TList<TBaseEntity>;
begin
     var params := TDictionary<string, Variant>.Create;
     var sql := TGeradorSql.New(FEntity).Select(params, condition);
     var query := FDataSet.Open(sql, params);
     Result := DataSetToListEntity(query);
end;

function TGenericRepository.Select: TList<TBaseEntity>;
begin
     Result := Select('');
end;

function TGenericRepository.Insert: Boolean;
begin
    if FEntity.Id.Trim.IsEmpty then
        FEntity.Id := TGUID.NewGuid.ToString.Replace('{', '', [rfReplaceAll]).Replace('}', '', [rfReplaceAll]);

     var params: TDictionary<string, Variant>;
     var sql := TGeradorSql.New(FEntity).Insert(params);
     FDataSet.ExecSQL(sql, params);
end;

class function TGenericRepository.New(entity: TBaseEntity): iRepository;
begin
     Result := Self.Create(entity);
end;

function TGenericRepository.Update: Boolean;
begin
     var params: TDictionary<string, Variant>;
     var sql := TGeradorSql.New(FEntity).Update(params);
     FDataSet.ExecSQL(sql, params);
end;

end.
