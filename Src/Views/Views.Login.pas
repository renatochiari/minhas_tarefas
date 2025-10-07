unit Views.Login;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  Views.Generics.Base, FMX.Layouts, FMX.Controls.Presentation, FMX.Edit;

type
  TLoginView = class(TBaseView)
    Layout1: TLayout;
    edtEmail: TEdit;
    edtSenha: TEdit;
    btnEntrar: TButton;
    btnRegistrar: TButton;
    procedure btnEntrarClick(Sender: TObject);
    procedure btnRegistrarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LoginView: TLoginView;

implementation

{$R *.fmx}

uses Controllers.Usuario, Views.CadastroUsuario, Models.Entities.Usuario;

procedure TLoginView.btnEntrarClick(Sender: TObject);
begin
    TUsuarioController.Create.Login(edtEmail.Text, edtSenha.Text);
end;

procedure TLoginView.btnRegistrarClick(Sender: TObject);
begin
    var form := TUsuarioCadastroView.Create(TUsuarioController.Create, TUsuarioEntity.Create);
    try
        form.ShowModal;
    finally
        form.Free;
    end;
end;

end.
