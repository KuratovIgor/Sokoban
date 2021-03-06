unit Unit11;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.Buttons;

type
  TLevel4Form = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Time_4: TLabel;
    Label4: TLabel;
    Step_Label: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Star3_4: TImage;
    Star2_4: TImage;
    Star1_4: TImage;
    Teleport_4: TImage;
    Auto_4: TImage;
    Teleport_Time_4: TTimer;
    Game_Time_4: TTimer;
    Delay_4: TTimer;
    Pole1: TImage;
    Pole2: TImage;
    Pole5: TImage;
    Pole6: TImage;
    Pole7: TImage;
    Pole8: TImage;
    Pole9: TImage;
    Pole3: TImage;
    Pole4: TImage;
    Pole13: TImage;
    Pole22: TImage;
    Pole17: TImage;
    Pole26: TImage;
    Pole18: TImage;
    Pole27: TImage;
    Pole23: TImage;
    Pole10: TImage;
    Pole19: TImage;
    Pole24: TImage;
    Pole14: TImage;
    Pole20: TImage;
    Pole21: TImage;
    Pole25: TImage;
    Pole11: TImage;
    Pole12: TImage;
    Pole16: TImage;
    Pole15: TImage;
    Label3: TLabel;
    Pole28: TImage;
    Image1: TImage;
    Again_3: TImage;
    Label5: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Delay_4Timer(Sender: TObject);
    procedure Game_Time_4Timer(Sender: TObject);
    procedure Teleport_4Click(Sender: TObject);
    procedure Teleport_Time_4Timer(Sender: TObject);
    procedure Auto_4Click(Sender: TObject);
    procedure Construct;
    procedure Destroy;
    procedure Again_3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
       count_pers = 12;
       count_pole = 6;
       n = 9;
       h = 65;
       x0 = 360;
       y0 = 130;

var Location_4: array [1..n,1..n] of Integer =                           //1 - ?????
                                               ((1,1,1,1,1,1,1,1,5),        //2 - ????? ??? ?????
                                                (1,4,0,1,0,0,6,1,5),       //3 - ????
                                                (1,0,0,3,0,0,1,1,5),      //4 - ????????
                                                (1,1,0,1,1,0,1,1,5),     //5 - ????????? ??????? ???????
                                                (5,1,0,1,1,0,0,1,1),
                                                (5,1,0,0,3,0,0,7,1),
                                                (5,1,0,0,1,0,0,1,1),    //6 - ????????_1
                                                (5,1,1,1,1,1,1,1,5),
                                                (5,5,5,5,5,5,5,5,5)); //7 - ????????_2


const Player_Images_4: array [1..count_pers] of String = ('staydown.png','down1.png','down2.png',
'stayleft.png','left1.png','left2.png','stayright.png','right1.png','right2.png',
'stayup.png','up1.png','up2.png');

const Pole_Images_4: array [1..count_pole] of String = ('brown_wall.png','ground_grey.png',
'crate_green.png','tochka_green_grey.png','teleport_ground.png','teleport_ground_2.png');

var
  Level4Form: TLevel4Form;
  Pole_4: array [1..n,1..n] of TImage;
  Bt_4: array [1..n,1..n] of TBitBtn;
  Map_4: TBitMap;
  i_pers, j_pers, dy, dx, buf, a, count_box, Seconds, Animation, Step, count_stars,
  dx_steps, dy_steps, buf_tel, Minute, i_box1, j_box1, i_box2, j_box2: Integer;
  down_press, up_press, right_press, left_press, Box, LookLeft, LookDown, Teleport_On,
  Auto_On, Press_1, Press_2, Teleport_using, Auto_using, Level4_Up, Already_Press: Boolean;

implementation

{$R *.dfm}

uses Unit2, Unit12, Unit13;

procedure TLevel4Form.Again_3Click(Sender: TObject);
begin
  Destroy;
  Construct;
end;

procedure TLevel4Form.Auto_4Click(Sender: TObject);
begin
  if Auto_using = False then
    Begin
      Auto_On := True;
      Game_Time_4.Enabled := False;
      Auto_4Form.Auto_Time_4.Enabled := True;
      Auto_4Form.Show;
      Auto_4Form.Construct;
      Label9.Font.Color := clRed;
      Auto_using := True;
    End
  else
    Begin
      Label3.Caption := '?? ??? ???????????? ???????????????!'
    End;
end;

