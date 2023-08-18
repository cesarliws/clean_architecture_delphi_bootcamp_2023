unit OrderView;

interface

uses
  RepositoryIntf,
  OrderDetailRepositoryIntf,
  OrderEntity,
  OrderDetailEntity,
  OrderAggregateIntf;

type
  TOrderView = class
  private
    fOrderRepository: IRepository<TOrder>;
    fOrderDetailRepository: IOrderDetaiLRepository;
    fOrderAggregate: IOrderAggregate;
  public
    constructor Create(
      const orderRepository: IRepository<TOrder>;
      const orderDetailRepository: IOrderDetaiLRepository;
      const orderAggregate: IOrderAggregate);

    procedure CreateOneOrder();
    procedure ShowAllOrders();
  end;

implementation

uses
  JsonUtils;

{ TOrderView }

constructor TOrderView.Create(
  const orderRepository: IRepository<TOrder>;
  const orderDetailRepository: IOrderDetaiLRepository;
  const orderAggregate: IOrderAggregate);
begin
  inherited Create;
  fOrderRepository := orderRepository;
  fOrderDetailRepository := orderDetailRepository;
  fOrderAggregate := orderAggregate;
end;

procedure TOrderView.CreateOneOrder;
begin
  Writeln('- Creating a new Order:');

  var order := fOrderAggregate.CreateOrder('VINET', 5, 1);
  fOrderAggregate.AddItem(order, 3, 25, 8);

  var aggregateOrder := fOrderRepository.GetById(order.Id);
  Writeln('- Order: ', TJsonSerializer.SerializeIndented<TOrder>(aggregateOrder));

  var aggregateItems := fOrderDetailRepository.GetDetail(order.Id);
  for var item in aggregateItems do
  begin
    Writeln('  - Order Detail: ', TJsonSerializer.SerializeIndented<TOrderDetail>(item));
  end;
end;

procedure TOrderView.ShowAllOrders;
begin
  var
  orders := fOrderRepository.GetAll();
  var
  orderDetails := fOrderDetailRepository.GetAll();

  for var order in orders do
  begin
    Writeln('- Order: ', order.Id, ', Customer: ', order.CustomerID, ', Employee: ', order.EmployeeID, ', Shipper: ',
      order.ShipVia);

    // filter order detail
    var
    items := orderDetails.Where(
      function(const value: TOrderDetail): Boolean
      begin
        Result := value.OrderId = order.Id;
      end);

    for var item in items do
    begin
      Writeln('  - Product: ', item.ProductID);
    end;
  end;

  Writeln('---');
  Writeln(orders.Count, ' Orders Found.');
  Writeln('---');
end;

end.
