unit UnitTestsStartup;

interface

type
  TUnitTestsStartup = class
  public
    class procedure RegisterTests();
  end;

implementation

uses
  DUnitX.TestFramework,

  OrderAggregateUnitTests,
  ShipperServiceUnitTests;

class procedure TUnitTestsStartup.RegisterTests();
begin
  TDUnitX.RegisterTestFixture(TOrderAggregateTest);
  TDUnitX.RegisterTestFixture(TShipperServiceUnitTests);
end;

end.
