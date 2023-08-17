unit ShipperService;

interface

uses
  DateTimeServiceintf,
  NotificationServiceIntf,
  OrderEntity,
  RepositoryIntf,
  ShipperEntity,
  ShipperServiceIntf;

type
  TShipperService = class(TInterfacedObject, IShipperService)
  private
    fShipperRepository: IRepository<TShipper>;
    fDateTimeService: IDateTimeService;
    fNotificationService: INotificationService<TShipper, TOrder>;
    fOrderRepository: IRepository<TOrder>;
  public
    constructor Create(
      const shipperRepository: IRepository<TShipper>;
      const orderRepository: IRepository<TOrder>;
      const dataTimeService: IDateTimeService;
      const notificationService: INotificationService<TShipper, TOrder>);

    procedure ShipOrder(const order: TOrder);
  end;

implementation

uses
  EShipperException;

constructor TShipperService.Create(const shipperRepository: IRepository<TShipper>;
  const orderRepository: IRepository<TOrder>; const dataTimeService: IDateTimeService;
  const notificationService: INotificationService<TShipper, TOrder>);
begin
  inherited Create;

  fShipperRepository := shipperRepository;
  fOrderRepository := orderRepository;
  fDateTimeService := dataTimeService;
  fNotificationService := notificationService;
end;

procedure TShipperService.ShipOrder(const order: TOrder);
begin
  var shipper := fShipperRepository.GetById(order.ShipVia);

  if shipper = nil then
    raise EShipper.CreateFmt('Shipper "%d" not found for Order "%d"', [order.ShipVia, order.Id]);

  order.ShippedDate := fDateTimeService.Now;
  fOrderRepository.Update(order);

  var msg := TMessage<TShipper, TOrder>.Create(shipper, order);
  fNotificationService.Send(msg)
end;

end.
