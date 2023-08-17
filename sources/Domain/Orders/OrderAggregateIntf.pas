unit OrderAggregateIntf;

interface

uses
  OrderEntity,
  OrderDetailEntity;

type
  IOrderAggregate = interface
    function CreateOrder(const customerId: string; employeeId: Integer; shipperId: Integer): TOrder;
    function AddItem(const order: TOrder; productId: Integer; unitPrice: Currency; quantity: Integer;
      discount: Currency = 0): TOrderDetail;
  end;

implementation

end.
