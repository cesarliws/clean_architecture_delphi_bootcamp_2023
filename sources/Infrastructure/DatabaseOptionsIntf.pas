unit DatabaseOptionsIntf;

interface

type
  IDatabaseOptions = interface
  ['{F6B8E8C9-9B0F-4F5A-8E1E-7A3D3C2F9A0B}']
    function GetConnectionDef(): string;
    property ConnectionDef: string read GetConnectionDef;
  end;

implementation

end.
