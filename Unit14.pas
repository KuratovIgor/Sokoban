unit Unit14;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage;

type
  TAuto_5Form = class(TForm)
    Pole1: TImage;
    Pole2: TImage;
    Pole3: TImage;
    Pole4: TImage;
    Pole7: TImage;
    Pole8: TImage;
    Pole6: TImage;
    Pole9: TImage;
    Pole5: TImage;
    Pole10: TImage;
    Pole14: TImage;
    Pole20: TImage;
    Pole11: TImage;
    Pole19: TImage;
    Pole18: TImage;
    Pole12: TImage;
    Pole17: TImage;
    Pole23: TImage;
    Pole16: TImage;
    Pole15: TImage;
    Pole22: TImage;
    Pole21: TImage;
    Pole13: TImage;
    Pole25: TImage;
    Pole26: TImage;
    Auto_Time_5: TTimer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Auto_Time_5Timer(Sender: TObject);
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
       n = 9;
       h = 65;
       x0 = 0;
       y0 = 0;

var Location_5: array [1..n,1..n] of Integer =
                                               ((5,1,1,1,1,1,1,5,5),
                                                (5,1,0,0,0,0,1,5,5),
                                                (5,1,0,3,0,1,1,1,1),       //0 - пустой участок
                                                (5,1,1,4,3,0,0,0,1),      //1 - стена
                                                (1,1,1,3,0,1,0,1,1),     //2 - место для ящика
                                                (1,0,0,0,0,0,0,1,5),    //3 - ящик
                                                (1,0,0,0,1,1,1,1,5),   //4 - персонаж
                                                (1,1,1,1,1,5,5,5,5),  //5 - невидимый участок массива
                                                (5,5,5,5,5,5,5,5,5));


const Player_Images_5: array [1..count_pers] of String = ('staydown.png','down1.png','down2.png',
'stayleft.png','left1.png','left2.png','stayright.png','right1.png','right2.png',
'stayup.png','up1.png','up2.png');

const Pole_Images_5: array [1..count_pole] of String = ('red_wall.png','ground_green.png',
'crate_brown.png','tochka_brown_green.png');

var
  Auto_5Form: TAuto_5Form;
  Pole_5: array [1..n,1..n] of TImage;
  Bt_5: array [1..n,1..n] of TBitBtn;
  Map_5: TBitMap;
  i_pers, j_pers, dy, dx, buf, a, Animation, steps: Integer;
  Box: Boolean;

implementation

{$R *.dfm}

uses Unit13;

