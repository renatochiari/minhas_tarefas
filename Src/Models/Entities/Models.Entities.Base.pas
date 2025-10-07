unit Models.Entities.Base;

interface

uses
    System.SysUtils, Models.Repositories.Utils.Atributos, System.Rtti,
  System.Classes;

type
    TBaseEntity = class
    private
      [Campo('ID'), PK]
      FId: string;
      FNotificacoes: TStringList;
    procedure SetId(const Value: string);

    public
      constructor Create; overload;
      constructor Create(id: string); overload;
      function EhValido: Boolean; virtual;

      property Id: string read FId write SetId;
      property Notificacoes: TStringList read FNotificacoes;

    end;


    TBaseEntityHelper = class helper for TBaseEntity
      function NovaInstancia: TBaseEntity;
    end;

implementation

{ TBaseEntity }

constructor TBaseEntity.Create;
begin
    FId := '';
end;

constructor TBaseEntity.Create(id: string);
begin
    SetId(id)
end;

function TBaseEntity.EhValido: Boolean;
begin
    FNotificacoes := TStringList.Create;
    Result := FNotificacoes.Count = 0;
end;

procedure TBaseEntity.SetId(const Value: string);
begin
    if (not FId.Trim.IsEmpty or Value.Trim.IsEmpty) then
        Exit;

    FId := Value;
end;

{ TBaseEntityHelper }

function TBaseEntityHelper.NovaInstancia: TBaseEntity;
begin
     Result := nil;

     var rttiContext := TRttiContext.Create;
     try
         var rttiType := rttiContext.GetType(Self.ClassInfo);
         var metodoCreate := rttiType.GetMethod('Create');
         if not Assigned(metodoCreate) then
            Exit;

         Result := metodoCreate.Invoke(rttiType.AsInstance.MetaclassType, []).AsObject as TBaseEntity;
         
     finally
         rttiContext.Free;
     end;
end;

end.
