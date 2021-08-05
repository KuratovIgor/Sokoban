unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.StdCtrls;

type
  THelpForm = class(TForm)
    Help: TImage;
    Help_2: TImage;
    Help_3: TImage;
    Button1: TButton;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  HelpForm: THelpForm;
  count_click: Integer;

implementation

{$R *.dfm}

uses Unit2;

procedure THelpForm.Button1Click(Sender: TObject);
begin
  Inc(count_click);
  case count_click of
    1:
       Begin
         Help.Visible := False;
         Help_2.Visible := True;
         Help_3.Visible := False;
       End;
    2:
       Begin
         Help.Visible := False;
         Help_2.Visible := False;
         Help_3.Visible := True;
       End;
    3:
       Begin
         Help.Visible := True;
         Help_2.Visible := False;
         Help_3.Visible := False;
         count_click := 0;
         HelpForm.Hide;
         MenuForm.Show;
       End;
  end;
end;

procedure THelpForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure THelpForm.FormCreate(Sender: TObject);
begin
  Help.SendToBack;
  Help_2.SendToBack;
  Help_3.SendToBack;
end;

procedure THelpForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 27 then
    Begin
      HelpForm.Hide;
      MenuForm.Show;
    End;
end;

end.
