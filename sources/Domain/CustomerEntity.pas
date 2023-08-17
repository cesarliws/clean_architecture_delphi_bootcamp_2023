unit CustomerEntity;

interface

uses
  Spring.Persistence.Mapping.Attributes;

type
  [Entity, Table('Customers')]
  TCustomer = class
  private
    [AutoGenerated, Column('CustomerID', [cpRequired, cpPrimaryKey, cpNotNull, cpDontInsert])]
    fId: string;
    fCompanyName: string;
    fContactName: string;
    fContactTitle: string;
    fAddress: string;
    fCity: string;
    fRegion: string;
    fPostalCode: string;
    fCountry: string;
    fPhone: string;
    fFax: string;
  public
    property Id: string read fId;

    [Column('CompanyName', [cpRequired, cpNotNull], 40)]
    property CompanyName: string read fCompanyName write fCompanyName;

    [Column('ContactName', [], 30)]
    property ContactName: string read fContactName write fContactName;

    [Column('ContactTitle', [], 30)]
    property ContactTitle: string read fContactTitle write fContactTitle;

    [Column('Address', [], 60)]
    property Address: string read fAddress write fAddress;

    [Column('City', [], 15)]
    property City: string read fCity write fCity;

    [Column('Region', [], 15)]
    property Region: string read fRegion write fRegion;

    [Column('PostalCode', [], 10)]
    property PostalCode: string read fPostalCode write fPostalCode;

    [Column('Country', [], 15)]
    property Country: string read fCountry write fCountry;

    [Column('Phone', [], 24)]
    property Phone: string read fPhone write fPhone;

    [Column('Fax', [], 24)]
    property Fax: string read fFax write fFax;
  end;

implementation

end.