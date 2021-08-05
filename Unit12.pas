unit Unit12;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.StdCtrls, Vcl.Buttons;

type
  TAuto_4Form = class(TForm)
    Pole1: TImage;
    Pole2: TImage;
    Pole3: TImage;
    Pole10: TImage;
    Pole5: TImage;
    Pole11: TImage;
    Pole4: TImage;
    Pole9: TImage;
    Pole8: TImage;
    Pole12: TImage;
    Pole15: TImage;
    Pole20: TImage;
    Pole14: TImage;
    Pole13: TImage;
    Pole6: TImage;
    Pole7: TImage;
    Pole26: TImage;
    Pole21: TImage;
    Pole16: TImage;
    Pole27: TImage;
    Pole22: TImage;
    Pole17: TImage;
    Pole28: TImage;
    Pole18: TImage;
    Pole23: TImage;
    Pole19: TImage;
    Pole25: TImage;
    Pole29: TImage;
    Pole24: TImage;
    Auto_Time_4: TTimer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Auto_Time_4Timer(Sender: TObject);
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

var Location_4: array [1..n,1..n] of Integer =
                                               ((1,1,1,1,1,1,1,1,5),
                                                (1,4,0,1,0,0,0,1,5),        //0 - пустой участок
                                                (1,0,0,3,0,0,1,1,5),       //1 - стена
                                                (1,1,0,1,1,0,1,1,5),      //2 - место для ящика
                                                (5,1,0,1,1,0,0,1,1),     //3 - ящик
                                                (5,1,0,0,3,0,0,0,1),    //4 - персонаж
                                                (5,1,0,0,1,0,0,1,1),   //5 - невидимый участок массива
                                                (5,1,1,1,1,1,1,1,5),
                                                (5,5,5,5,5,5,5,5,5));


const Player_Images_4: array [1..count_pers] of String = ('staydown.png','down1.png','down2.png',
'stayleft.png','left1.png','left2.png','stayright.png','right1.png','right2.png',
'stayup.png','up1.png','up2.png');

const Pole_Images_4: array [1..count_pole] of String = ('brown_wall.png','ground_grey.png',
'crate_green.png','tochka_green_grey.png');

var
  Auto_4Form: TAuto_4Form;
  Pole_4: array [1..n,1..n] of TImage;
  Bt_4: array [1..n,1..n] of TBitBtn;
  Map_4: TBitMap;
  i_pers, j_pers, dy, dx, buf, a, Animation, steps: Integer;
  Box: Boolean;

implementation

{$R *.dfm}

uses Unit11;

