unit ARCForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ARCObject;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  LBaseClass: TBaseClassClass;
  LChildClass: TChildClassClass;
  LBaseObject: IBaseObject;
  LChildObject: IChildObject;
begin
  ShowMessage('Creating Base Class Instance');
  LBaseClass := TBaseObject;
  LBaseObject := LBaseClass.Create;

  ShowMessage('Creating Child Class Instance');
  LChildClass := TChildObject;
  LChildObject := LChildClass.Create;

  ShowMessage('Exiting Scope');
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  LChildObject: TChildObject;
begin
  ShowMessage('Create Child Object');
  LChildObject := TChildObject.Create;
  ShowMessage('Free Child Object');
  LChildObject.Free;
  ShowMessage('Exiting Scope');
end;

end.
