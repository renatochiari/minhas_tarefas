unit Models.Repositories.Utils.Atributos;

interface

type
    Campo = class(TCustomAttribute)
    private
      FNome: string;
    public
      constructor Create(nome: string);
      property Nome: string read FNome;
    end;

    Tabela = class(TCustomAttribute)
    private
      FNome: string;
    public
      constructor Create(nome: string);
      property Nome: string read FNome;
    end;

    PK = class(TCustomAttribute)
    end;

implementation

{ Campo }

constructor Campo.Create(nome: string);
begin
     FNome := nome;
end;

{ Tabela }

constructor Tabela.Create(nome: string);
begin
     FNome := nome;
end;

end.
