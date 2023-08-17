unit OrderDetailRepositoryIntf;

interface

uses
  Spring.Collections,
  RepositoryIntf,
  OrderDetailEntity;

type
  IOrderDetailRepository = interface(IRepository<TOrderDetail>)
    ['{64BC6AB6-0151-47DF-A6F1-68FE917AB1ED}']
    function GetDetail(const orderId: Integer): IList<TOrderDetail>;
  end;

implementation

end.
