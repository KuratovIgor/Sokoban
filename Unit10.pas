unit Unit10;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Imaging.pngimage;

type
  TAuto_3Form = class(TForm)
    Auto_Time_3: TTimer;
    Pole1: TImage;
    Pole12: TImage;
    Pole4: TImage;
    Pole5: TImage;
    Pole6: TImage;
    Pole8: TImage;
    Pole2: TImage;
    Pole3: TImage;
    Pole7: TImage;
    Pole10: TImage;
    Pole9: TImage;
    Pole11: TImage;
    Pole13: TImage;
    Pole14: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Auto_Time_3Timer(Sender: TObject);
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
                                                                        //0 - ?????? ???????
var Location_3: array [1..n,1..n] of Integer =                         //1 - ?????
                                               ((1,1,1,1,1,5),        //2 - ????? ??? ?????
                                                (1,0,0,0,1,1),       //3 - ????
                                                (1,0,0,3,4,1),      //4 - ????????
                                                (1,1,3,0,0,1),     //5 - ????????? ??????? ???????
                                                (1,0,0,0,0,1),
                                                (1,1,1,1,1,1));


const Player_Images_3: array [1..count_pers] of String = ('staydown.png','down1.png','down2.png',
'stayleft.png','left1.png','left2.png','stayright.png','right1.png','right2.png',
'stayup.png','up1.png','up2.png');

const Pole_Images_3: array [1..count_pole] of String = ('grey_wall.png','ground_grey.png',
'crate_blue.png','tochka_blue.png');

var
  Auto_3Form: TAuto_3Form;
  Pole_3: array [1..n,1..n] of TImage;
  Bt_3: array [1..n,1..n] of TBitBtn;
  Map_3: TBitMap;
  i_pers, j_pers, dy, dx, buf, a, Animation, steps: Integer;
  Box: Boolean;

implementation

{$R *.dfm}

uses Unit9;

