unit DatabaseOptions;

interface

uses
  DatabaseOptionsIntf;

type
  TDatabaseOptions = class(TInterfacedObject, IDatabaseOptions)
  private
    fConnectionDef: string;
  public
    constructor Create(const connectionDef: string);

    function GetConnectionDef(): string;
    property ConnectionDef: string read GetConnectionDef;
  end;

implementation

{ TDatabaseOptions }

constructor TDatabaseOptions.Create(const connectionDef: string);
begin
  fConnectionDef := connectionDef;
end;

function TDatabaseOptions.GetConnectionDef(): string;
begin
  Result := fConnectionDef;
end;

end.
