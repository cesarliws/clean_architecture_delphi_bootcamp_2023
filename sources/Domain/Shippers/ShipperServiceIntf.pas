unit ShipperServiceIntf;

interface

uses
  OrderEntity;

type
  IShipperService = interface
    ['{1ED517D8-C254-4AC7-ABB9-7701FD44B966}']
    procedure ShipOrder(const order: TOrder);
  end;

implementation

end.