procedure TAuto_3Form.Auto_Time_3Timer(Sender: TObject);
begin
  case steps of
    0,2,3,12,13,18,19,26:       //left
       Begin
         if (Location_3[j_pers,i_pers-1] = 0) or ((Location_3[j_pers,i_pers-1] = 3) and (not(Location_3[j_pers,i_pers-2] = 1) and not(Location_3[j_pers,i_pers-2] = 3))) then
           Begin
             case Animation of
               0: Pole_3[j_pers,i_pers].Picture.LoadFromFile(Player_Images_3[4]);
               6: Pole_3[j_pers,i_pers].Picture.LoadFromFile(Player_Images_3[5]);
               12: Pole_3[j_pers,i_pers].Picture.LoadFromFile(Player_Images_3[6]);
             end;
             Inc(Animation);
             if Animation > 12 then
               Animation := 0;
             if a = 0 then
               Begin
                 if (Location_3[j_pers,i_pers-1] = 3) and (not(Location_3[j_pers,i_pers-2] = 1)) then
                   Begin
                     Box := True;
                     buf := Location_3[j_pers,i_pers-1];
                     Location_3[j_pers,i_pers-1] := 0;
                     Location_3[j_pers,i_pers-2] := buf;
                     Pole_3[j_pers,i_pers-2] := Pole_3[j_pers,i_pers-1];
                     Inc(a);
                   End;
               End;
             if Box = True then
               Begin
                 Pole_3[j_pers,i_pers-1].Left := Pole_3[j_pers,i_pers-1].Left - 1;
               End;

             Pole_3[j_pers,i_pers].Left := Pole_3[j_pers,i_pers].Left - 1;
             dx := dx - 1;
             if dx = -h then
               Begin;
                 buf := Location_3[j_pers,i_pers];
                 Location_3[j_pers,i_pers] := 0;
                 Location_3[j_pers,i_pers-1] := buf;
                 Pole_3[j_pers,i_pers-1] := Pole_3[j_pers,i_pers];
                 i_pers := i_pers - 1;
                 dx := 0;
                 Pole_3[j_pers,i_pers].Picture.LoadFromFile(Player_Images_3[1]);
                 Box := False;
                 a := 0;
                 if steps = 28 then
                   Auto_Time_3.Interval := 100;
                 Inc(steps);
               End;
           End;
       End;
    1,6,14,16,17,22:            //up
       Begin
         if (Location_3[j_pers-1,i_pers] = 0) or ((Location_3[j_pers-1,i_pers] = 3) and not(Location_3[j_pers-2,i_pers] = 1) and not(Location_3[j_pers-2,i_pers] = 3)) then
           Begin
             case Animation of
               6: Pole_3[j_pers,i_pers].Picture.LoadFromFile(Player_Images_3[11]);
               12: Pole_3[j_pers,i_pers].Picture.LoadFromFile(Player_Images_3[12]);
             end;
             Inc(Animation);
             if Animation > 12 then
               Animation := 0;
             if a = 0 then
               Begin
                 if (Location_3[j_pers-1,i_pers] = 3) and (not(Location_3[j_pers-2,i_pers] = 1)) then
                   Begin
                     Box := True;
                     buf := Location_3[j_pers-1,i_pers];
                     Location_3[j_pers-1,i_pers] := 0;
                     Location_3[j_pers-2,i_pers] := buf;
                     Pole_3[j_pers-2,i_pers] := Pole_3[j_pers-1,i_pers];
                     Inc(a);
                   End;
               End;
             if Box = True then
               Begin
                 Pole_3[j_pers-1,i_pers].Top := Pole_3[j_pers-1,i_pers].Top - 1;
               End;
             Pole_3[j_pers,i_pers].Top := Pole_3[j_pers,i_pers].Top - 1;
             dy := dy - 1;
             if dy = -h then
               Begin
                 buf := Location_3[j_pers,i_pers];
                 Location_3[j_pers,i_pers] := 0;
                 Location_3[j_pers-1,i_pers] := buf;
                 Pole_3[j_pers-1,i_pers] := Pole_3[j_pers,i_pers];
                 j_pers := j_pers - 1;
                 dy := 0;
                 Pole_3[j_pers,i_pers].Picture.LoadFromFile(Player_Images_3[1]);
                 Box := False;
                 a := 0;
                 if steps = 28 then
                   Auto_Time_3.Interval := 100;
                 Inc(steps);
               End;
           End;
       End;
    5,7,9,15,21,23,28:         //right
       Begin
         if (Location_3[j_pers,i_pers+1] = 0) or ((Location_3[j_pers,i_pers+1] = 3) and (not(Location_3[j_pers,i_pers+2] = 1) and not(Location_3[j_pers,i_pers+2] = 3))) then
           Begin
             case Animation of
               0: Pole_3[j_pers,i_pers].Picture.LoadFromFile(Player_Images_3[7]);
               6: Pole_3[j_pers,i_pers].Picture.LoadFromFile(Player_Images_3[8]);
               12: Pole_3[j_pers,i_pers].Picture.LoadFromFile(Player_Images_3[9]);
             end;
             Inc(Animation);
             if Animation > 12 then
               Animation := 0;
             if a = 0 then
               Begin
                 if (Location_3[j_pers,i_pers+1] = 3) and (not(Location_3[j_pers,i_pers+2] = 1)) then
                   Begin
                     Box := True;
                     buf := Location_3[j_pers,i_pers+1];
                     Location_3[j_pers,i_pers+1] := 0;
                     Location_3[j_pers,i_pers+2] := buf;
                     Pole_3[j_pers,i_pers+2] := Pole_3[j_pers,i_pers+1];
                     Inc(a);
                   End;
               End;
             if Box = True then
               Begin
                 Pole_3[j_pers,i_pers+1].Left := Pole_3[j_pers,i_pers+1].Left + 1;
               End;

             Pole_3[j_pers,i_pers].Left := Pole_3[j_pers,i_pers].Left + 1;
             dx := dx + 1;
             if dx = h then
               Begin;
                 buf := Location_3[j_pers,i_pers];
                 Location_3[j_pers,i_pers] := 0;
                 Location_3[j_pers,i_pers+1] := buf;
                 Pole_3[j_pers,i_pers+1] := Pole_3[j_pers,i_pers];
                 i_pers := i_pers + 1;
                 dx := 0;
                 Pole_3[j_pers,i_pers].Picture.LoadFromFile(Player_Images_3[1]);
                 Box := False;
                 a := 0;
                 if steps = 28 then
                   Auto_Time_3.Interval := 100;
                 Inc(steps);
               End;
           End;
       End;
    4,8,10,11,20,24,25,27:    //down
       Begin
         if (Location_3[j_pers+1,i_pers] = 0) or ((Location_3[j_pers+1,i_pers] = 3) and not(Location_3[j_pers+2,i_pers] = 1) and not(Location_3[j_pers+2,i_pers] = 3)) then
           Begin
             case Animation of
               6: Pole_3[j_pers,i_pers].Picture.LoadFromFile(Player_Images_3[2]);
               12: Pole_3[j_pers,i_pers].Picture.LoadFromFile(Player_Images_3[3]);
             end;
             Inc(Animation);
             if Animation > 12 then
               Animation := 0;
             if a = 0 then
               Begin
                 if (Location_3[j_pers+1,i_pers] = 3) and (not(Location_3[j_pers+2,i_pers] = 1)) then
                   Begin
                     Box := True;
                     buf := Location_3[j_pers+1,i_pers];
                     Location_3[j_pers+1,i_pers] := 0;
                     Location_3[j_pers+2,i_pers] := buf;
                     Pole_3[j_pers+2,i_pers] := Pole_3[j_pers+1,i_pers];
                     Inc(a);
                   End;
               End;
             if Box = True then
               Begin
                 Pole_3[j_pers+1,i_pers].Top := Pole_3[j_pers+1,i_pers].Top + 1;
               End;
             Pole_3[j_pers,i_pers].Top := Pole_3[j_pers,i_pers].Top + 1;
             dy := dy + 1;
             if dy = h then
               Begin
                 buf := Location_3[j_pers,i_pers];
                 Location_3[j_pers,i_pers] := 0;
                 Location_3[j_pers+1,i_pers] := buf;
                 Pole_3[j_pers+1,i_pers] := Pole_3[j_pers,i_pers];
                 j_pers := j_pers + 1;
                 dy := 0;
                 Pole_3[j_pers,i_pers].Picture.LoadFromFile(Player_Images_3[1]);
                 Box := False;
                 a := 0;
                 if steps = 28 then
                   Auto_Time_3.Interval := 100;
                 Inc(steps);
               End;
           End;
       End;
    29:
      Begin
        Destroy;
      End;
  end;
