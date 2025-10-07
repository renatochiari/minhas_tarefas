unit Views.CadastroUsuario;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  Views.Generics.CadastroBase, FMX.Controls.Presentation, FMX.Layouts, FMX.Edit;

type
  TUsuarioCadastroView = class(TBaseCadastroView)
    edtNome: TEdit;
    lblNome: TLabel;
    edtEmail: TEdit;
    lblEmail: TLabel;
    edtSenha: TEdit;
    lblSenha: TLabel;
  private
    procedure PreencheCampos; override;
    procedure RecuperaCampos; override;
  public
    { Public declarations }
  end;

var
  UsuarioCadastroView: TUsuarioCadastroView;

implementation

{$R *.fmx}

uses Models.Entities.Usuario;

{ TUsuarioCadastroView }

procedure TUsuarioCadastroView.PreencheCampos;
begin
    inherited;
    edtNome.Text := TUsuarioEntity(Entity).Nome;
    edtEmail.Text := TUsuarioEntity(Entity).Email;
    edtSenha.Text := TUsuarioEntity(Entity).Senha;
end;

procedure TUsuarioCadastroView.RecuperaCampos;
begin
    inherited;
    TUsuarioEntity(Entity).Nome := edtNome.Text;
    TUsuarioEntity(Entity).Email := edtEmail.Text;
    TUsuarioEntity(Entity).Senha := edtSenha.Text;
end;

end.
