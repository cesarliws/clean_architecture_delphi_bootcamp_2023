unit NotificationServiceIntf;

interface

type
  TMessage<TDestiny, TSubject> = record
  public
    Destiny: TDestiny;
    Subject: TSubject;

    constructor Create(destiny: TDestiny; subject: TSubject);
  end;
{$M+}
  INotificationService<TDestiny, TSubject> = interface
    ['{E2D0A30E-8EDA-4D89-8543-2D629C20B92D}']
    procedure Send(const message: TMessage<TDestiny, TSubject>);
  end;

implementation

{ TMessage<TDestiny, TSubject> }

constructor TMessage<TDestiny, TSubject>.Create(destiny: TDestiny; subject: TSubject);
begin
  Self.Destiny := destiny;
  Self.Subject := subject;
end;

end.
