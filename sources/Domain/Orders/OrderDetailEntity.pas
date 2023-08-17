unit OrderDetailEntity;

interface

uses
  Spring.Persistence.Mapping.Attributes;

type
  [Entity, Table('"Order Details"')]
  TOrderDetail = class
  private
    fOrderId: Integer;
    FProductId: Integer;
    fUnitPrice: Currency;
    fQuantity: SmallInt;
    fDiscount: Currency;
  public
    [Column('OrderID', [cpRequired, cpPrimaryKey, cpNotNull])]
    property OrderId: Integer read fOrderId write fOrderId;

    /// <summary>
    /// "Order Details" PK is a composed key by OrderID and ProductID, but Spring Persistence
    ///  do not supports composed Keys, that may lead to bugs in some database operations.
    /// </summary>
    [Column('ProductID', [cpRequired, cpNotNull])]
    property ProductId: Integer read FProductId write FProductId;

    [Column('UnitPrice', [cpRequired, cpNotNull])]
    property UnitPrice: Currency read fUnitPrice write fUnitPrice;

    [Column('Quantity', [cpRequired, cpNotNull])]
    property Quantity: SmallInt read fQuantity write fQuantity;

    [Column('Discount', [cpRequired, cpNotNull])]
    property Discount: Currency read fDiscount write fDiscount;
  end;

implementation

end.