procedure TAuto_5Form.Auto_Time_5Timer(Sender: TObject);
begin
  case steps of
    3,9,10,17,21,22,37,38,41,42:    //left
       Begin
         if (Location_5[j_pers,i_pers-1] = 0) or ((Location_5[j_pers,i_pers-1] = 3) and (not(Location_5[j_pers,i_pers-2] = 1) and not(Location_5[j_pers,i_pers-2] = 3))) then
           Begin
             case Animation of
               0: Pole_5[j_pers,i_pers].Picture.LoadFromFile(Player_Images_5[4]);
               6: Pole_5[j_pers,i_pers].Picture.LoadFromFile(Player_Images_5[5]);
              12: Pole_5[j_pers,i_pers].Picture.LoadFromFile(Player_Images_5[6]);
             end;
             Inc(Animation);
             if Animation > 12 then
               Animation := 0;
             if a = 0 then
               Begin
                 if (Location_5[j_pers,i_pers-1] = 3) and (not(Location_5[j_pers,i_pers-2] = 1)) then
                   Begin
                     Box := True;
                     buf := Location_5[j_pers,i_pers-1];
                     Location_5[j_pers,i_pers-1] := 0;
                     Location_5[j_pers,i_pers-2] := buf;
                     Pole_5[j_pers,i_pers-2] := Pole_5[j_pers,i_pers-1];
                     Inc(a);
                   End;
               End;
             if Box = True then
               Begin
                 Pole_5[j_pers,i_pers-1].Left := Pole_5[j_pers,i_pers-1].Left - 1;
               End;

             Pole_5[j_pers,i_pers].Left := Pole_5[j_pers,i_pers].Left - 1;
             dx := dx - 1;
             if dx = -h then
               Begin;
                 buf := Location_5[j_pers,i_pers];
                 Location_5[j_pers,i_pers] := 0;
                 Location_5[j_pers,i_pers-1] := buf;
                 Pole_5[j_pers,i_pers-1] := Pole_5[j_pers,i_pers];
                 i_pers := i_pers - 1;
                 dx := 0;
                 Pole_5[j_pers,i_pers].Picture.LoadFromFile(Player_Images_5[1]);
                 Box := False;
                 a := 0;
                 if steps = 44 then
                   Auto_Time_5.Interval := 100;
                 Inc(steps);
               End;
           End;
       End;
    4,5,7,8,13,23,27,28,29,35,36,39,40:   //up
       Begin
         if (Location_5[j_pers-1,i_pers] = 0) or ((Location_5[j_pers-1,i_pers] = 3) and not(Location_5[j_pers-2,i_pers] = 1) and not(Location_5[j_pers-2,i_pers] = 3)) then
           Begin
             case Animation of
               6: Pole_5[j_pers,i_pers].Picture.LoadFromFile(Player_Images_5[11]);
              12: Pole_5[j_pers,i_pers].Picture.LoadFromFile(Player_Images_5[12]);
             end;
             Inc(Animation);
             if Animation > 12 then
               Animation := 0;
             if a = 0 then
               Begin
                 if (Location_5[j_pers-1,i_pers] = 3) and (not(Location_5[j_pers-2,i_pers] = 1)) then
                   Begin
                     Box := True;
                     buf := Location_5[j_pers-1,i_pers];
                     Location_5[j_pers-1,i_pers] := 0;
                     Location_5[j_pers-2,i_pers] := buf;
                     Pole_5[j_pers-2,i_pers] := Pole_5[j_pers-1,i_pers];
                     Inc(a);
                   End;
               End;
             if Box = True then
               Begin
                 Pole_5[j_pers-1,i_pers].Top := Pole_5[j_pers-1,i_pers].Top - 1;
               End;
             Pole_5[j_pers,i_pers].Top := Pole_5[j_pers,i_pers].Top - 1;
             dy := dy - 1;
             if dy = -h then
               Begin
                 buf := Location_5[j_pers,i_pers];
                 Location_5[j_pers,i_pers] := 0;
                 Location_5[j_pers-1,i_pers] := buf;
                 Pole_5[j_pers-1,i_pers] := Pole_5[j_pers,i_pers];
                 j_pers := j_pers - 1;
                 dy := 0;
                 Pole_5[j_pers,i_pers].Picture.LoadFromFile(Player_Images_5[1]);
                 Box := False;
                 a := 0;
                 if steps = 44 then
                   Auto_Time_5.Interval := 100;
                 Inc(steps);
               End;
           End;
       End;
    1,6,12,14,24,26,32,33,34,44:    //right
       Begin
         if (Location_5[j_pers,i_pers+1] = 0) or ((Location_5[j_pers,i_pers+1] = 3) and not(Location_5[j_pers,i_pers+2] = 1) and not(Location_5[j_pers,i_pers+2] = 3)) then
           Begin
             case Animation of
               0: Pole_5[j_pers,i_pers].Picture.LoadFromFile(Player_Images_5[7]);
               6: Pole_5[j_pers,i_pers].Picture.LoadFromFile(Player_Images_5[8]);
              12: Pole_5[j_pers,i_pers].Picture.LoadFromFile(Player_Images_5[9]);
             end;
             Inc(Animation);
             if Animation > 12 then
               Animation := 0;
             if a = 0 then
               Begin
                 if (Location_5[j_pers,i_pers+1] = 3) and (not(Location_5[j_pers,i_pers+2] = 1)) then
                   Begin
                    Box := True;
                    buf := Location_5[j_pers,i_pers+1];
                    Location_5[j_pers,i_pers+1] := 0;
                    Location_5[j_pers,i_pers+2] := buf;
                    Pole_5[j_pers,i_pers+2] := Pole_5[j_pers,i_pers+1];
                    Inc(a);
                   End;
               End;
             if Box = True then
               Begin
                 Pole_5[j_pers,i_pers+1].Left := Pole_5[j_pers,i_pers+1].Left + 1;
               End;
             Pole_5[j_pers,i_pers].Left := Pole_5[j_pers,i_pers].Left + 1;
             dx := dx + 1;
             if dx = h then
               Begin
                 buf := Location_5[j_pers,i_pers];
                 Location_5[j_pers,i_pers] := 0;
                 Location_5[j_pers,i_pers+1] := buf;
                 Pole_5[j_pers,i_pers+1] := Pole_5[j_pers,i_pers];
                 i_pers := i_pers + 1;
                 dx := 0;
                 Pole_5[j_pers,i_pers].Picture.LoadFromFile(Player_Images_5[1]);
                 Box := False;
                 a := 0;
                 if steps = 44 then
                   Auto_Time_5.Interval := 100;
                 Inc(steps);
               End;
           End;
       End;
    0,2,11,15,16,18,19,20,25,30,31,43:    //down
       Begin
         if (Location_5[j_pers+1,i_pers] = 0) or ((Location_5[j_pers+1,i_pers] = 3) and not(Location_5[j_pers+2,i_pers] = 1) and not(Location_5[j_pers+2,i_pers] = 3)) then
           Begin
             case Animation of
               6: Pole_5[j_pers,i_pers].Picture.LoadFromFile(Player_Images_5[2]);
              12: Pole_5[j_pers,i_pers].Picture.LoadFromFile(Player_Images_5[3]);
             end;
             Inc(Animation);
             if Animation > 12 then
               Animation := 0;
             if a = 0 then
               Begin
                 if (Location_5[j_pers+1,i_pers] = 3) and (not(Location_5[j_pers+2,i_pers] = 1)) then
                   Begin
                     Box := True;
                     buf := Location_5[j_pers+1,i_pers];
                     Location_5[j_pers+1,i_pers] := 0;
                     Location_5[j_pers+2,i_pers] := buf;
                     Pole_5[j_pers+2,i_pers] := Pole_5[j_pers+ 1,i_pers];
                     Inc(a);
                   End;
               End;
             if Box = True then
               Begin
                 Pole_5[j_pers+1,i_pers].Top := Pole_5[j_pers+1,i_pers].Top + 1;
               End;
             Pole_5[j_pers,i_pers].Top := Pole_5[j_pers,i_pers].Top + 1;
             dy := dy + 1;
             if dy = h then
               Begin
                 buf := Location_5[j_pers,i_pers];
                 Location_5[j_pers,i_pers] := 0;
                 Location_5[j_pers+1,i_pers] := buf;
                 Pole_5[j_pers+1,i_pers] := Pole_5[j_pers,i_pers];
                 j_pers := j_pers + 1;
                 dy := 0;
                 Pole_5[j_pers,i_pers].Picture.LoadFromFile(Player_Images_5[1]);
                 Box := False;
                 a := 0;
                 if steps = 44 then
                   Auto_Time_5.Interval := 100;
                 Inc(steps);
               End;
           End;
       End;
    45:
      Begin
        Destroy;
      End;
  end;
