unit uFTDI;

interface

uses ComCtrls, Forms, Messages, Controls, Classes, Menus, Windows, Dialogs, cTDI ;

type
   TFTDI = Class
     private
        FTDI: TTDI;
        property TDI : TTDI read FTDI write FTDI;
     public
       Constructor create(AOwner: TWinControl; aFormPadrao: TFormClass); overload;
       function GetTDI : TTDI;
       function GetHandleTDI : THandle;
   End;

implementation

{ TFTDI }
constructor TFTDI.create(AOwner: TWinControl; aFormPadrao: TFormClass);
begin
  FTDI := TTDI.Create(AOwner, aFormPadrao);
end;

function TFTDI.GetHandleTDI: THandle;
begin
  Result := FTDI.Handle;
end;

function TFTDI.GetTDI: TTDI;
begin
  Result := FTDI;
end;

end.
