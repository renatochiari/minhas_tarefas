unit Models.Utils.Sessao;

interface

uses Models.Entities.Usuario, Models.Utils.Contracts.Subject,
  Models.Utils.Contracts.Observer, System.Generics.Collections;

type
    TSessao = class(TInterfacedObject, ISubject)
    private
        FUsuario: TUsuarioEntity;
        FObservers: TList<IObserver>;

        constructor Create;
        procedure SetUsuario(const Value: TUsuarioEntity);

        procedure NotificarObservers;

    public
        class function ObterInstancia: TSessao;
        class function NewInstance: TObject; override;

        property Usuario: TUsuarioEntity read FUsuario write SetUsuario;
        function Logout: Boolean;
        function Ativa: Boolean;

        procedure AddObserver(observer: IObserver);
        procedure RemObserver(observer: IObserver);

    end;

var
    Instancia: TSessao;

implementation

uses
  System.SysUtils;

{ TSessao }

procedure TSessao.AddObserver(observer: IObserver);
begin
    if (not Assigned(FObservers)) then
        FObservers := TList<IObserver>.Create;

    FObservers.Add(observer);
end;

function TSessao.Ativa: Boolean;
begin
    Result := Assigned(Instancia) and Assigned(FUsuario);
end;

constructor TSessao.Create;
begin

end;

function TSessao.Logout: Boolean;
begin
    FreeAndNil(FUsuario);
    Result := True;
    NotificarObservers;
end;

class function TSessao.NewInstance: TObject;
begin
    if (not Assigned(Instancia)) then
        Instancia := TSessao(inherited NewInstance);

    Result := Instancia;
end;

procedure TSessao.NotificarObservers;
begin
    for var observer in FObservers do
    begin
        observer.AtualizarObserver;
    end;
end;

class function TSessao.ObterInstancia: TSessao;
begin
    Result := TSessao.Create;
end;

procedure TSessao.RemObserver(observer: IObserver);
begin
    if (not Assigned(FObservers)) then
        Exit;

    FObservers.Delete(FObservers.IndexOf(observer));
end;

procedure TSessao.SetUsuario(const Value: TUsuarioEntity);
begin
    if Assigned(FUsuario) then
    begin
        raise Exception.Create('Já existe um usuário logado');
        Exit;
    end;

    FUsuario := Value;
    NotificarObservers;
end;

end.