procedure TAuto_4Form.Auto_Time_4Timer(Sender: TObject);
begin
  case steps of
    12,14,15,17,29,30,31:  //left
       Begin
         if (Location_4[j_pers,i_pers-1] = 0) or ((Location_4[j_pers,i_pers-1] = 3) and (not(Location_4[j_pers,i_pers-2] = 1) and not(Location_4[j_pers,i_pers-2] = 3))) then
           Begin
             case Animation of
               0: Pole_4[j_pers,i_pers].Picture.LoadFromFile(Player_Images_4[4]);
               6: Pole_4[j_pers,i_pers].Picture.LoadFromFile(Player_Images_4[5]);
               12: Pole_4[j_pers,i_pers].Picture.LoadFromFile(Player_Images_4[6]);
             end;
             Inc(Animation);
             if Animation > 12 then
               Animation := 0;
             if a = 0 then
               Begin
                 if (Location_4[j_pers,i_pers-1] = 3) and (not(Location_4[j_pers,i_pers-2] = 1)) then
                   Begin
                     Box := True;
                     buf := Location_4[j_pers,i_pers-1];
                     Location_4[j_pers,i_pers-1] := 0;
                     Location_4[j_pers,i_pers-2] := buf;
                     Pole_4[j_pers,i_pers-2] := Pole_4[j_pers,i_pers-1];
                     Inc(a);
                   End;
               End;
             if Box = True then
               Begin
                 Pole_4[j_pers,i_pers-1].Left := Pole_4[j_pers,i_pers-1].Left - 1;
               End;

             Pole_4[j_pers,i_pers].Left := Pole_4[j_pers,i_pers].Left - 1;
             dx := dx - 1;
             if dx = -h then
               Begin;
                 buf := Location_4[j_pers,i_pers];
                 Location_4[j_pers,i_pers] := 0;
                 Location_4[j_pers,i_pers-1] := buf;
                 Pole_4[j_pers,i_pers-1] := Pole_4[j_pers,i_pers];
                 i_pers := i_pers - 1;
                 dx := 0;
                 Pole_4[j_pers,i_pers].Picture.LoadFromFile(Player_Images_4[1]);
                 Box := False;
                 a := 0;
                 if steps = 31 then
                   Auto_Time_4.Interval := 100;
                 Inc(steps);
               End;
           End;
       End;
    4,13,18,19,20,21:         //up
       Begin
         if (Location_4[j_pers-1,i_pers] = 0) or ((Location_4[j_pers-1,i_pers] = 3) and not(Location_4[j_pers-2,i_pers] = 1) and not(Location_4[j_pers-2,i_pers] = 3)) then
           Begin
             case Animation of
               6: Pole_4[j_pers,i_pers].Picture.LoadFromFile(Player_Images_4[11]);
               12: Pole_4[j_pers,i_pers].Picture.LoadFromFile(Player_Images_4[12]);
             end;
             Inc(Animation);
             if Animation > 12 then
               Animation := 0;
             if a = 0 then
               Begin
                 if (Location_4[j_pers-1,i_pers] = 3) and (not(Location_4[j_pers-2,i_pers] = 1)) then
                   Begin
                     Box := True;
                     buf := Location_4[j_pers-1,i_pers];
                     Location_4[j_pers-1,i_pers] := 0;
                     Location_4[j_pers-2,i_pers] := buf;
                     Pole_4[j_pers-2,i_pers] := Pole_4[j_pers-1,i_pers];
                     Inc(a);
                   End;
               End;
             if Box = True then
               Begin
                 Pole_4[j_pers-1,i_pers].Top := Pole_4[j_pers-1,i_pers].Top - 1;
               End;
             Pole_4[j_pers,i_pers].Top := Pole_4[j_pers,i_pers].Top - 1;
             dy := dy - 1;
             if dy = -h then
               Begin
                 buf := Location_4[j_pers,i_pers];
                 Location_4[j_pers,i_pers] := 0;
                 Location_4[j_pers-1,i_pers] := buf;
                 Pole_4[j_pers-1,i_pers] := Pole_4[j_pers,i_pers];
                 j_pers := j_pers - 1;
                 dy := 0;
                 Pole_4[j_pers,i_pers].Picture.LoadFromFile(Player_Images_4[1]);
                 Box := False;
                 a := 0;
                 if steps = 31 then
                   Auto_Time_4.Interval := 100;
                 Inc(steps);
               End;
           End;
       End;
    1,2,3,5,9,22,23,24,27:    //right
       Begin
         if (Location_4[j_pers,i_pers+1] = 0) or ((Location_4[j_pers,i_pers+1] = 3) and not(Location_4[j_pers,i_pers+2] = 1) and not(Location_4[j_pers,i_pers+2] = 3)) then
           Begin
             case Animation of
               0: Pole_4[j_pers,i_pers].Picture.LoadFromFile(Player_Images_4[7]);
               6: Pole_4[j_pers,i_pers].Picture.LoadFromFile(Player_Images_4[8]);
               12: Pole_4[j_pers,i_pers].Picture.LoadFromFile(Player_Images_4[9]);
             end;
             Inc(Animation);
             if Animation > 12 then
               Animation := 0;
             if a = 0 then
               Begin
                 if (Location_4[j_pers,i_pers+1] = 3) and (not(Location_4[j_pers,i_pers+2] = 1)) then
                   Begin
                     Box := True;
                     buf := Location_4[j_pers,i_pers+1];
                     Location_4[j_pers,i_pers+1] := 0;
                     Location_4[j_pers,i_pers+2] := buf;
                     Pole_4[j_pers,i_pers+2] := Pole_4[j_pers,i_pers+1];
                     Inc(a);
                   End;
               End;
             if Box = True then
               Begin
                 Pole_4[j_pers,i_pers+1].Left := Pole_4[j_pers,i_pers+1].Left + 1;
               End;
             Pole_4[j_pers,i_pers].Left := Pole_4[j_pers,i_pers].Left + 1;
             dx := dx + 1;
             if dx = h then
               Begin
                 buf := Location_4[j_pers,i_pers];
                 Location_4[j_pers,i_pers] := 0;
                 Location_4[j_pers,i_pers+1] := buf;
                 Pole_4[j_pers,i_pers+1] := Pole_4[j_pers,i_pers];
                 i_pers := i_pers + 1;
                 dx := 0;
                 Pole_4[j_pers,i_pers].Picture.LoadFromFile(Player_Images_4[1]);
                 Box := False;
                 a := 0;
                 if steps = 31 then
                   Auto_Time_4.Interval := 100;
                 Inc(steps);
               End;
           End;
       End;
    0,6,7,8,10,11,16,25,26,28:          //down
       Begin
         if (Location_4[j_pers+1,i_pers] = 0) or ((Location_4[j_pers+1,i_pers] = 3) and not(Location_4[j_pers+2,i_pers] = 1) and not(Location_4[j_pers+2,i_pers] = 3)) then
           Begin
             case Animation of
               6: Pole_4[j_pers,i_pers].Picture.LoadFromFile(Player_Images_4[2]);
               12: Pole_4[j_pers,i_pers].Picture.LoadFromFile(Player_Images_4[3]);
             end;
             Inc(Animation);
             if Animation > 12 then
               Animation := 0;
             if a = 0 then
               Begin
                 if (Location_4[j_pers+1,i_pers] = 3) and (not(Location_4[j_pers+2,i_pers] = 1)) then
                   Begin
                     Box := True;
                     buf := Location_4[j_pers+1,i_pers];
                     Location_4[j_pers+1,i_pers] := 0;
                     Location_4[j_pers+2,i_pers] := buf;
                     Pole_4[j_pers+2,i_pers] := Pole_4[j_pers+ 1,i_pers];
                     Inc(a);
                   End;
               End;
             if Box = True then
               Begin
                 Pole_4[j_pers+1,i_pers].Top := Pole_4[j_pers+1,i_pers].Top + 1;
               End;
             Pole_4[j_pers,i_pers].Top := Pole_4[j_pers,i_pers].Top + 1;
             dy := dy + 1;
             if dy = h then
               Begin
                 buf := Location_4[j_pers,i_pers];
                 Location_4[j_pers,i_pers] := 0;
                 Location_4[j_pers+1,i_pers] := buf;
                 Pole_4[j_pers+1,i_pers] := Pole_4[j_pers,i_pers];
                 j_pers := j_pers + 1;
                 dy := 0;
                 Pole_4[j_pers,i_pers].Picture.LoadFromFile(Player_Images_4[1]);
                 Box := False;
                 a := 0;
                 if steps = 31 then
                   Auto_Time_4.Interval := 100;
                 Inc(steps);
               End;
           End;
       End;
    32:
       Begin
         Destroy;
       End;
  end;
