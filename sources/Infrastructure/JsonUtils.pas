unit JsonUtils;

interface

uses
  System.JSON.Serializers,
  System.JSON.Types;

type
  TJsonSerializer = class(System.JSON.Serializers.TJsonSerializer)
  public
    class function Serialize<T>(const value: T; indented: Boolean = false): string;
    class function SerializeIndented<T>(const value: T): string;
  end;

implementation

{ TJsonSerializer }

class function TJsonSerializer.Serialize<T>(const value: T; indented: Boolean = false): string;
begin
  var serializer := System.JSON.Serializers.TJsonSerializer.Create;
  try
    if indented then
      serializer.Formatting := TJsonFormatting.Indented;

    Result := serializer.Serialize<T>(value);
  finally
    serializer.Free;
  end;
end;

class function TJsonSerializer.SerializeIndented<T>(const value: T): string;
begin
  Result := TJsonSerializer.Serialize<T>(value, true);
end;

end.