procedure TLevel4Form.Delay_4Timer(Sender: TObject);
begin
  if left_press = True then               //left
    Begin
      if (Location_4[j_pers,i_pers-1] = 0) or (Location_4[j_pers,i_pers-1] = 6) or (Location_4[j_pers,i_pers-1] = 7) or ((Location_4[j_pers,i_pers-1] = 3) and (not(Location_4[j_pers,i_pers-2] = 1) and not(Location_4[j_pers,i_pers-2] = 3))) then
        Begin
          if LookLeft = True then
            Begin
              case Animation of
                0: Pole_4[j_pers,i_pers].Picture.LoadFromFile(Player_Images_4[4]);
                6: Pole_4[j_pers,i_pers].Picture.LoadFromFile(Player_Images_4[5]);
                12: Pole_4[j_pers,i_pers].Picture.LoadFromFile(Player_Images_4[6]);
              end;
              Inc(Animation);
              if Animation > 12 then
                Animation := 0;
            End;
          if a = 0 then
            Begin
              if (Location_4[j_pers,i_pers-1] = 3) and (not(Location_4[j_pers,i_pers-2] = 1)) then
                Begin
                Box := True;


                  if ((j_box2 = 2) and (i_box2-1 = 3)) or ((j_box1 = 6) and (i_box1-1 = 3)) then
                    Inc(count_box);
                  if ((j_box2 = 2) and (i_box2+1 = 3)) or ((j_box1 = 6) and (i_box1+1 = 3)) then
                    Dec(count_box);

                    if (i_pers-1 = i_box1) and (j_pers = j_box1) then
                    Dec(i_box1);
                  if (i_pers-1 = i_box2) and (j_pers = j_box2) then
                    Dec(i_box2);

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
              Inc(Step);
              Step_Label.Caption := IntToStr(Step);
              delay_4.Enabled := False;
              Already_Press := False;
            End;
        End;
    End;
  if up_press = True then                 //up
    Begin
      if (Location_4[j_pers-1,i_pers] = 0) or (Location_4[j_pers-1,i_pers] = 6) or (Location_4[j_pers-1,i_pers] = 7) or ((Location_4[j_pers-1,i_pers] = 3) and not(Location_4[j_pers-2,i_pers] = 1) and not(Location_4[j_pers-2,i_pers] = 3)) then
        Begin
          if LookDown = False then
            Begin
              case Animation of
                6: Pole_4[j_pers,i_pers].Picture.LoadFromFile(Player_Images_4[11]);
                12: Pole_4[j_pers,i_pers].Picture.LoadFromFile(Player_Images_4[12]);
              end;
              Inc(Animation);
              if Animation > 12 then
                Animation := 0;
            End;
          if a = 0 then
            Begin
              if (Location_4[j_pers-1,i_pers] = 3) and (not(Location_4[j_pers-2,i_pers] = 1)) then
                Begin
                  Box := True;

                  if ((j_box2-1 = 2) and (i_box2 = 3)) or ((j_box1-1 = 6) and (i_box1 = 3)) then
                    Inc(count_box);
                  if ((j_box2+1 = 2) and (i_box2 = 3)) or ((j_box1+1 = 6) and (i_box1 = 3)) then
                    Dec(count_box);

                    if (i_pers = i_box1) and (j_pers-1 = j_box1) then
                    Dec(j_box1);
                  if (i_pers = i_box2) and (j_pers-1 = j_box2) then
                    Dec(j_box2);

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
              Inc(Step);
              Step_Label.Caption := IntToStr(Step);
              delay_4.Enabled := False;
              Already_Press := False;
            End;
        End;
    End;
  if right_press = True then                    //right
    Begin
      if (Location_4[j_pers,i_pers+1] = 0) or (Location_4[j_pers,i_pers+1] = 6) or (Location_4[j_pers,i_pers+1] = 7) or ((Location_4[j_pers,i_pers+1] = 3) and not(Location_4[j_pers,i_pers+2] = 1) and not(Location_4[j_pers,i_pers+2] = 3)) then
        Begin
          if LookLeft = False then
            Begin
              case Animation of
                0: Pole_4[j_pers,i_pers].Picture.LoadFromFile(Player_Images_4[7]);
                6: Pole_4[j_pers,i_pers].Picture.LoadFromFile(Player_Images_4[8]);
                12: Pole_4[j_pers,i_pers].Picture.LoadFromFile(Player_Images_4[9]);
              end;
              Inc(Animation);
              if Animation > 12 then
                Animation := 0;
            End;
          if a = 0 then
            Begin
              if (Location_4[j_pers,i_pers+1] = 3) and (not(Location_4[j_pers,i_pers+2] = 1)) then
                Begin
                  Box := True;

                  if ((j_box2 = 2) and (i_box2+1 = 3)) or ((j_box1 = 6) and (i_box1+1 = 3)) then
                    Inc(count_box);
                  if ((j_box2 = 2) and (i_box2-1 = 3)) or ((j_box1 = 6) and (i_box1-1 = 3)) then
                    Dec(count_box);

                    if (i_pers+1 = i_box1) and (j_pers = j_box1) then
                    Inc(i_box1);
                  if (i_pers+1 = i_box2) and (j_pers = j_box2) then
                    Inc(i_box2);

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
              Inc(Step);
              Step_Label.Caption := IntToStr(Step);
              delay_4.Enabled := False;
              Already_Press := False;
            End;
        End;
    End;
  if down_press = True then                 //down
    Begin
      if (Location_4[j_pers+1,i_pers] = 0) or (Location_4[j_pers+1,i_pers] = 6) or (Location_4[j_pers+1,i_pers] = 7) or ((Location_4[j_pers+1,i_pers] = 3) and not(Location_4[j_pers+2,i_pers] = 1) and not(Location_4[j_pers+2,i_pers] = 3)) then
        Begin
          if LookDown = True then
            Begin
              case Animation of
                6: Pole_4[j_pers,i_pers].Picture.LoadFromFile(Player_Images_4[2]);
                12: Pole_4[j_pers,i_pers].Picture.LoadFromFile(Player_Images_4[3]);
              end;
              Inc(Animation);
              if Animation > 12 then
                Animation := 0;
            End;
          if a = 0 then
            Begin
              if (Location_4[j_pers+1,i_pers] = 3) and (not(Location_4[j_pers+2,i_pers] = 1)) then
                Begin
                  Box := True;

                  if ((j_box2+1 = 2) and (i_box2 = 3)) or ((j_box1+1 = 6) and (i_box1 = 3)) then
                    Inc(count_box);
                  if ((j_box2-1 = 2) and (i_box2 = 3)) or ((j_box1-1 = 6) and (i_box1 = 3)) then
                    Dec(count_box);

                    if (i_pers = i_box1) and (j_pers+1 = j_box1) then
                    Inc(j_box1);
                  if (i_pers = i_box2) and (j_pers+1 = j_box2) then
                    Inc(j_box2);

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
              Inc(Step);
              Step_Label.Caption := IntToStr(Step);
              delay_4.Enabled := False;
              Already_Press := False;
            End;
        End;
    End;
