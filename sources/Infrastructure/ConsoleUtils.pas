unit ConsoleUtils;

interface

type
  Console = class
  public
    class procedure WaitUserInput(const message: string = 'Type <ENTER> to continue...');
  end;


implementation

{ Console }

class procedure Console.WaitUserInput(const message: string);
begin
  Writeln(message);
  ReadLn;
end;

end.
