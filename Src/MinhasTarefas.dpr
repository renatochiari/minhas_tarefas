program MinhasTarefas;

uses
  System.StartUpCopy,
  FMX.Forms,
  Models.Entities.Usuario in 'Models\Entities\Models.Entities.Usuario.pas',
  Models.Entities.Base in 'Models\Entities\Models.Entities.Base.pas',
  Models.Entities.Tarefa in 'Models\Entities\Models.Entities.Tarefa.pas',
  Models.Repositories.Utils.Atributos in 'Models\Repositories\Utils\Models.Repositories.Utils.Atributos.pas',
  Models.Repositories.Utils.GeradorSql in 'Models\Repositories\Utils\Models.Repositories.Utils.GeradorSql.pas',
  Models.Connections.Contracts.Connection in 'Models\Connections\Contracts\Models.Connections.Contracts.Connection.pas',
  Models.Connections.FiredacConnection in 'Models\Connections\Models.Connections.FiredacConnection.pas',
  Models.Connections.Contracts.DataSet in 'Models\Connections\Contracts\Models.Connections.Contracts.DataSet.pas',
  Models.Connections.FiredacDataSet in 'Models\Connections\Models.Connections.FiredacDataSet.pas',
  Models.Repositories.Contracts.Repository in 'Models\Repositories\Contracts\Models.Repositories.Contracts.Repository.pas',
  Models.Repositories.GenericRepository in 'Models\Repositories\Models.Repositories.GenericRepository.pas',
  Models.Services.Usuario in 'Models\Services\Models.Services.Usuario.pas',
  Models.Utils.Sessao in 'Models\Utils\Models.Utils.Sessao.pas',
  Controllers.Usuario in 'Controllers\Controllers.Usuario.pas',
  Models.Utils.Contracts.Observer in 'Models\Utils\Contracts\Models.Utils.Contracts.Observer.pas',
  Models.Utils.Contracts.Subject in 'Models\Utils\Contracts\Models.Utils.Contracts.Subject.pas',
  Views.Main in 'Views\Views.Main.pas' {MainView},
  Views.Login in 'Views\Views.Login.pas' {LoginView},
  Views.Tarefas in 'Views\Views.Tarefas.pas' {TarefasView},
  Models.Services.Contracts.Service in 'Models\Services\Contracts\Models.Services.Contracts.Service.pas',
  Controllers.Contracts.Controller in 'Controllers\Contracts\Controllers.Contracts.Controller.pas',
  Views.Generics.Base in 'Views\Generics\Views.Generics.Base.pas' {BaseView},
  Views.Generics.CadastroBase in 'Views\Generics\Views.Generics.CadastroBase.pas' {BaseCadastroView},
  Views.CadastroUsuario in 'Views\Views.CadastroUsuario.pas' {UsuarioCadastroView};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainView, MainView);
  Application.Run;
end.
