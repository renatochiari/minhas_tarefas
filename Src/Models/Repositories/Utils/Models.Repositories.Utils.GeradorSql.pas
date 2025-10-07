unit Models.Repositories.Utils.GeradorSql;

interface

uses
    System.Rtti, Models.Entities.Base, System.SysUtils, System.Generics.Collections;

type
    TGeradorSql = class
    private
      FEntity: TBaseEntity;
      constructor Create(entity: TBaseEntity);

      function NomeTabela: string;
      function ListarCampos(prefixo, separador: string; comValor, compararAtribuir, incluirPk, incluirCamposComuns: Boolean): string;
      function ListarValoresParametros(incluirPk, incluirCamposComuns: Boolean): TDictionary<string, Variant>;

    public
      class function New(entity: TBaseEntity): TGeradorSql;
      function Select(var retParams: TDictionary<string, Variant>; filtro: string = ''): string;
      function Insert(var retParams: TDictionary<string, Variant>): string;
      function Update(var retParams: TDictionary<string, Variant>): string;
      function Delete(var retParams: TDictionary<string, Variant>): string;

    end;

implementation

{ TGeradorSql }

uses Models.Repositories.Utils.Atributos, StrUtils;

function TGeradorSql.Delete(var retParams: TDictionary<string, Variant>): string;
begin
     retParams := ListarValoresParametros(True, False);
     Result := Format('DELETE FROM %s WHERE %s', [
       NomeTabela,
       ListarCampos(':', ' AND ', True, True, True, False)
     ]);
end;

function TGeradorSql.Insert(var retParams: TDictionary<string, Variant>): string;
begin
     retParams := ListarValoresParametros(True, True);
     Result := Format('INSERT INTO %s (%s) VALUES (%s)', [
       NomeTabela,
       ListarCampos('', ', ', False, False, True, True),
       ListarCampos(':', ', ', False, False, True, True)
     ]);
end;

constructor TGeradorSql.Create(entity: TBaseEntity);
begin
     FEntity := entity;
end;

function TGeradorSql.ListarCampos(prefixo, separador: string; comValor, compararAtribuir, incluirPk, incluirCamposComuns: Boolean): string;
begin
     Result := '';
     var rttiContext := TRttiContext.Create;
     try
         var rttiType := rttiContext.GetType(FEntity.ClassInfo);

         for var field in rttiType.GetFields do
         begin
              var addLista := false;

              try
                   if (not field.HasAttribute<Campo>) then
                      Continue;

                   if ((field.HasAttribute<PK> and not incluirPk) or (not field.HasAttribute<PK> and not incluirCamposComuns)) then
                      Continue;

                   if (not comValor) then
                   begin
                        addLista := True;
                        Continue;
                   end;

                   case field.GetValue(FEntity).TypeInfo.Kind of
                     tkInteger,tkInt64:
                         addLista := field.GetValue(FEntity).AsInteger > 0;
                     tkFloat:
                         addLista := (field.GetValue(FEntity).TypeInfo = TypeInfo(TDateTime)) or ((field.GetValue(FEntity).TypeInfo = TypeInfo(Currency)) and (field.GetValue(FEntity).AsCurrency > 0));
                     tkString, tkLString, tkWString, tkUString:
                         addLista := not field.GetValue(FEntity).AsString.IsEmpty;
                     else
                         addLista := True;
                   end;

              finally
                   if addLista then
                   begin
                        Result := Result + Format('%s%s%s%s', [
                            IfThen(compararAtribuir, field.GetAttribute<Campo>.Nome+ ' = ', ''),
                            prefixo,
                            field.GetAttribute<Campo>.Nome,
                            separador
                        ]);
                   end;
              end;
         end;

     finally
         Result := Result.Substring(0, Result.Length - separador.Length);
         rttiContext.Free;
     end;
end;

class function TGeradorSql.New(entity: TBaseEntity): TGeradorSql;
begin
     Result := Self.Create(entity);
end;

function TGeradorSql.NomeTabela: string;
begin
     var rttiContext := TRttiContext.Create;
     try
         var rttiType := rttiContext.GetType(FEntity.ClassInfo);
         if (rttiType.HasAttribute<Tabela>) then
           Result := rttiType.GetAttribute<Tabela>.Nome;

     finally
         rttiContext.Free;
     end;
end;

function TGeradorSql.ListarValoresParametros(incluirPk, incluirCamposComuns: Boolean): TDictionary<string, Variant>;
begin
     Result := TDictionary<string, Variant>.Create;
     var rttiContext := TRttiContext.Create;
     try
         var rttiType := rttiContext.GetType(FEntity.ClassInfo);

         for var field in rttiType.GetFields do
         begin
              if (not field.HasAttribute<Campo>) then
                 Continue;

              if ((field.HasAttribute<PK> and not incluirPk) or (not field.HasAttribute<PK> and not incluirCamposComuns)) then
                 Continue;

              case field.GetValue(FEntity).TypeInfo.Kind of
                tkInteger,tkInt64:
                begin
                     if (field.GetValue(FEntity).AsInteger > 0) then
                        Result.Add(field.GetAttribute<Campo>.Nome, field.GetValue(FEntity).AsInteger);
                end;
                tkFloat:
                begin
                     if (field.GetValue(FEntity).TypeInfo = TypeInfo(TDateTime)) then
                        Result.Add(field.GetAttribute<Campo>.Nome, StrToDateTime(field.GetValue(FEntity).AsString))
                     else if (field.GetValue(FEntity).TypeInfo = TypeInfo(Currency)) and (field.GetValue(FEntity).AsCurrency > 0) then
                        Result.Add(field.GetAttribute<Campo>.Nome, field.GetValue(FEntity).AsCurrency);
                end;
                tkString, tkLString, tkWString, tkUString:
                begin
                     if (not field.GetValue(FEntity).AsString.IsEmpty) then
                        Result.Add(field.GetAttribute<Campo>.Nome, field.GetValue(FEntity).AsString);
                end;
                else
                    Result.Add(field.GetAttribute<Campo>.Nome, field.GetValue(FEntity).AsString);
              end;
         end;

     finally
         rttiContext.Free;
     end;
end;

function TGeradorSql.Select(var retParams: TDictionary<string, Variant>; filtro: string): string;
begin
     if (filtro.Trim.IsEmpty) then
     begin
          filtro := ListarCampos(':', ' AND ', True, True, True, True);
          retParams := ListarValoresParametros(True, True);
     end;

     Result := Format('SELECT %s FROM %s %s', [
       ListarCampos('', ', ', False, False, True, True),
       NomeTabela,
       IfThen(filtro.IsEmpty, '', ' WHERE '+filtro)
     ]);
end;

function TGeradorSql.Update(var retParams: TDictionary<string, Variant>): string;
begin
     retParams := ListarValoresParametros(True, True);
     Result := Format('UPDATE %s SET %s WHERE %s', [
       NomeTabela,
       ListarCampos(':', ', ', False, True, False, True),
       ListarCampos(':', ', ', False, True, True, False)
     ]);
end;

end.