end;

procedure TLevel4Form.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure TLevel4Form.Construct;
var i, j: Integer;
begin
  Map_4 := TBitMap.Create;
  for i := 1 to n do
    for j := 1 to n do
      Begin
        Pole_4[j,i] := TImage.Create(Level4Form);
        Pole_4[j,i].Parent := Level4Form;
        Pole_4[j,i].Width := h;
        Pole_4[j,i].Height := h;
        Pole_4[j,i].Left := x0 + (i - 1) * h;
        Pole_4[j,i].Top := y0 + (j - 1) * h;
        Pole_4[j,i].Visible := False;
      End;

  for i := 1 to n do
    for j := 1 to n do
      Begin
        Bt_4[j,i] := TBitBtn.Create(Level4Form);
        Bt_4[j,i].Parent := Level4Form;
        Bt_4[j,i].Width := h;
        Bt_4[j,i].Height := h;
        Bt_4[j,i].Left := x0 + (j - 1) * h;
        Bt_4[j,i].Top := y0 + (i - 1) * h;
        Bt_4[j,i].Caption := '';
        Bt_4[j,i].Visible :=  False;
      End;

  Level4Form.Repaint;
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
          6:
             Begin
               Pole_4[j,i].Picture.LoadFromFile(Pole_Images_4[5]);
               Pole_4[j,i].Transparent := True;
               Pole_4[j,i].Visible := True;
             End;
          7:
             Begin
               Pole_4[j,i].Picture.LoadFromFile(Pole_Images_4[6]);
               Pole_4[j,i].Transparent := True;
               Pole_4[j,i].Visible := True;
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
  Pole24.SendToBack;
  Pole25.SendToBack;
  Pole26.SendToBack;
  Pole27.SendToBack;
  Pole28.SendToBack;
  Image1.SendToBack;
  Pole_4[3,4].Picture.LoadFromFile('crate_red.png');
  Seconds := 0;
  Minute := 2;
  count_stars := 3;
  i_box1 := 4;
  j_box1 := 3;
  i_box2 := 5;
  j_box2 := 6;
  Game_Time_4.Enabled := True;
end;

