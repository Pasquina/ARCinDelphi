unit ARCObject;

interface

uses System.Generics.Collections;

type
  IBaseObject = interface
    ['{823BE1C2-9627-411B-8109-C640D66F56A7}']
  end;

  IChildObject = interface
    ['{722C6198-56F1-4D63-A31F-D191BB8A57FA}']
  end;

  TBaseObject = class(TInterfacedObject, IBaseObject)
  private
  protected
  public
    constructor Create; virtual;
    destructor Destroy; override;
  end;

  TChildObject = class(TBaseObject, IChildObject)
  private
    FMyList: TList<Integer>;
    procedure SetMyList(const Value: TList<Integer>);
  protected
    property MyList: TList<Integer> read FMyList write SetMyList;
  public
    constructor Create; override;
    destructor Destroy;
  end;

  TBaseClassClass = class of TBaseObject;
  TChildClassClass = class of TChildObject;

implementation

uses
  Vcl.Dialogs;

{ TBaseObject }

constructor TBaseObject.Create;
begin
  ShowMessage('Base Object Create');
end;

destructor TBaseObject.Destroy;
begin
  ShowMessage('Base Object Destroy');
  inherited;
end;

{ TChildObject }

constructor TChildObject.Create;
begin
  inherited;
  ShowMessage('Child Object Create');
  MyList := TList<Integer>.Create;
end;

destructor TChildObject.Destroy;
begin
  ShowMessage('Child Object Destroy');
  MyList.Free;
  inherited;
end;

procedure TChildObject.SetMyList(const Value: TList<Integer>);
begin
  FMyList := Value;
end;

end.