end;

procedure TAuto_5Form.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure TAuto_5Form.Construct;
var i, j: Integer;
begin
  Map_5 := TBitMap.Create;
  for i := 1 to n do
    for j := 1 to n do
      Begin
        Pole_5[j,i] := TImage.Create(Auto_5Form);
        Pole_5[j,i].Parent := Auto_5Form;
        Pole_5[j,i].Width := h;
        Pole_5[j,i].Height := h;
        Pole_5[j,i].Left := x0 + (i - 1) * h;
        Pole_5[j,i].Top := y0 + (j - 1) * h;
        Pole_5[j,i].Visible := False;
      End;

  for i := 1 to n do
    for j := 1 to n do
      Begin
        Bt_5[j,i] := TBitBtn.Create(Auto_5Form);
        Bt_5[j,i].Parent := Auto_5Form;
        Bt_5[j,i].Width := h;
        Bt_5[j,i].Height := h;
        Bt_5[j,i].Left := x0 + (j - 1) * h;
        Bt_5[j,i].Top := y0 + (i - 1) * h;
        Bt_5[j,i].Caption := '';
        Bt_5[j,i].Visible :=  False;
      End;

  Auto_5Form.Repaint;
  for i := 1 to n do
    for j := 1 to n do
      Begin
        Bt_5[j,i].Hide;
      End;

  for i := 1 to n do
    for j := 1 to n do
      Begin
        case Location_5[j,i] of
          1:
             Begin
               Pole_5[j,i].Picture.LoadFromFile(Pole_Images_5[1]);
               Pole_5[j,i].Transparent := True;
               Pole_5[j,i].Visible := True;
             End;
          2:
             Begin
               Pole_5[j,i].Picture.LoadFromFile(Pole_Images_5[4]);
               Pole_5[j,i].Transparent := True;
               Pole_5[j,i].Visible := True;
             End;
          3:
             Begin
               Pole_5[j,i].Picture.LoadFromFile(Pole_Images_5[3]);
               Pole_5[j,i].Transparent := True;
               Pole_5[j,i].Visible := True;
             End;
          4:
             Begin
               i_pers := i;
               j_pers := j;
               dy := 0;
               dx := 0;
               Pole_5[j,i].Picture.LoadFromFile(Player_Images_5[1]);
               Pole_5[j,i].Transparent := True;
               Pole_5[j,i].Visible := True;
             End;
        end;
      End;

  Pole1.SendToBack;
  Pole2.SendToBack;
  Pole3.SendToBack;
  Pole4.SendToBack;
  Pole5.SendToBack;
  Pole6.SendToBack;
  Pole7.SendToBack;
  Pole8.SendToBack;
  Pole9.SendToBack;
  Pole10.SendToBack;
  Pole11.SendToBack;
  Pole12.SendToBack;
  Pole13.SendToBack;
  Pole14.SendToBack;
  Pole15.SendToBack;
  Pole16.SendToBack;
  Pole17.SendToBack;
  Pole18.SendToBack;
  Pole19.SendToBack;
  Pole20.SendToBack;
  Pole21.SendToBack;
  Pole22.SendToBack;
  Pole23.SendToBack;
  Pole25.SendToBack;
  Pole26.SendToBack;
    Pole_5[4,5].Picture.LoadFromFile('crate_red.png');
  Pole_5[5,4].Picture.LoadFromFile('crate_blue.png');
  steps := 0;
