unit OrderDetailRepository;

interface

uses
  Spring.Collections,

  DatabaseRepository,
  OrderDetailRepositoryIntf,
  OrderEntity,
  OrderDetailEntity;

type
  TOrderDetailRepository = class(TRepository<TOrderDetail>, IOrderDetailRepository)
  public
    function GetDetail(const orderId: Integer): IList<TOrderDetail>;
  end;

implementation

uses
  DatabaseDictionary;

{ TOrderDetailRepository }

function TOrderDetailRepository.GetDetail(const orderId: Integer): IList<TOrderDetail>;
begin
  Result := Where(OrderDetail.OrderId = orderId);
end;

end.
