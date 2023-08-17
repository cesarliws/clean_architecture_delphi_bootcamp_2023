unit CustomerDatabaseRepository;

interface

uses
  Spring.Collections,
  Spring.Persistence.Core.Session,
  Infra.Customer.DatabaseContext,
  CCWD.Domain.Customer,
  CCWD.Domain.Customer.CustomerRepository.Intf,
  CCWD.Infra.Database.DatabaseConnection.Intf;

type
  TCustomerRepository = class(TCustomerDatabaseContext, ICustomerRepository)
  private
    FDatabaseConnection: IDatabaseConnection;
    FSession: TSession;
  public
    constructor Create(ADatabaseConnection: IDatabaseConnection);
    function GetAll: IList<TCustomer>;
    function GetById(AId: Integer): TCustomer;
    function GetByEmail(AEmail: string): TCustomer;
    procedure Add(ACustomer: TCustomer);
    procedure Update(ACustomer: TCustomer);
    procedure Delete(AId: Integer);
  end;

implementation

{ TCustomerRepository }

constructor TCustomerRepository.Create(ADatabaseConnection: IDatabaseConnection);
begin
  inherited Create;
  FDatabaseConnection := ADatabaseConnection;
  FSession := FDatabaseConnection.GetSession;
end;

function TCustomerRepository.GetAll: IList<TCustomer>;
begin
  Result := FSession.FindAll<TCustomer>;
end;

function TCustomerRepository.GetByEmail(AEmail: string): TCustomer;
begin
  Result := FSession
    .FindWhere<TCustomer>((Customer.Email = AEmail) and (Customer.Name <> ''))
    .FirstOrDefault;

//    var customers := FSession.FindWhere<TCustomer>(Customer.Email.IsNotNull);
end;

function TCustomerRepository.GetById(AId: Integer): TCustomer;
begin
  Result := FSession.FindOne<TCustomer>(AId);
end;

procedure TCustomerRepository.Add(ACustomer: TCustomer);
begin
  FSession.Save(ACustomer);
end;

procedure TCustomerRepository.Update(ACustomer: TCustomer);
begin
  FSession.Update(ACustomer);
end;

procedure TCustomerRepository.Delete(AId: Integer);
begin
  var customer := GetById(AId);
  if (customer <> nil) then
    FSession.Delete(customer);
end;

end.
