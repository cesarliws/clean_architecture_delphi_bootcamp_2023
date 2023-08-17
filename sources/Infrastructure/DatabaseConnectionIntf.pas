unit DatabaseConnectionIntf;

interface

uses
  Spring.Persistence.Core.Session,
  Spring.Persistence.Core.Interfaces;

type
  IDatabaseConnection = interface
  ['{B1DC4D10-2B07-4755-B259-9E660815F89C}']
    function GetConnection: IDBConnection;
    function GetSession: TSession;
    procedure ReleaseConnection;
  end;

implementation

end.
