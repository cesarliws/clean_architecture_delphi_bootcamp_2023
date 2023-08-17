unit DatabaseRepository;

interface

uses
  Spring,
  Spring.Collections,
  Spring.Persistence.Core.Session,
  Spring.Persistence.Criteria.Interfaces,

  DatabaseConnectionIntf,
  RepositoryIntf;

type
  ISpecification = ICriterion;
  TRepository<T: class, constructor> = class(TInterfacedObject, IRepository<T>)
  protected
    fDatabaseConnection: IDatabaseConnection;
    fSession: TSession;
  public
    constructor Create(const databaseConnection: IDatabaseConnection);

    function GetAll: IList<T>;
    function GetById(id: TValue): T;
    function Where(const specification: ISpecification): IList<T>;

    procedure Add(entity: T);
    procedure Update(entity: T);
    procedure Delete(id: TValue);
  end;

implementation

{ TRepository }

constructor TRepository<T>.Create(const databaseConnection: IDatabaseConnection);
begin
  fDatabaseConnection := databaseConnection;
  fSession := fDatabaseConnection.GetSession;
end;

function TRepository<T>.GetAll: IList<T>;
begin
  Result := fSession.FindAll<T>;
end;

function TRepository<T>.GetById(id: TValue): T;
begin
  Result := fSession.FindOne<T>(id);
end;

procedure TRepository<T>.Add(entity: T);
begin
  fSession.Save(entity);
end;

procedure TRepository<T>.Update(entity: T);
begin
  fSession.Update(entity);
end;

procedure TRepository<T>.Delete(id: TValue);
begin
  var model := GetById(id);

  if model <> nil then
    fSession.Delete(model);
end;

function TRepository<T>.Where(const specification: ISpecification): IList<T>;
begin
  Result := fSession.FindWhere<T>(specification);
end;

end.