end;

procedure TAuto_5Form.Destroy;
begin
  Location_5[1,1] := 5;
  Location_5[1,2] := 1;
  Location_5[1,3] := 1;
  Location_5[1,4] := 1;
  Location_5[1,5] := 1;
  Location_5[1,6] := 1;
  Location_5[1,7] := 1;
  Location_5[1,8] := 5;
  Location_5[1,9] := 5;
  Location_5[2,1] := 5;
  Location_5[2,2] := 1;
  Location_5[2,3] := 0;
  Location_5[2,4] := 0;
  Location_5[2,5] := 0;
  Location_5[2,6] := 0;
  Location_5[2,7] := 1;
  Location_5[2,8] := 5;
  Location_5[2,9] := 5;
  Location_5[3,1] := 5;
  Location_5[3,2] := 1;
  Location_5[3,3] := 0;
  Location_5[3,4] := 3;
  Location_5[3,5] := 0;
  Location_5[3,6] := 1;
  Location_5[3,7] := 1;
  Location_5[3,8] := 1;
  Location_5[3,9] := 1;
  Location_5[4,1] := 5;
  Location_5[4,2] := 1;
  Location_5[4,3] := 1;
  Location_5[4,4] := 4;
  Location_5[4,5] := 3;
  Location_5[4,6] := 0;
  Location_5[4,7] := 0;
  Location_5[4,8] := 0;
  Location_5[4,9] := 1;
  Location_5[5,1] := 1;
  Location_5[5,2] := 1;
  Location_5[5,3] := 1;
  Location_5[5,4] := 3;
  Location_5[5,5] := 0;
  Location_5[5,6] := 1;
  Location_5[5,7] := 0;
  Location_5[5,8] := 1;
  Location_5[5,9] := 1;
  Location_5[6,1] := 1;
  Location_5[6,2] := 0;
  Location_5[6,3] := 0;
  Location_5[6,4] := 0;
  Location_5[6,5] := 0;
  Location_5[6,6] := 0;
  Location_5[6,7] := 0;
  Location_5[6,8] := 1;
  Location_5[6,9] := 5;
  Location_5[7,1] := 1;
  Location_5[7,2] := 0;
  Location_5[7,3] := 0;
  Location_5[7,4] := 0;
  Location_5[7,5] := 1;
  Location_5[7,6] := 1;
  Location_5[7,7] := 1;
  Location_5[7,8] := 1;
  Location_5[7,9] := 5;
  Location_5[8,1] := 1;
  Location_5[8,2] := 1;
  Location_5[8,3] := 1;
  Location_5[8,4] := 1;
  Location_5[8,5] := 1;
  Location_5[8,6] := 5;
  Location_5[8,7] := 5;
  Location_5[8,8] := 5;
  Location_5[8,9] := 5;
  Location_5[9,1] := 5;
  Location_5[9,2] := 5;
  Location_5[9,3] := 5;
  Location_5[9,4] := 5;
  Location_5[9,5] := 5;
  Location_5[9,6] := 5;
  Location_5[9,7] := 5;
  Location_5[9,8] := 5;
  Location_5[9,9] := 5;

  FreeAndNil(Pole_5[3,5]);
  FreeAndNil(Pole_5[4,4]);
  FreeAndNil(Pole_5[5,5]);
  FreeAndNil(Pole_5[3,4]);

  dx := 0;
  dy := 0;

  Auto_Time_5.Enabled := False;
  Auto_Time_5.Interval := 10;
  Level5Form.Game_Time_5.Enabled := True;
  Auto_5Form.Hide;
  steps := 0;
end;

end.
