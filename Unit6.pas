unit Unit6;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Imaging.pngimage;

type
  TAuto_1Form = class(TForm)
    Auto_Time: TTimer;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Auto_TimeTimer(Sender: TObject);
    procedure Construct;
    procedure Destroy;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
       count_pers = 12;
       count_pole = 4;
       n = 6;
       h = 65;
       x0 = 0;
       y0 = 0;
                                                                        //0 - пустой участок
var Location: array [1..n,1..n] of Integer =                           //1 - стена
                                               ((5,1,1,1,5,5),        //2 - место для ящика
                                                (5,1,2,1,1,5),       //3 - ящик
                                                (1,1,3,4,1,1),      //4 - персонаж
                                                (1,2,3,0,0,1),     //5 - невидимый участок массива
                                                (1,1,1,1,1,1),
                                                (5,5,5,5,5,5));

const Player_Images: array [1..count_pers] of String = ('staydown.png','down1.png','down2.png',
'stayleft.png','left1.png','left2.png','stayright.png','right1.png','right2.png',
'stayup.png','up1.png','up2.png');

const Pole_Images: array [1..count_pole] of String = ('red_wall.png','ground_grey.png',
'crate_blue.png','tochka_blue.png');

var
  Auto_1Form: TAuto_1Form;
  Pole: array [1..n,1..n] of TImage;
  Bt: array [1..n,1..n] of TBitBtn;
  Map: TBitMap;
  i_pers, j_pers, dy, dx, buf, a, Animation,  steps: Integer;
  Box: Boolean;

implementation

{$R *.dfm}

uses Unit4;

procedure TAuto_1Form.Auto_TimeTimer(Sender: TObject);
begin
  case steps of
    0:
       Begin
         if Location[j_pers+1,i_pers] = 0 then
           Begin
             case Animation of
               6: Pole[j_pers,i_pers].Picture.LoadFromFile(Player_Images[2]);
              12: Pole[j_pers,i_pers].Picture.LoadFromFile(Player_Images[3]);
             end;
             Inc(Animation);
             if Animation > 12 then
               Animation := 0;
             Pole[j_pers,i_pers].Top := Pole[j_pers,i_pers].Top + 1;
             dy := dy + 1;
             if dy = h then
               Begin
                 buf := Location[j_pers,i_pers];
                 Location[j_pers,i_pers] := 0;
                 Location[j_pers+1,i_pers] := buf;
                 Pole[j_pers+1,i_pers] := Pole[j_pers,i_pers];
                 j_pers := j_pers + 1;
                 dy := 0;
                 Pole[j_pers,i_pers].Picture.LoadFromFile(Player_Images[1]);
                 Inc(steps);
               End;
           End;
       End;
    1:
       Begin
         if (Location[j_pers,i_pers-1] = 0) or ((Location[j_pers,i_pers-1] = 3) and not(Location[j_pers,i_pers-2] = 1)) then
           Begin
             case Animation of
                0: Pole[j_pers,i_pers].Picture.LoadFromFile(Player_Images[4]);
                6: Pole[j_pers,i_pers].Picture.LoadFromFile(Player_Images[5]);
               12: Pole[j_pers,i_pers].Picture.LoadFromFile(Player_Images[6]);
             end;
             Inc(Animation);
             if Animation > 12 then
               Animation := 0;
             if a = 0 then
               Begin
                 if (Location[j_pers,i_pers-1] = 3) and (not(Location[j_pers,i_pers-2] = 1)) then
                   Begin
                     Box := True;
                     buf := Location[j_pers,i_pers-1];
                     Location[j_pers,i_pers-1] := 0;
                     Location[j_pers,i_pers-2] := buf;
                     Pole[j_pers,i_pers-2] := Pole[j_pers,i_pers-1];
                     Inc(a);
                   End;
               End;
             if Box = True then
               Begin
                 Pole[j_pers,i_pers-1].Left := Pole[j_pers,i_pers-1].Left - 1;
               End;
             Pole[i_pers,j_pers].Left := Pole[i_pers,j_pers].Left - 1;
             dx := dx - 1;
             if dx = -h then
               Begin;
                 buf := Location[j_pers,i_pers];
                 Location[j_pers,i_pers] := 0;
                 Location[j_pers,i_pers-1] := buf;
                 Pole[j_pers,i_pers-1] := Pole[j_pers,i_pers];
                 i_pers := i_pers - 1;
                 dx := 0;
                 Pole[j_pers,i_pers].Picture.LoadFromFile(Player_Images[1]);
                 Box := False;
                 Inc(steps);
                 a := 0;
               End;
           End;
       End;
    2:
       Begin
         if (Location[j_pers-1,i_pers] = 0) or (Location[j_pers-1,i_pers] = 6) or ((Location[j_pers-1,i_pers] = 3) and not(Location[j_pers-2,i_pers] = 1)) then
           Begin
             case Animation of
               6: Pole[j_pers,i_pers].Picture.LoadFromFile(Player_Images[11]);
              12: Pole[j_pers,i_pers].Picture.LoadFromFile(Player_Images[12]);
             end;
             Inc(Animation);
             if Animation > 12 then
               Animation := 0;
             if a = 0 then
               Begin
                 if (Location[j_pers-1,i_pers] = 0) or (Location[j_pers-1,i_pers] = 3) and (not(Location[j_pers-2,i_pers] = 1)) then
                   Begin
                     Box := True;
                     buf := Location[j_pers-1,i_pers];
                     Location[j_pers-1,i_pers] := 0;
                     Location[j_pers-2,i_pers] := buf;
                     Pole[j_pers-2,i_pers] := Pole[j_pers-1,i_pers];
                     Inc(a);
                   End;
               End;
             if Box = True then
               Begin
                 Pole[j_pers-1,i_pers].Top := Pole[j_pers-1,i_pers].Top - 1;
               End;
             Pole[j_pers,i_pers].Top := Pole[j_pers,i_pers].Top - 1;
             dy := dy - 1;
             if dy = -h then
               Begin
                 buf := Location[j_pers,i_pers];
                 Location[j_pers,i_pers] := 0;
                 Location[j_pers-1,i_pers] := buf;
                 Pole[j_pers-1,i_pers] := Pole[j_pers,i_pers];
                 j_pers := j_pers - 1;
                 dy := 0;
                 Pole[j_pers,i_pers].Picture.LoadFromFile(Player_Images[1]);
                 Box := False;
                 a := 0;
                 Auto_Time.Interval := 100;
                 Inc(steps);
               End;
           End;
       End;
    3:
       Begin
         Destroy;
       End;
  end;