end;

procedure TAuto_4Form.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure TAuto_4Form.Construct;
var i, j: Integer;
begin
  Map_4 := TBitMap.Create;
  for i := 1 to n do
    for j := 1 to n do
      Begin
        Pole_4[j,i] := TImage.Create(Auto_4Form);
        Pole_4[j,i].Parent := Auto_4Form;
        Pole_4[j,i].Width := h;
        Pole_4[j,i].Height := h;
        Pole_4[j,i].Left := x0 + (i - 1) * h;
        Pole_4[j,i].Top := y0 + (j - 1) * h;
        Pole_4[j,i].Visible := False;
      End;

  for i := 1 to n do
    for j := 1 to n do
      Begin
        Bt_4[j,i] := TBitBtn.Create(Auto_4Form);
        Bt_4[j,i].Parent := Auto_4Form;
        Bt_4[j,i].Width := h;
        Bt_4[j,i].Height := h;
        Bt_4[j,i].Left := x0 + (j - 1) * h;
        Bt_4[j,i].Top := y0 + (i - 1) * h;
        Bt_4[j,i].Caption := '';
        Bt_4[j,i].Visible :=  False;
      End;

  Auto_4Form.Repaint;
  for i := 1 to n do
    for j := 1 to n do
      Begin
        Bt_4[j,i].Hide;
      End;

  for i := 1 to n do
    for j := 1 to n do
      Begin
        case Location_4[j,i] of
          1:
             Begin
               Pole_4[j,i].Picture.LoadFromFile(Pole_Images_4[1]);
               Pole_4[j,i].Transparent := True;
               Pole_4[j,i].Visible := True;
             End;
          2:
             Begin
               Pole_4[j,i].Picture.LoadFromFile(Pole_Images_4[4]);
               Pole_4[j,i].Transparent := True;
               Pole_4[j,i].Visible := True;
             End;
          3:
             Begin
               Pole_4[j,i].Picture.LoadFromFile(Pole_Images_4[3]);
               Pole_4[j,i].Transparent := True;
               Pole_4[j,i].Visible := True;
             End;
          4:
             Begin
               i_pers := i;
               j_pers := j;
               dy := 0;
               dx := 0;
               Pole_4[j,i].Picture.LoadFromFile(Player_Images_4[1]);
               Pole_4[j,i].Transparent := True;
               Pole_4[j,i].Visible := True;
             End;
        end;
      End;

  Pole1.SendToBack;
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
  Pole24.SendToBack;
  Pole25.SendToBack;
  Pole26.SendToBack;
  Pole27.SendToBack;
  Pole28.SendToBack;
  Pole29.SendToBack;
  Pole_4[3,4].Picture.LoadFromFile('crate_red.png');
  steps := 0;