procedure TLevel4Form.Destroy;
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

  FreeAndNil(Pole_4[j_pers,i_pers]);
  FreeAndNil(Pole_4[j_box1,i_box1]);
  FreeAndNil(Pole_4[j_box2,i_box2]);

  Game_Time_4.Enabled := False;
  dx := 0;
  dy := 0;
  count_box := 0;
  count_stars := 3;
  Minute := 2;
  Seconds := 0;
  Step := 0;
  Teleport_using := False;
  Auto_using := False;
  Teleport_On := False;
  Time_4.Caption := '2:00';
  Star1_4.Visible := True;
  Star2_4.Visible := True;
  Star3_4.Visible := True;
  Step_Label.Caption := '0';
  Label8.Font.Color := clHighlight;
  Label9.Font.Color := clHighlight;
  Label3.Caption := '';
end;

procedure TLevel4Form.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 27 then
    Begin
      if Already_Press = False then
        Begin
          Destroy;
          Level4Form.Hide;
          MenuForm.Show;
        End;
    End;
  if Key = 37 then              //left
    Begin
      if Already_Press = False then
        Begin
          a := 0;
          up_press := False;
          left_press := True;
          right_press := False;
          down_press := False;
          LookLeft := True;
          delay_4.Enabled := True;
          Label3.Caption := '';
          if not(Location_4[j_pers,i_pers-1]=1) and not(Location_4[j_pers,i_pers-1]=2) and not((Location_4[j_pers,i_pers-1]=3)and(Location_4[j_pers,i_pers-2]=1)) and not((Location_4[j_pers,i_pers-1]=3)and(Location_4[j_pers,i_pers-2]=3)) then
            Already_Press := True;
        End;
    End;
  if Key = 38 then                 //up
    Begin
      if Already_Press = False then
        Begin
          a := 0;
          up_press := True;
          left_press := False;
          right_press := False;
          down_press := False;
          LookDown := False;
          delay_4.Enabled := True;
          Label3.Caption := '';
          if not(Location_4[j_pers-1,i_pers]=1) and not(Location_4[j_pers-1,i_pers]=2) and not((Location_4[j_pers-1,i_pers]=3)and(Location_4[j_pers-2,i_pers]=1)) and not((Location_4[j_pers-1,i_pers]=3)and(Location_4[j_pers-2,i_pers]=3)) then
            Already_Press := True;
        End;
    End;
  if Key = 39 then                    //right
    Begin
      if Already_Press = False then
        Begin
          a := 0;
          up_press := False;
          left_press := False;
          right_press := True;
          down_press := False;
          LookLeft := False;
          delay_4.Enabled := True;
          Label3.Caption := '';
          if not(Location_4[j_pers,i_pers+1]=1) and not(Location_4[j_pers,i_pers+1]=2) and not((Location_4[j_pers,i_pers+1]=3)and(Location_4[j_pers,i_pers+2]=1)) and not((Location_4[j_pers,i_pers+1]=3)and(Location_4[j_pers,i_pers+2]=3)) then
            Already_Press := True;
        End;
    End;
  if Key = 40 then                 //down
    Begin
      if Already_Press = False then
        Begin
          a := 0;
          up_press := False;
          left_press := False;
          right_press := False;
          down_press := True;
          LookDown := True;
          delay_4.Enabled := True;
          Label3.Caption := '';
          if not(Location_4[j_pers+1,i_pers]=1) and not(Location_4[j_pers+1,i_pers]=2) and not((Location_4[j_pers+1,i_pers]=3)and(Location_4[j_pers+2,i_pers]=1)) and not((Location_4[j_pers+1,i_pers]=3)and(Location_4[j_pers+2,i_pers]=3)) then
            Already_Press := True;
        End;
    End;
  if Key = 49 then   //press 1
    Begin
      if Teleport_On = True then
        Begin
          dx_steps := i_pers;
          dy_steps := j_pers;
          Pole_4[j_pers,i_pers].Destroy;
          Press_1 := True;
          Label3.Caption := '????????????...';
          Teleport_Time_4.Enabled := True;
        End;
    End;
  if Key = 50 then  //press 2
    Begin
      if Teleport_On = True then
        Begin
          dx_steps := i_pers;
          dy_steps := j_pers;
          Pole_4[j_pers,i_pers].Destroy;
          Press_2 := True;
          Label3.Caption := '????????????...';
          Teleport_Time_4.Enabled := True;
        End;
    End;
  if Key = 13 then
    Begin
      if Already_Press = False then
        Begin
          if Level4_Up = True then
            Begin
              Destroy;
              Level4Form.Hide;
              Level5Form.Construct;
              Level5Form.Game_Time_5.Enabled := True;
              Level5Form.Show;
            End;
        End;
    End;
end;

