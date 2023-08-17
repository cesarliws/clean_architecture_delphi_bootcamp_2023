unit DatabaseDictionary;

interface

uses
  Spring.Persistence.Criteria.Properties;

type
  OrderDetail = class
  public
    class var OrderId: Prop;
    class var ProductId: Prop;
    class var UnitPrice: Prop;
    class var Quantity: Prop;
    class var Discount: Prop;

    class constructor Create;
  end;

implementation

{ OrderDetail }

class constructor OrderDetail.Create;
begin
  OrderId   := Prop.Create('OrderID');
  ProductId := Prop.Create('ProductID');
  UnitPrice := Prop.Create('UnitPrice');
  Quantity  := Prop.Create('Quantity');
  Discount  := Prop.Create('Discount');
end;

end.
