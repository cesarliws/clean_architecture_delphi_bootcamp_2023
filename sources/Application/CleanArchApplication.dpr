program CleanArchApplication;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  Spring.Container,
  Spring.Persistence.Criteria.Properties,
  OrderEntity,
  OrderDetailEntity,
  RepositoryIntf,
  OrderDetailRepositoryIntf,
  OrderAggregateIntf,
  ConsoleUtils,
  Startup in 'Startup.pas',
  OrderView in 'OrderView.pas';

// TODO: write readme file

begin
  try
    ReportMemoryLeaksOnShutdown := True;

    var services := Spring.Container.GlobalContainer;
    TStartup.ConfigureServices(services);
    services.Build();

    var orderRepository := services.Resolve<IRepository<TOrder>>();
    var orderDetailRepository := services.Resolve<IOrderDetailRepository>();
    var aggregate := services.Resolve<IOrderAggregate>();

    var view := TOrderView.Create(orderRepository, orderDetailRepository, aggregate);
    view.ShowAllOrders;
    //  view.CreateOneOrder;

    Console.WaitUserInput();
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

end.