procedure TLevel4Form.Game_Time_4Timer(Sender: TObject);
begin
  if count_box = 2 then
    Begin
      Game_Time_4.Enabled := False;
      Level4_Up := True;
      Label3.Caption := '??? ????? ???????????! ??????? ENTER, ????? ??????????.';
    End;
  if (Seconds = 0) and (Minute > 0) then
    Begin
      Dec(Minute);
      Seconds := 60;
    End;
  Dec(Seconds);
  if Seconds > 9 then Time_4.Caption := IntToStr(Minute) + ':' + IntToStr(Seconds)
  else Time_4.Caption := IntToStr(Minute) + ':0' + IntToStr(Seconds);
  if Step = 33 then
    Begin
      Dec(count_stars);
      Star3_4.Visible := False;
    End;
  if Step = 34 then
    Begin
      Dec(count_stars);
      Star2_4.Visible := False;
    End;
  if Step = 35 then
    Begin
      Dec(count_stars);
      Star1_4.Visible := False;
    End;
  if (Seconds = 0) and (Minute = 0) then
    Begin
      Game_Time_4.Enabled := False;
      ShowMessage('????? ?????! ?? ?????????!');
      Destroy;
      Level4Form.Hide;
      MenuForm.Show;
    End;
end;

procedure TLevel4Form.Teleport_4Click(Sender: TObject);
begin
  if Teleport_using = True then
    Teleport_Time_4.Enabled := True
  else
    Begin
      Teleport_On := True;
      Label3.Caption := '??? ?????? ?????????? ???????? ????? ???????, ?? ??????? ?? ?????? ?????????????.';
    End;
end;

procedure TLevel4Form.Teleport_Time_4Timer(Sender: TObject);
begin
  if Teleport_using = True then
    Begin
      Label3.Caption := '?? ??? ???????????? ????????????!';
      Teleport_Time_4.Enabled := False;
    End;
  if Press_1 = True then
    Begin
      if dx_steps < 7 then
        Begin
          dx := dx + 5;
          if dx = h then
            Begin
              Inc(dx_steps);
              dx := 0;
            End;
        End;
      if dx_steps > 7 then
        Begin
          dx := dx - 5;
          if dx = -h then
            Begin
              Dec(dx_steps);
              dx := 0;
            End;
        End;
      if dy_steps < 2 then
        Begin
          dy := dy + 5;
          if dy = h then
            Begin
              Inc(dy_steps);
              dy := 0;
            End;
        End;
      if dy_steps > 2 then
        Begin
          dy := dy - 5;
          if dy = -h then
            Begin
              Dec(dy_steps);
              dy := 0;
            End;
        End;
      if (dx_steps = 7) and (dy_steps = 2) then
        Begin
          buf := Location_4[j_pers,i_pers];
          Location_4[j_pers,i_pers] := 0;
          Location_4[dy_steps,dx_steps] := buf;
          i_pers := dx_steps;
          j_pers := dy_steps;
          Teleport_Time_4.Enabled := False;
          Teleport_On := False;
          Teleport_using := True;
          Pole_4[j_pers,i_pers].Picture.LoadFromFile(Player_Images_4[1]);
          Pole_4[6,8].SendToBack;
          Press_1 := False;
          Label3.Caption := '';
          Label8.Font.Color := clRed;
        End;
    End;
  if Press_2 = True then
    Begin
      if dx_steps < 8 then
        Begin
          dx := dx + 5;
          if dx = h then
            Begin
              Inc(dx_steps);
              dx := 0;
            End;
        End;
      if dx_steps > 8 then
        Begin
          dx := dx - 5;
          if dx = -h then
            Begin
              Dec(dx_steps);
              dx := 0;
            End;
        End;
      if dy_steps < 6 then
        Begin
          dy := dy + 5;
          if dy = h then
            Begin
              Inc(dy_steps);
              dy := 0;
            End;
        End;
      if dy_steps > 6 then
        Begin
          dy := dy - 5;
          if dy = -h then
            Begin
              Dec(dy_steps);
              dy := 0;
            End;
        End;
      if (dx_steps = 8) and (dy_steps = 6) then
        Begin
          buf := Location_4[j_pers,i_pers];
          Location_4[j_pers,i_pers] := 0;
          Location_4[dy_steps,dx_steps] := buf;
          i_pers := dx_steps;
          j_pers := dy_steps;
          Teleport_Time_4.Enabled := False;
          Teleport_On := False;
          Teleport_using := True;
          Pole_4[j_pers,i_pers].Picture.LoadFromFile(Player_Images_4[1]);
          Pole_4[2,7].SendToBack;
          Press_2 := False;
          Label3.Caption := '';
          Label8.Font.Color := clRed;
        End;
    End;
end;

end.
