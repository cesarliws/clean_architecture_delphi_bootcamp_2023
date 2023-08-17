unit RepositoryIntf;

interface

uses
  Spring,
  Spring.Collections,
  Spring.Persistence.Criteria.Interfaces;

type
  ISpecification = ICriterion;

  {$M+}
  IRepository<T: class, constructor> = interface
    ['{D90D8889-EBA3-493C-A786-E8081FFC67CC}']

    function GetAll: IList<T>;
    function GetById(id: TValue): T;
    function Where(const specification: ISpecification): IList<T>;

    procedure Add(entity: T);
    procedure Update(entity: T);
    procedure Delete(id: TValue);
  end;

implementation

end.
