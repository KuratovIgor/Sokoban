unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls;

type
  TLoadForm = class(TForm)
    LOAD: TImage;
    Arrow: TImage;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LoadForm: TLoadForm;
  n_kurs: Integer;

implementation

{$R *.dfm}

uses Unit2, Unit4, Unit7, Unit9, Unit11, Unit13;

procedure TLoadForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure TLoadForm.FormCreate(Sender: TObject);
begin
  n_kurs := 0;
end;

procedure TLoadForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 38 then
    Begin
      if n_kurs = 0 then
        Begin
          Arrow.Top := Arrow.Top - 63;
          Arrow.Top := Arrow.Top + 63;
        End
      else
        Begin
          Arrow.Top := Arrow.Top - 63;
          Dec(n_kurs);
        End;
    End;
  if Key = 40 then
    Begin
      if n_kurs = 4 then
        Begin
          Arrow.Top := Arrow.Top + 63;
          Arrow.Top := Arrow.Top - 63;
        End
      else
        Begin
          Arrow.Top := Arrow.Top + 63;
          Inc(n_kurs);
        End;
    End;
  if Key = 27 then
    Begin
      LoadForm.Hide;
      MenuForm.Show;
    End;
  if Key = 13 then
    Begin
      case n_kurs of
        0:
            Begin
              LoadForm.Hide;
              Level1Form.Construct;
              Level1Form.Game_Time.Enabled := True;
              Level1Form.Show;
            End;
        1:
            Begin
              LoadForm.Hide;
              Level2Form.Construct;
              Level2Form.Game_Time_2.Enabled := True;
              Level2Form.Show;
            End;
        2:
            Begin
              LoadForm.Hide;
              Level3Form.Construct;
              Level3Form.Game_Time_3.Enabled := True;
              Level3Form.Show;
            End;
        3:
           Begin
              LoadForm.Hide;
              Level4Form.Construct;
              Level4Form.Game_Time_4.Enabled := True;
              Level4Form.Show;
           End;
        4:
           Begin
              LoadForm.Hide;
              Level5Form.Construct;
              Level5Form.Game_Time_5.Enabled := True;
              Level5Form.Show;
           End;
      end;
    End;
end;

end.
