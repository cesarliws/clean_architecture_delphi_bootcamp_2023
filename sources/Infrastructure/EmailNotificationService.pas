unit EmailNotificationService;

interface

uses
  NotificationServiceIntf;

type
  TEmailService<TDestiny, TSubject> = class(TInterfacedObject, INotificationService<TDestiny, TSubject>)
  public
     procedure Send(const message: TMessage<TDestiny, TSubject>);
  end;

implementation


{ TEmailService<TDestiny, TSubject> }

procedure TEmailService<TDestiny, TSubject>.Send(const message: TMessage<TDestiny, TSubject>);
begin
  // TODO: implement real email sender service notification (must be async).
end;

end.
