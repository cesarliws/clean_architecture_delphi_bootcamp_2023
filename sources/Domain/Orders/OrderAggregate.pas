unit OrderAggregate;

interface

uses
  DateTimeServiceIntf,
  OrderAggregateIntf,
  RepositoryIntf,
  CustomerEntity,
  EmployeeEntity,
  OrderEntity,
  OrderDetailEntity,
  OrderDetailRepositoryIntf,
  ProductEntity,
  ShipperEntity;

type
  TOrderAggregate = class(TInterfacedObject, IOrderAggregate)
  private
    fDateTimeService: IDateTimeService;
    fOrderRepository: IRepository<TOrder>;
    fCustomerRepository: IRepository<TCustomer>;
    fEmployeeRepository: IRepository<TEmployee>;
    fOrderDetailRepository: IOrderDetailRepository;
    fProductRepository: IRepository<TProduct>;
    fShipperRepository: IRepository<TShipper>;
  public
    constructor Create(
      const dateTimeService: IDateTimeService;
      const orderRepository: IRepository<TOrder>;
      const customerRepository: IRepository<TCustomer>;
      const employeeRepository: IRepository<TEmployee>;
      const orderDetailRepository: IOrderDetailRepository;
      const productRepository: IRepository<TProduct>;
      const shipperRepository: IRepository<TShipper>);

    function CreateOrder(const customerId: string; employeeId: Integer; shipperId: Integer): TOrder;
    function AddItem(const order: TOrder; productId: Integer; unitPrice: Currency; quantity: Integer;
      discount: Currency = 0): TOrderDetail;
  end;

implementation

uses
  EOrderException;

{ TOrderAggregate }

constructor TOrderAggregate.Create(
  const dateTimeService: IDateTimeService;
  const orderRepository: IRepository<TOrder>;
  const customerRepository: IRepository<TCustomer>;
  const employeeRepository: IRepository<TEmployee>;
  const orderDetailRepository: IOrderDetailRepository;
  const productRepository: IRepository<TProduct>;
  const shipperRepository: IRepository<TShipper>);
begin
  inherited Create;

  fDateTimeService := dateTimeService;
  fOrderRepository := orderRepository;
  fCustomerRepository := customerRepository;
  fEmployeeRepository := employeeRepository;
  fOrderDetailRepository := orderDetailRepository;
  fProductRepository := productRepository;
  fShipperRepository := shipperRepository;
end;

function TOrderAggregate.CreateOrder(const customerId: string; employeeId: Integer;
  shipperId: Integer): TOrder;
begin
  var customer := fCustomerRepository.GetById(customerId);
  if (customer = nil) then
    raise EOrder.CreateFmt('Customer not found: %d ', [customerId]);

  var employee := fEmployeeRepository.GetById(employeeId);
  if (employee = nil) then
    raise EOrder.CreateFmt('Employee not found: %d ', [employeeId]);

  var shipper := fShipperRepository.GetById(shipperId);
  if (shipper = nil) then
    raise EOrder.CreateFmt('Shipper not found: %d ', [shipperId]);

  var order := TOrder.Create;
  order.CustomerID := customerId;
  order.EmployeeID := employeeId;
  order.ShipVia    := shipperId;

  order.OrderDate :=  fDateTimeService.Today();
  order.RequiredDate := fDateTimeService.Today();

  fOrderRepository.Add(order);

  Result := order;
end;

function TOrderAggregate.AddItem(const order: TOrder; productId: Integer; unitPrice: Currency;
  quantity: Integer; discount: Currency = 0): TOrderDetail;
begin
  var orderDetail := TOrderDetail.Create();
  orderDetail.OrderId := order.Id;

  var product := fProductRepository.GetById(productId);
  if (product = nil) then
    raise EOrder.CreateFmt('Product not found: %d ', [productId]);

  orderDetail.ProductId := productId;
  orderDetail.UnitPrice := unitPrice;
  orderDetail.Quantity := quantity;
  orderDetail.Discount := discount;

  fOrderDetailRepository.Add(orderDetail);

  Result := orderDetail;
end;

end.
