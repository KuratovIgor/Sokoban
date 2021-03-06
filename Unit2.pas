unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Menus;

type
  TMenuForm = class(TForm)
    Menu: TImage;
    Arrow: TImage;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MenuForm: TMenuForm;
  n_kurs: Integer;
  On_About: Boolean; //????????? ??????? ???????????? ??????? About

implementation

{$R *.dfm}

uses Unit1, Unit3, Unit4, Unit5;

procedure TMenuForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure TMenuForm.FormCreate(Sender: TObject);
begin
  n_kurs := 0;
  On_About := False;
end;

procedure TMenuForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 38 then                           //up
    Begin
      if On_About = False then
      //???? ?????? ????????? ?? ?? ??????? About
        Begin
          if n_kurs = 0 then
            Begin
              Arrow.Top := Arrow.Top - 80;
              Arrow.Left := Arrow.Left + 25;
              Arrow.Top := Arrow.Top + 80;
              Arrow.Left := Arrow.Left - 25;
            End
          else
            Begin
              Arrow.Top := Arrow.Top - 80;
              Arrow.Left := Arrow.Left + 25;
              Dec(n_kurs);
            End;
        End;
    End;
  if Key = 40 then                            //down
    Begin
      if On_About = False then
        Begin
          if n_kurs = 3 then
            Begin
              Arrow.Top := Arrow.Top + 80;
              Arrow.Left := Arrow.Left - 25;
              Arrow.Top := Arrow.Top - 80;
              Arrow.Left := Arrow.Left + 25;
            End
          else
            Begin
              Arrow.Top := Arrow.Top + 80;
              Arrow.Left := Arrow.Left - 25;
              Inc(n_kurs);
            End;
        End;
    End;
  if Key = 37 then         //left
    Begin
      On_About := True;
      Arrow.Top := 190;
      Arrow.Left := 320;
    End;
  if Key = 39 then           //right
  {??? ???????? ??????? ??????? ?? ?????? PLAY ????? ????????
   ??????? n_kurs, ????? ?????? ?? ??????.}
    Begin
      if On_About = True then
        Begin
          Arrow.Top := 200;
          Arrow.Left := 616;
          n_kurs := 0;
          On_About := False;
        End;
    End;
  if Key = 13 then       //enter
    Begin
      if On_About = True then   // ???? ?????? ?????????? ?? ??????? About
        Begin
          MenuForm.Hide;
          AboutForm.Show;
        End
      else
        Begin
          case n_kurs of
            0:
               Begin
                 MenuForm.Hide;
                 Level1Form.Construct;
                 Level1Form.Game_Time.Enabled := True;
                 Level1Form.Show;
               End;
            1:
               Begin
                 MenuForm.Hide;
                 LoadForm.Show;
               End;
            2:
               Begin
                 MenuForm.Hide;
                 HelpForm.Show;
               End;
            3:
               Begin
                 MenuForm.Hide;
                 Application.Terminate
               End;
          end;
        End;
    End;
end;

end.
