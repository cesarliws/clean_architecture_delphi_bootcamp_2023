unit ShipperServiceUnitTests;

interface

uses
  DateTimeServiceintf,
  NotificationServiceIntf,
  OrderEntity,
  RepositoryIntf,
  ShipperEntity,
  ShipperServiceIntf,
  ShipperService,
  EShipperException,

  Spring.Mocking,
  DUnitX.TestFramework;

type
  [TestFixture]
  TShipperServiceUnitTests = class
  private
    fShipper: TShipper;
    fShipperRepository: Mock<IRepository<TShipper>>;
    fDateTime: TDateTime;
    fDateTimeService: Mock<IDateTimeService>;
    fNotificationService: Mock<INotificationService<TShipper, TOrder>>;
    fOrderRepository: Mock<IRepository<TOrder>>;
    fShipperService: IShipperService;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure ShipOrder_Should_Update_Order_ShippedDate_And_Trigger_Notification();

    [Test]
    procedure ShipOrder_Should_Throw_EShipper_Exception_When_Shipper_NotFound();
  end;

implementation

uses
  System.DateUtils;

procedure TShipperServiceUnitTests.Setup;
begin
  fShipper := TShipper.Create;
  fShipperRepository := Mock<IRepository<TShipper>>.Create();

  fOrderRepository := Mock<IRepository<TOrder>>.Create();

  fDateTimeService := Mock<IDateTimeService>.Create();
  fDateTime := EncodeDateTime(2023, 8, 18, 12, 0, 0, 0);
  fDateTimeService.Setup.Returns<TDateTime>(fdateTime).When.Now();

  fNotificationService := Mock<INotificationService<TShipper, TOrder>>.Create();

  fShipperService := TShipperService.Create(fShipperRepository, fOrderRepository,
    fDateTimeService, fNotificationService);
end;

procedure TShipperServiceUnitTests.TearDown;
begin
  fShipper.Free;
  fDateTime := 0;
end;

procedure TShipperServiceUnitTests.ShipOrder_Should_Update_Order_ShippedDate_And_Trigger_Notification();
begin
  fShipperRepository.Setup.Returns<TShipper>(fShipper).When.GetById(Arg.IsAny<TValue>);
  var order := TOrder.Create;
  order.Id := 1000;
  order.ShipVia := 200;

  fShipperService.ShipOrder(order);

  // test if repository.Update was called
  fOrderRepository.Received(Times.Once).Update(order);

  // test if order.ShippedDate is the value configured in Set of  Mock<IDateTimeService>
  Assert.AreEqual(order.ShippedDate, fDateTime);

  // test if fNotificationService.Send was called with the correct message
  var expectedMessage := TMessage<TShipper, TOrder>.Create(fShipper, order);
  fNotificationService.Received(Times.Once).Send(expectedMessage);
end;

procedure TShipperServiceUnitTests.ShipOrder_Should_Throw_EShipper_Exception_When_Shipper_NotFound;
begin
  fShipperRepository.Setup.Returns<TShipper>(nil).When.GetById(Arg.IsAny<TValue>);
  var order := TOrder.Create;
  order.Id := 1000;
  order.ShipVia := 5000;

  // assert if the expected Exception is raised
  Assert.WillRaise(
    procedure
    begin
      fShipperService.ShipOrder(order);
    end,
    EShipper,
    // message is not asserted, it is only used if the test fails
    'Shipper "5000" not found for Order "1000"'
  );

  // test if repository.Update was NOT called
  fOrderRepository.Received(Times.Never).Update(order);

  // test if order.ShippedDate is zero
  Assert.AreEqual(order.ShippedDate, TDateTime(0.0));

  // test if fNotificationService.Send was NOT called
  fNotificationService.Received(Times.Never).Send(Arg.IsAny<TMessage<TShipper, TOrder>>);
end;


end.
