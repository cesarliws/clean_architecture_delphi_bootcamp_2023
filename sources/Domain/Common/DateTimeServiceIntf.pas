unit DateTimeServiceIntf;

interface

type
  {$M+}
  IDateTimeService = interface
    ['{CD2FCEA8-1794-41EF-8E67-53CBCF3F2B27}']
    function Today: TDate;
    function Now: TDateTime;
  end;

implementation

end.
