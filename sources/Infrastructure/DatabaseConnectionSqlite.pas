unit DatabaseConnectionSqlite;

interface

uses
  FireDAC.Comp.Client,
  FireDAC.ConsoleUI.Wait,
  FireDAC.DApt,
  FireDAC.DApt.Intf,
  FireDAC.DatS,
  FireDAC.Phys,
  FireDAC.Phys.Intf,
  FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Phys.SQLiteWrapper.Stat,
  FireDAC.Stan.Async,
  FireDAC.Stan.Def,
  FireDAC.Stan.Error,
  FireDAC.Stan.ExprFuncs,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Pool,
  FireDAC.UI.Intf,

  Spring.Persistence.Core.Interfaces,
  Spring.Persistence.Core.Session,

  DatabaseConnectionIntf,
  DatabaseOptionsIntf;

type
  TSqliteDatabaseConnection = class(TInterfacedObject, IDatabaseConnection)
  private
    fConnection: IDBConnection;
    fFDConnection: TFDConnection;
    fSession: TSession;
  public
    constructor Create(const options: IDatabaseOptions);

    function GetConnection: IDBConnection;
    function GetSession: TSession;
    procedure ReleaseConnection;
  end;

implementation

uses
  Spring.Persistence.Adapters.FireDAC,
  Spring.Persistence.Core.ConnectionFactory,
  Spring.Persistence.SQL.Generators.SQLite3,
  Spring.Persistence.SQL.Interfaces,

  System.SysUtils;

constructor TSqliteDatabaseConnection.Create(const options: IDatabaseOptions);
begin
  fFDConnection := TFDConnection.Create(nil);
  fFDConnection.Params.Clear;
  fFDConnection.Params.ConnectionDef := options.ConnectionDef;
  fFDConnection.LoginPrompt := False;

  fConnection := TConnectionFactory.GetInstance(dtFireDAC, fFDConnection);
  fConnection.AutoFreeConnection := true;
  fConnection.QueryLanguage := qlSqlite;

  fSession := TSession.Create(fConnection);
end;

function TSqliteDatabaseConnection.GetConnection: IDBConnection;
begin
  if not fFDConnection.Connected then
    fFDConnection.Open;
  Result := fConnection;
end;

function TSqliteDatabaseConnection.GetSession: TSession;
begin
  Result := fSession;
end;

procedure TSqliteDatabaseConnection.ReleaseConnection;
begin
  if fFDConnection.Connected then
    fFDConnection.Close;
end;

end.
