unit Views.Generics.Base;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls, Views.Generics.Style;

type
  TBaseView = class(TForm)
    lytBase: TLayout;
  private
    viewAtiva: TForm;

  protected
    procedure ShowView(view: TComponentClass);

  public

  end;

var
  BaseView: TBaseView;

implementation

{$R *.fmx}

{ TBaseView }

procedure TBaseView.ShowView(view: TComponentClass);
begin
     if (Assigned(viewAtiva)) and (viewAtiva.ClassType = view)
     then exit;

     FreeAndNil(viewAtiva);

     Application.CreateForm(view, viewAtiva);
     var layoutTemp := TLayout(viewAtiva.findComponent('lytBase'));
     layoutTemp.Parent := lytBase;
end;

end.