end;

procedure TAuto_4Form.Destroy;
begin
  Location_4[1,1] := 1;
  Location_4[1,2] := 1;
  Location_4[1,3] := 1;
  Location_4[1,4] := 1;
  Location_4[1,5] := 1;
  Location_4[1,6] := 1;
  Location_4[1,7] := 1;
  Location_4[1,8] := 1;
  Location_4[1,9] := 5;
  Location_4[2,1] := 1;
  Location_4[2,2] := 4;
  Location_4[2,3] := 0;
  Location_4[2,4] := 1;
  Location_4[2,5] := 0;
  Location_4[2,6] := 0;
  Location_4[2,7] := 6;
  Location_4[2,8] := 1;
  Location_4[2,9] := 5;
  Location_4[3,1] := 1;
  Location_4[3,2] := 0;
  Location_4[3,3] := 0;
  Location_4[3,4] := 3;
  Location_4[3,5] := 0;
  Location_4[3,6] := 0;
  Location_4[3,7] := 1;
  Location_4[3,8] := 1;
  Location_4[3,9] := 5;
  Location_4[4,1] := 1;
  Location_4[4,2] := 1;
  Location_4[4,3] := 0;
  Location_4[4,4] := 1;
  Location_4[4,5] := 1;
  Location_4[4,6] := 0;
  Location_4[4,7] := 1;
  Location_4[4,8] := 1;
  Location_4[4,9] := 5;
  Location_4[5,1] := 5;
  Location_4[5,2] := 1;
  Location_4[5,3] := 0;
  Location_4[5,4] := 1;
  Location_4[5,5] := 1;
  Location_4[5,6] := 0;
  Location_4[5,7] := 0;
  Location_4[5,8] := 1;
  Location_4[5,9] := 1;
  Location_4[6,1] := 5;
  Location_4[6,2] := 1;
  Location_4[6,3] := 0;
  Location_4[6,4] := 0;
  Location_4[6,5] := 3;
  Location_4[6,6] := 0;
  Location_4[6,7] := 0;
  Location_4[6,8] := 7;
  Location_4[6,9] := 1;
  Location_4[7,1] := 5;
  Location_4[7,2] := 1;
  Location_4[7,3] := 0;
  Location_4[7,4] := 0;
  Location_4[7,5] := 1;
  Location_4[7,6] := 0;
  Location_4[7,7] := 0;
  Location_4[7,8] := 1;
  Location_4[7,9] := 1;
  Location_4[8,1] := 5;
  Location_4[8,2] := 1;
  Location_4[8,3] := 1;
  Location_4[8,4] := 1;
  Location_4[8,5] := 1;
  Location_4[8,6] := 1;
  Location_4[8,7] := 1;
  Location_4[8,8] := 1;
  Location_4[8,9] := 5;
  Location_4[9,1] := 5;
  Location_4[9,2] := 5;
  Location_4[9,3] := 5;
  Location_4[9,4] := 5;
  Location_4[9,5] := 5;
  Location_4[9,6] := 5;
  Location_4[9,7] := 5;
  Location_4[9,8] := 5;
  Location_4[9,9] := 5;

  FreeAndNil(Pole_4[2,3]);
  FreeAndNil(Pole_4[6,3]);
  FreeAndNil(Pole_4[6,4]);

  dx := 0;
  dy := 0;

  Auto_Time_4.Enabled := False;
  Auto_Time_4.Interval := 10;
  Level4Form.Game_Time_4.Enabled := True;
  Auto_4Form.Hide;
  steps := 0;
end;

end.
