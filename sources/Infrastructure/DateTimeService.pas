unit DateTimeService;

interface

uses
  DateTimeServiceIntf;

type
  TDateTimeService = class(TInterfacedObject, IDateTimeService)
  public
    function Today: TDate;
    function Now: TDateTime;
  end;

implementation

uses
  System.SysUtils;

{ TDateTimeService }

function TDateTimeService.Now: TDateTime;
begin
  Result := System.SysUtils.Now();
end;

function TDateTimeService.Today: TDate;
begin
  Result := System.SysUtils.Date();
end;

end.
