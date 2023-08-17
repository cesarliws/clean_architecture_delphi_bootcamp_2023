unit Startup;

interface

uses
  Spring.Container;

type
  TStartup = class
  public
    class procedure ConfigureServices(const services: TContainer);
  end;

implementation

uses
  DatabaseOptionsIntf,
  DatabaseOptions,
  DatabaseConnectionIntf,
  DatabaseConnectionSqlite,
  DateTimeServiceIntf,
  DateTimeService,
  NotificationServiceIntf,
  EmailNotificationService,

  RepositoryIntf,
  DatabaseRepository,
  OrderDetailRepositoryIntf,
  OrderDetailRepository,

  CategoryEntity,
  CustomerEntity,
  EmployeeEntity,
  OrderEntity,
  ProductEntity,
  ShipperEntity,
  SupplierEntity,

  OrderAggregateIntf,
  OrderAggregate;

class procedure TStartup.ConfigureServices(const services: TContainer);
const
  FIREDAC_CONNECTION_DEFINITION = 'SQLite_Demo';
begin
  services.RegisterType<IDatabaseOptions>(
    function: IDatabaseOptions
    begin
      Result := TDatabaseOptions.Create(FIREDAC_CONNECTION_DEFINITION);
    end).AsSingleton();
  services.RegisterType<IDatabaseConnection, TSqliteDatabaseConnection>().AsSingleton();

  services.RegisterType<IRepository<TCategory>, TRepository<TCategory>>();
  services.RegisterType<IRepository<TCustomer>, TRepository<TCustomer>>();
  services.RegisterType<IRepository<TEmployee>, TRepository<TEmployee>>();

  services.RegisterType<IOrderDetailRepository, TOrderDetailRepository>();

  services.RegisterType<IRepository<TOrder>, TRepository<TOrder>>();
  services.RegisterType<IRepository<TProduct>, TRepository<TProduct>>();
  services.RegisterType<IRepository<TShipper>, TRepository<TShipper>>();
  services.RegisterType<IRepository<TSupplier>, TRepository<TSupplier>>();

  services.RegisterType<IOrderAggregate, TOrderAggregate>();

  services.RegisterType<IDateTimeService, TDateTimeService>();
  services.RegisterType<INotificationService<TShipper, TOrder>, TEmailService<TShipper, TOrder>>();
end;

end.
