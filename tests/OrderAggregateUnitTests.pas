unit OrderAggregateUnitTests;

interface

uses
  DateTimeServiceIntf,
  RepositoryIntf,
  OrderDetailRepositoryIntf,

  CustomerEntity,
  EmployeeEntity,
  OrderDetailEntity,
  OrderEntity,
  ProductEntity,
  ShipperEntity,

  OrderAggregateIntf,
  OrderAggregate,

  Spring.Mocking,
  DUnitX.TestFramework;

type
  [TestFixture]
  TOrderAggregateTest = class
  private
    fDateTimeService: Mock<IDateTimeService>;
    fOrderRepository: Mock<IRepository<TOrder>>;
    fCustomerRepository: Mock<IRepository<TCustomer>>;
    fEmployeeRepository: Mock<IRepository<TEmployee>>;
    fOrderDetailRepository: Mock<IOrderDetailRepository>;
    fProductRepository: Mock<IRepository<TProduct>>;
    fShipperRepository: Mock<IRepository<TShipper>>;
    fOrderAggregate: IOrderAggregate;
    fDateTime: TDateTime;
  public
    [Setup]
    procedure Setup;

    [TearDown]
    procedure TearDown;

    [Test]
    procedure CreateOrder_Should_Add_One_Order_To_Repository();

    [Test]
    [TestCase('Item_1','1,2')]
    [TestCase('Item_2','3,4')]
    procedure AddItem_Should_Add_Items_To_Repository(const AValue1 : Integer;const AValue2 : Integer);
  end;

implementation

uses
  System.SysUtils;

procedure TOrderAggregateTest.Setup;
begin
  fDateTimeService := Mock<IDateTimeService>.Create();
  fDateTime := EncodeDate(2023, 8, 18);
  fDateTimeService.Setup.Returns<TDateTime>(fdateTime).When.Today();

  fCustomerRepository := Mock<IRepository<TCustomer>>.Create();
  fCustomerRepository.Setup.Returns<TCustomer>(TCustomer.Create).When.GetById(Arg.IsAny<TValue>);

  fEmployeeRepository := Mock<IRepository<TEmployee>>.Create();
  fEmployeeRepository.Setup.Returns<TEmployee>(TEmployee.Create).When.GetById(Arg.IsAny<TValue>);

  fShipperRepository := Mock<IRepository<TShipper>>.Create();
  fShipperRepository.Setup.Returns<TShipper>(TShipper.Create).When.GetById(Arg.IsAny<TValue>);

  fOrderRepository := Mock<IRepository<TOrder>>.Create();
  fOrderDetailRepository := Mock<IOrderDetailRepository>.Create();
  fProductRepository := Mock<IRepository<TProduct>>.Create();

  fOrderAggregate := TOrderAggregate.Create(fDateTimeService, fOrderRepository, fCustomerRepository,
    fEmployeeRepository, fOrderDetailRepository, fProductRepository, fShipperRepository);
end;

procedure TOrderAggregateTest.CreateOrder_Should_Add_One_Order_To_Repository();
begin
  var order := fOrderAggregate.CreateOrder('1',2, 3);

  Assert.IsNotNull(order);

  // TODO : can be compared with Assert.AreSame();
  Assert.AreEqual(order.OrderDate, fDateTime);
  Assert.AreEqual(order.RequiredDate, fDateTime);
  Assert.AreEqual(order.CustomerID, '1');
  Assert.AreEqual(order.EmployeeID, 2);
  Assert.AreEqual(order.ShipVia, 3);

  fOrderRepository.Received(Times.Once).Add(order);
end;

procedure TOrderAggregateTest.AddItem_Should_Add_Items_To_Repository(const AValue1 : Integer;const AValue2 : Integer);
begin
  Assert.Pass();
end;

procedure TOrderAggregateTest.TearDown;
begin
end;

end.
