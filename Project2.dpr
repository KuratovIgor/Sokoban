program Project2;

uses
  Vcl.Forms,
  Unit2 in 'Unit2.pas' {MenuForm},
  Unit1 in 'Unit1.pas' {LoadForm},
  Unit3 in 'Unit3.pas' {HelpForm},
  Unit4 in 'Unit4.pas' {Level1Form},
  Unit5 in 'Unit5.pas' {AboutForm},
  Unit6 in 'Unit6.pas' {Auto_1Form},
  Unit7 in 'Unit7.pas' {Level2Form},
  Unit8 in 'Unit8.pas' {Auto_2Form},
  Unit9 in 'Unit9.pas' {Level3Form},
  Unit10 in 'Unit10.pas' {Auto_3Form},
  Unit11 in 'Unit11.pas' {Level4Form},
  Unit12 in 'Unit12.pas' {Auto_4Form},
  Unit13 in 'Unit13.pas' {Level5Form},
  Unit14 in 'Unit14.pas' {Auto_5Form},
  Unit15 in 'Unit15.pas' {WinForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMenuForm, MenuForm);
  Application.CreateForm(TLoadForm, LoadForm);
  Application.CreateForm(THelpForm, HelpForm);
  Application.CreateForm(TLevel1Form, Level1Form);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.CreateForm(TAuto_1Form, Auto_1Form);
  Application.CreateForm(TLevel2Form, Level2Form);
  Application.CreateForm(TAuto_2Form, Auto_2Form);
  Application.CreateForm(TLevel3Form, Level3Form);
  Application.CreateForm(TAuto_3Form, Auto_3Form);
  Application.CreateForm(TLevel4Form, Level4Form);
  Application.CreateForm(TAuto_4Form, Auto_4Form);
  Application.CreateForm(TLevel5Form, Level5Form);
  Application.CreateForm(TAuto_5Form, Auto_5Form);
  Application.CreateForm(TWinForm, WinForm);
  Application.Run;
end.
