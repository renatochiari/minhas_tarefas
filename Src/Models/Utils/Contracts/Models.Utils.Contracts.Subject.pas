unit Models.Utils.Contracts.Subject;

interface

uses
    Models.Utils.Contracts.Observer;

type
    ISubject = interface
        procedure AddObserver(observer: IObserver);
        procedure RemObserver(observer: IObserver);
        procedure NotificarObservers;
    end;

implementation

end.