end;

procedure TAuto_1Form.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure TAuto_1Form.Construct;
var i, j: Integer;
begin
  Map := TBitMap.Create;
  for i := 1 to n do
    for j := 1 to n do
      Begin
        Pole[j,i] := TImage.Create(Auto_1Form);
        Pole[j,i].Parent := Auto_1Form;
        Pole[j,i].Width := h;
        Pole[j,i].Height := h;
        Pole[j,i].Left := x0 + (i - 1) * h;
        Pole[j,i].Top := y0 + (j - 1) * h;
        Pole[j,i].Visible := False;
      End;

  for i := 1 to n do
    for j := 1 to n do
      Begin
        Bt[j,i] := TBitBtn.Create(Auto_1Form);
        Bt[j,i].Parent := Auto_1Form;
        Bt[j,i].Width := h;
        Bt[j,i].Height := h;
        Bt[j,i].Left := x0 + (j - 1) * h;
        Bt[j,i].Top := y0 + (i - 1) * h;
        Bt[j,i].Caption := '';
        Bt[j,i].Visible :=  False;
      End;

  Auto_1Form.Repaint;
  for i := 1 to n do
    for j := 1 to n do
      Begin
        Bt[j,i].Hide;
      End;

  for i := 1 to n do
    for j := 1 to n do
      Begin
        case Location[j,i] of
          1:
             Begin
               Pole[j,i].Picture.LoadFromFile(Pole_Images[1]);
               Pole[j,i].Transparent := True;
               Pole[j,i].Visible := True;
             End;
          2:
             Begin
               Pole[j,i].Picture.LoadFromFile(Pole_Images[4]);
               Pole[j,i].Transparent := True;
               Pole[j,i].Visible := True;
             End;
          3:
             Begin
               Pole[j,i].Picture.LoadFromFile(Pole_Images[3]);
               Pole[j,i].Transparent := True;
               Pole[j,i].Visible := True;
             End;
          4:
             Begin
               i_pers := i;
               j_pers := j;
               dy := 0;
               dx := 0;
               Pole[j,i].Picture.LoadFromFile(Player_Images[1]);
               Pole[j,i].Transparent := True;
               Pole[j,i].Visible := True;
             End;
        end;
      End;
  steps := 0;
end;

procedure TAuto_1Form.Destroy;
var i, j: Integer;
begin
  Location[1,1] := 5;
  Location[1,2] := 1;
  Location[1,3] := 1;
  Location[1,4] := 1;
  Location[1,5] := 5;
  Location[2,1] := 5;
  Location[2,2] := 1;
  Location[2,3] := 2;
  Location[2,4] := 1;
  Location[2,5] := 1;
  Location[3,1] := 1;
  Location[3,2] := 1;
  Location[3,3] := 3;
  Location[3,4] := 4;
  Location[3,5] := 1;
  Location[4,1] := 1;
  Location[4,2] := 2;
  Location[4,3] := 3;
  Location[4,4] := 0;
  Location[4,5] := 0;
  Location[5,1] := 1;
  Location[5,2] := 1;
  Location[5,3] := 1;
  Location[5,4] := 1;
  Location[5,5] := 1;

  FreeAndNil(Pole[3,3]);
  FreeAndNil(Pole[2,3]);
  FreeAndNil(Pole[4,2]);

  dx := 0;
  dy := 0;

  Auto_Time.Enabled := False;
  Auto_Time.Interval := 10;
  Level1Form.Game_Time.Enabled := True;
  Auto_1Form.Hide;
  steps := 0;
end;

end.