end;

procedure TAuto_3Form.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure TAuto_3Form.Construct;
var i, j: Integer;
begin
  Map_3 := TBitMap.Create;
  for i := 1 to n do
    for j := 1 to n do
      Begin
        Pole_3[j,i] := TImage.Create(Auto_3Form);
        Pole_3[j,i].Parent := Auto_3Form;
        Pole_3[j,i].Width := h;
        Pole_3[j,i].Height := h;
        Pole_3[j,i].Left := x0 + (i - 1) * h;
        Pole_3[j,i].Top := y0 + (j - 1) * h;
        Pole_3[j,i].Visible := False;
      End;

  for i := 1 to n do
    for j := 1 to n do
      Begin
        Bt_3[j,i] := TBitBtn.Create(Auto_3Form);
        Bt_3[j,i].Parent := Auto_3Form;
        Bt_3[j,i].Width := h;
        Bt_3[j,i].Height := h;
        Bt_3[j,i].Left := x0 + (j - 1) * h;
        Bt_3[j,i].Top := y0 + (i - 1) * h;
        Bt_3[j,i].Caption := '';
        Bt_3[j,i].Visible :=  False;
      End;

  Auto_3Form.Repaint;
  for i := 1 to n do
    for j := 1 to n do
      Begin
        Bt_3[j,i].Hide;
      End;

  for i := 1 to n do
    for j := 1 to n do
      Begin
        case Location_3[j,i] of
          1:
             Begin
               Pole_3[j,i].Picture.LoadFromFile(Pole_Images_3[1]);
               Pole_3[j,i].Transparent := True;
               Pole_3[j,i].Visible := True;
             End;
          2:
             Begin
               Pole_3[j,i].Picture.LoadFromFile(Pole_Images_3[4]);
               Pole_3[j,i].Transparent := True;
               Pole_3[j,i].Visible := True;
             End;
          3:
             Begin
               Pole_3[j,i].Picture.LoadFromFile(Pole_Images_3[3]);
               Pole_3[j,i].Transparent := True;
               Pole_3[j,i].Visible := True;
             End;
          4:
             Begin
               i_pers := i;
               j_pers := j;
               dy := 0;
               dx := 0;
               Pole_3[j,i].Picture.LoadFromFile(Player_Images_3[1]);
               Pole_3[j,i].Transparent := True;
               Pole_3[j,i].Visible := True;
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
  Pole_3[3,4].Picture.LoadFromFile('crate_red.png');
  steps := 0;
end;

procedure TAuto_3Form.Destroy;
begin
  Location_3[1,1] := 1;
  Location_3[1,2] := 1;
  Location_3[1,3] := 1;
  Location_3[1,4] := 1;
  Location_3[1,5] := 1;
  Location_3[1,6] := 5;
  Location_3[2,1] := 1;
  Location_3[2,2] := 0;
  Location_3[2,3] := 0;
  Location_3[2,4] := 0;
  Location_3[2,5] := 1;
  Location_3[2,6] := 1;
  Location_3[3,1] := 1;
  Location_3[3,2] := 0;
  Location_3[3,3] := 0;
  Location_3[3,4] := 3;
  Location_3[3,5] := 4;
  Location_3[3,6] := 1;
  Location_3[4,1] := 1;
  Location_3[4,2] := 1;
  Location_3[4,3] := 3;
  Location_3[4,4] := 0;
  Location_3[4,5] := 0;
  Location_3[4,6] := 1;
  Location_3[5,1] := 1;
  Location_3[5,2] := 0;
  Location_3[5,3] := 0;
  Location_3[5,4] := 0;
  Location_3[5,5] := 0;
  Location_3[5,6] := 1;
  Location_3[6,1] := 1;
  Location_3[6,2] := 1;
  Location_3[6,3] := 1;
  Location_3[6,4] := 1;
  Location_3[6,5] := 1;
  Location_3[6,6] := 1;

  FreeAndNil(Pole_3[4,5]);
  FreeAndNil(Pole_3[5,5]);
  FreeAndNil(Pole_3[5,4]);

  dx := 0;
  dy := 0;

  Auto_Time_3.Enabled := False;
  Auto_Time_3.Interval := 10;
  Level3Form.Game_Time_3.Enabled := True;
  Auto_3Form.Hide;
  steps := 0;
end;

end.
