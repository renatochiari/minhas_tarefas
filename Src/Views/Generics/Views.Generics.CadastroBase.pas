unit Views.Generics.CadastroBase;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  Views.Generics.Base, FMX.Layouts, Controllers.Contracts.Controller,
  Models.Entities.Base, FMX.Controls.Presentation, FMX.Effects;

type
  TBaseCadastroView = class(TBaseView)
    lytBotoes: TLayout;
    btnSalvar: TButton;
    btnExcluir: TButton;
    btnCancelar: TButton;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FController: IController;
    FEntity: TBaseEntity;

  protected
    property Controller: iController read FController;
    property Entity: TBaseEntity read FEntity;

    procedure PreencheCampos; virtual; abstract;
    procedure RecuperaCampos; virtual; abstract;

  public
    constructor Create(controller: IController; entity: TBaseEntity);

  end;

var
  BaseCadastroView: TBaseCadastroView;

implementation

{$R *.fmx}

{ TBaseCadastroView }

procedure TBaseCadastroView.btnCancelarClick(Sender: TObject);
begin
    Self.Close;
end;

procedure TBaseCadastroView.btnExcluirClick(Sender: TObject);
begin
    if (not MessageDlg('Confirma a exclusão?', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes,TMsgDlgBtn.mbNo], 0) <> mrYes) then
        Exit;

    try
        FController.Excluir(FEntity);
    except on e: Exception do
        raise Exception.Create('Problemas ao excluir cadastro!'+sLineBreak+e.Message);
    end;
end;

procedure TBaseCadastroView.btnSalvarClick(Sender: TObject);
begin
    RecuperaCampos;

    try
        if (not FController.Salvar(FEntity)) then
            Exit;

        Self.Close;

    except on E: Exception do
        raise Exception.Create('Problemas ao salvar cadastro!'+sLineBreak+E.Message);
    end;
end;

constructor TBaseCadastroView.Create(controller: IController; entity: TBaseEntity);
begin
    inherited Create(nil);
    FController := controller;
    FEntity := entity;
end;

procedure TBaseCadastroView.FormShow(Sender: TObject);
begin
    inherited;
    btnExcluir.Enabled := not FEntity.Id.Trim.IsEmpty;
    PreencheCampos;
end;

end.
