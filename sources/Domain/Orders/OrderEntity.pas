unit OrderEntity;

interface

uses
  Spring.Persistence.Mapping.Attributes;

type
  [Entity, Table('Orders')]
  TOrder = class
  private
    [AutoGenerated, Column('OrderID', [cpRequired, cpPrimaryKey, cpNotNull, cpDontInsert])]
    fId: Integer;
    FCustomerId: string;
    FEmployeeId: Integer;
    fOrderDate: TDateTime;
    fRequiredDate: TDateTime;
    fShippedDate: TDateTime;
    fShipVia: Integer;
    fFreight: Currency;
    fShipName: string;
    fShipAddress: string;
    fShipCity: string;
    fShipRegion: string;
    fShipPostalCode: string;
    fShipCountry: string;
  public
    property Id: Integer read fId write fId;

    [Column('CustomerID', [cpRequired, cpNotNull], 5)]
    property CustomerId: string read FCustomerId write FCustomerId;

    [Column('EmployeeID')]
    property EmployeeId: Integer read FEmployeeId write FEmployeeId;

    [Column('OrderDate')]
    property OrderDate: TDateTime read fOrderDate write fOrderDate;

    [Column('RequiredDate')]
    property RequiredDate: TDateTime read fRequiredDate write fRequiredDate;

    [Column('ShippedDate')]
    property ShippedDate: TDateTime read fShippedDate write fShippedDate;

    [Column('ShipVia', [cpRequired, cpNotNull])]
    property ShipVia: Integer read fShipVia write fShipVia;

    [Column('Freight')]
    property Freight: Currency read fFreight write fFreight;

    [Column('ShipName', [], 40)]
    property ShipName: string read fShipName write fShipName;

    [Column('ShipAddress', [], 60)]
    property ShipAddress: string read fShipAddress write fShipAddress;

    [Column('ShipCity', [], 15)]
    property ShipCity: string read fShipCity write fShipCity;

    [Column('ShipRegion', [], 15)]
    property ShipRegion: string read fShipRegion write fShipRegion;

    [Column('ShipPostalCode', [], 10)]
    property ShipPostalCode: string read fShipPostalCode write fShipPostalCode;

    [Column('ShipCountry', [], 15)]
    property ShipCountry: string read fShipCountry write fShipCountry;
  end;

implementation

end.