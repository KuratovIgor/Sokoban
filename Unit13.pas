unit Unit13;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons;

type
  TLevel5Form = class(TForm)
    Label1: TLabel;
    Time_5: TLabel;
    Game_Time_5: TTimer;
    Delay_5: TTimer;
    Teleport_Time_5: TTimer;
    Label2: TLabel;
    Label3: TLabel;
    Pole1: TImage;
    Panel1: TPanel;
    Label4: TLabel;
    Step_Label: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Star1_5: TImage;
    Star2_5: TImage;
    Star3_5: TImage;
    Teleport_5: TImage;
    Auto_5: TImage;
    Label7: TLabel;
    Label8: TLabel;
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
    Label9: TLabel;
    Again_5: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Delay_5Timer(Sender: TObject);
    procedure Game_Time_5Timer(Sender: TObject);
    procedure Teleport_5Click(Sender: TObject);
    procedure Teleport_Time_5Timer(Sender: TObject);
    procedure Auto_5Click(Sender: TObject);
    procedure Construct;
    procedure Destroy;
    procedure Again_5Click(Sender: TObject);
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

var Location_5: array [1..n,1..n] of Integer =                           //1 - ?????
                                               ((5,1,1,1,1,1,1,5,5),        //2 - ????? ??? ?????
                                                (5,1,0,0,0,7,1,5,5),       //3 - ????
                                                (5,1,0,3,0,1,1,1,1),      //4 - ????????
                                                (5,1,1,4,3,0,0,6,1),     //5 - ????????? ??????? ???????
                                                (1,1,1,3,0,1,0,1,1),
                                                (1,0,0,0,0,0,0,1,5),
                                                (1,0,0,0,1,1,1,1,5),    //6 - ????????_1
                                                (1,1,1,1,1,5,5,5,5),
                                                (5,5,5,5,5,5,5,5,5)); //7 - ????????_2


const Player_Images_5: array [1..count_pers] of String = ('staydown.png','down1.png','down2.png',
'stayleft.png','left1.png','left2.png','stayright.png','right1.png','right2.png',
'stayup.png','up1.png','up2.png');

const Pole_Images_5: array [1..count_pole] of String = ('red_wall.png','ground_green.png',
'crate_brown.png','tochka_brown_green.png','teleport_ground_gr.png','teleport_ground_gr2.png');

var
  Level5Form: TLevel5Form;
  Pole_5: array [1..n,1..n] of TImage;
  Bt_5: array [1..n,1..n] of TBitBtn;
  Map_5: TBitMap;
  i_pers, j_pers, dy, dx, buf, a, count_box, Seconds, Minute, Animation, Step, count_stars,
  dx_steps, dy_steps, buf_tel, i_box1, j_box1, i_box2, j_box2, i_box3, j_box3: Integer;
  down_press, up_press, right_press, left_press, Box, LookLeft, LookDown, Teleport_On,
  Auto_On, Press_1, Press_2, Teleport_using, Auto_using, Level5_Up, Already_Press,
  BoxOnPlace, BoxOut, BOX1, BOX2, BOX3, Move_box_1, Move_box_2, Move_box_3: Boolean;

implementation

{$R *.dfm}

uses Unit2, Unit14, Unit15;

procedure TLevel5Form.Auto_5Click(Sender: TObject);
begin
  if Auto_using = False then
    Begin
      Auto_On := True;
      Game_Time_5.Enabled := False;
      Auto_5Form.Auto_Time_5.Enabled := True;
      Auto_5Form.Show;
      Auto_5Form.Construct;
      Label8.Font.Color := clRed;
      Auto_using := True;
    End
  else
    Begin
      Label3.Caption := '?? ??? ???????????? ???????????????!'
    End;
end;

procedure TLevel5Form.Delay_5Timer(Sender: TObject);
begin
  if left_press = True then               //left
    Begin
      if (Location_5[j_pers,i_pers-1] = 0) or (Location_5[j_pers,i_pers-1] = 6) or (Location_5[j_pers,i_pers-1] = 7) or ((Location_5[j_pers,i_pers-1] = 3) and (not(Location_5[j_pers,i_pers-2] = 1) and not(Location_5[j_pers,i_pers-2] = 3))) then
        Begin
          if LookLeft = True then
            Begin
              case Animation of
                0: Pole_5[j_pers,i_pers].Picture.LoadFromFile(Player_Images_5[4]);
                6: Pole_5[j_pers,i_pers].Picture.LoadFromFile(Player_Images_5[5]);
                12: Pole_5[j_pers,i_pers].Picture.LoadFromFile(Player_Images_5[6]);
              end;
              Inc(Animation);
              if Animation > 12 then
                Animation := 0;
            End;
          if a = 0 then
            Begin
              if (Location_5[j_pers,i_pers-1] = 3) and (not(Location_5[j_pers,i_pers-2] = 1)) then
                Begin
                  Box := True;

                  if (i_pers-1 = i_box1) and (j_pers = j_box1) then
                    Begin
                      Move_Box_1 := True;
                      Dec(i_box1);
                    End;
                  if (i_pers-1 = i_box2) and (j_pers = j_box2) then
                    Begin
                      Move_Box_2 := True;
                      Dec(i_box2);
                    End;
                  if (i_pers-1 = i_box3) and (j_pers = j_box3) then
                    Begin
                      Move_Box_3 := True;
                      Dec(i_box3);
                    End;

                  if ((j_box3 = 3) and (i_box3 = 5)) and (BOX3 = False) then
                    Begin
                      BoxOnPlace := True;
                      BOX3 := True;
                     End;
                  if ((j_box2 = 4) and (i_box2 = 4)) and (BOX2 = False) then
                    Begin
                      BoxOnPlace := True;
                      BOX2 := True;
                    End;
                  if ((j_box1 = 5) and (i_box1 = 5)) and (BOX1 = False) then
                    Begin
                      BoxOnPlace := True;
                      BOX1 := True;
                    End;

                  if ((j_box3 = 3) and (i_box3+1 = 5)) and (Move_box_3 = True)  then
                    Begin
                      BoxOut := True;
                      BOX3 := False;
                      Move_box_3 := False;
                    End;
                  if ((j_box2 = 4) and (i_box2+1 = 4)) and (Move_box_2 = True) then
                    Begin
                      BoxOut := True;
                      BOX2 := False;
                      Move_box_2 := False;
                    End;
                  if ((j_box1 = 5) and (i_box1+1 = 5)) and (Move_box_1 = True) then
                    Begin
                      BoxOut := True;
                      BOX1 := False;
                      Move_box_1 := False;
                    End;

                  Move_box_1 := False;
                  Move_box_2 := False;
                  Move_box_3 := False;


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
              if BoxOnPlace = True then
                Begin
                  Inc(count_box);
                  BoxOnPlace := False;
                End;
              if BoxOut = True then
                Begin
                  Dec(count_box);
                  BoxOut := False;
                End;
              Box := False;
              Inc(Step);
              Step_Label.Caption := IntToStr(Step);
              delay_5.Enabled := False;
              Already_Press := False;
            End;
        End;
    End;
  if up_press = True then                 //up
    Begin
      if (Location_5[j_pers-1,i_pers] = 0) or (Location_5[j_pers-1,i_pers] = 6) or (Location_5[j_pers-1,i_pers] = 7) or ((Location_5[j_pers-1,i_pers] = 3) and not(Location_5[j_pers-2,i_pers] = 1) and not(Location_5[j_pers-2,i_pers] = 3)) then
        Begin
          if LookDown = False then
            Begin
              case Animation of
                6: Pole_5[j_pers,i_pers].Picture.LoadFromFile(Player_Images_5[11]);
                12: Pole_5[j_pers,i_pers].Picture.LoadFromFile(Player_Images_5[12]);
              end;
              Inc(Animation);
              if Animation > 12 then
                Animation := 0;
            End;
          if a = 0 then
            Begin
              if (Location_5[j_pers-1,i_pers] = 3) and (not(Location_5[j_pers-2,i_pers] = 1)) then
                Begin
                  Box := True;

                  if (i_pers = i_box1) and (j_pers-1 = j_box1) then
                    Dec(j_box1);
                  if (i_pers = i_box2) and (j_pers-1 = j_box2) then
                    Dec(j_box2);
                  if (i_pers = i_box3) and (j_pers-1 = j_box3) then
                    Dec(j_box3);

                  if ((j_box3 = 3) and (i_box3 = 5)) and (BOX3 = False) then
                    Begin
                      BoxOnPlace := True;
                      BOX3 := True;
                     End;
                  if ((j_box2 = 4) and (i_box2 = 4)) and (BOX2 = False) then
                    Begin
                      BoxOnPlace := True;
                      BOX2 := True;
                    End;
                  if ((j_box1 = 5) and (i_box1 = 5)) and (BOX1 = False) then
                    Begin
                      BoxOnPlace := True;
                      BOX1 := True;
                    End;

                  if ((j_box3+1 = 3) and (i_box3 = 5))  then
                    Begin
                      BoxOut := True;
                      BOX3 := False;
                    End;
                  if ((j_box2+1 = 4) and (i_box2 = 4))  then
                    Begin
                      BoxOut := True;
                      BOX2 := False;
                    End;
                  if ((j_box1+1 = 5) and (i_box1 = 5))  then
                    Begin
                      BoxOut := True;
                      BOX1 := False;
                    End;


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
              if BoxOnPlace = True then
                Begin
                  Inc(count_box);
                  BoxOnPlace := False;
                End;
              if BoxOut = True then
                Begin
                  Dec(count_box);
                  BoxOut := False;
                End;
              Box := False;
              Inc(Step);
              Step_Label.Caption := IntToStr(Step);
              delay_5.Enabled := False;
              Already_Press := False;
            End;
        End;
    End;
  if right_press = True then                    //right
    Begin
      if (Location_5[j_pers,i_pers+1] = 0) or (Location_5[j_pers,i_pers+1] = 6) or (Location_5[j_pers,i_pers+1] = 7) or ((Location_5[j_pers,i_pers+1] = 3) and not(Location_5[j_pers,i_pers+2] = 1) and not(Location_5[j_pers,i_pers+2] = 3)) then
        Begin
          if LookLeft = False then
            Begin
              case Animation of
                0: Pole_5[j_pers,i_pers].Picture.LoadFromFile(Player_Images_5[7]);
                6: Pole_5[j_pers,i_pers].Picture.LoadFromFile(Player_Images_5[8]);
                12: Pole_5[j_pers,i_pers].Picture.LoadFromFile(Player_Images_5[9]);
              end;
              Inc(Animation);
              if Animation > 12 then
                Animation := 0;
            End;
          if a = 0 then
            Begin
              if (Location_5[j_pers,i_pers+1] = 3) and (not(Location_5[j_pers,i_pers+2] = 1)) then
                Begin
                  Box := True;

                  if (i_pers+1 = i_box1) and (j_pers = j_box1) then
                    Inc(i_box1);
                  if (i_pers+1 = i_box2) and (j_pers = j_box2) then
                    Inc(i_box2);
                  if (i_pers+1 = i_box3) and (j_pers = j_box3) then
                    Inc(i_box3);

                  if ((j_box3 = 3) and (i_box3 = 5)) and (BOX3 = False) then
                    Begin
                      BoxOnPlace := True;
                      BOX3 := True;
                     End;
                  if ((j_box2 = 4) and (i_box2 = 4)) and (BOX2 = False) then
                    Begin
                      BoxOnPlace := True;
                      BOX2 := True;
                    End;
                  if ((j_box1 = 5) and (i_box1 = 5)) and (BOX1 = False) then
                    Begin
                      BoxOnPlace := True;
                      BOX1 := True;
                    End;

                  if ((j_box3 = 3) and (i_box3-1 = 5))  then
                    Begin
                      BoxOut := True;
                      BOX3 := False;
                    End;
                  if ((j_box2 = 4) and (i_box2-1 = 4))  then
                    Begin
                      BoxOut := True;
                      BOX2 := False;
                    End;
                  if ((j_box1 = 5) and (i_box1-1 = 5))  then
                    Begin
                      BoxOut := True;
                      BOX1 := False;
                    End;


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
              if BoxOnPlace = True then
                Begin
                  Inc(count_box);
                  BoxOnPlace := False;
                End;
              if BoxOut = True then
                Begin
                  Dec(count_box);
                  BoxOut := False;
                End;
              Box := False;
              Inc(Step);
              Step_Label.Caption := IntToStr(Step);
              delay_5.Enabled := False;
              Already_Press := False;
            End;
        End;
    End;
  if down_press = True then                 //down
    Begin
      if (Location_5[j_pers+1,i_pers] = 0) or (Location_5[j_pers+1,i_pers] = 6) or (Location_5[j_pers+1,i_pers] = 7) or ((Location_5[j_pers+1,i_pers] = 3) and not(Location_5[j_pers+2,i_pers] = 1) and not(Location_5[j_pers+2,i_pers] = 3)) then
        Begin
          if LookDown = True then
            Begin
              case Animation of
                6: Pole_5[j_pers,i_pers].Picture.LoadFromFile(Player_Images_5[2]);
                12: Pole_5[j_pers,i_pers].Picture.LoadFromFile(Player_Images_5[3]);
              end;
              Inc(Animation);
              if Animation > 12 then
                Animation := 0;
            End;
          if a = 0 then
            Begin
              if (Location_5[j_pers+1,i_pers] = 3) and (not(Location_5[j_pers+2,i_pers] = 1)) then
                Begin
                  Box := True;

                  if (i_pers = i_box1) and (j_pers+1 = j_box1) then
                    Inc(j_box1);
                  if (i_pers = i_box2) and (j_pers+1 = j_box2) then
                    Inc(j_box2);
                  if (i_pers = i_box3) and (j_pers+1 = j_box3) then
                    Inc(j_box3);

                  if ((j_box3 = 3) and (i_box3 = 5)) and (BOX3 = False) then
                    Begin
                      BoxOnPlace := True;
                      BOX3 := True;
                     End;
                  if ((j_box2 = 4) and (i_box2 = 4)) and (BOX2 = False) then
                    Begin
                      BoxOnPlace := True;
                      BOX2 := True;
                    End;
                  if ((j_box1 = 5) and (i_box1 = 5)) and (BOX1 = False) then
                    Begin
                      BoxOnPlace := True;
                      BOX1 := True;
                    End;

                  if ((j_box3-1 = 3) and (i_box3 = 5))  then
                    Begin
                      BoxOut := True;
                      BOX3 := False;
                    End;
                  if ((j_box2-1 = 4) and (i_box2 = 4))  then
                    Begin
                      BoxOut := True;
                      BOX2 := False;
                    End;
                  if ((j_box1-1 = 5) and (i_box1 = 5))  then
                    Begin
                      BoxOut := True;
                      BOX1 := False;
                    End;


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
              if BoxOnPlace = True then
                Begin
                  Inc(count_box);
                  BoxOnPlace := False;
                End;
              if BoxOut = True then
                Begin
                  Dec(count_box);
                  BoxOut := False;
                End;
              Box := False;
              Inc(Step);
              Step_Label.Caption := IntToStr(Step);
              delay_5.Enabled := False;
              Already_Press := False;
            End;
        End;
    End;
end;

procedure TLevel5Form.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure TLevel5Form.Construct;
var i, j: Integer;
begin
  Map_5 := TBitMap.Create;
  for i := 1 to n do
    for j := 1 to n do
      Begin
        Pole_5[j,i] := TImage.Create(Level5Form);
        Pole_5[j,i].Parent := Level5Form;
        Pole_5[j,i].Width := h;
        Pole_5[j,i].Height := h;
        Pole_5[j,i].Left := x0 + (i - 1) * h;
        Pole_5[j,i].Top := y0 + (j - 1) * h;
        Pole_5[j,i].Visible := False;
      End;

  for i := 1 to n do
    for j := 1 to n do
      Begin
        Bt_5[j,i] := TBitBtn.Create(Level5Form);
        Bt_5[j,i].Parent := Level5Form;
        Bt_5[j,i].Width := h;
        Bt_5[j,i].Height := h;
        Bt_5[j,i].Left := x0 + (j - 1) * h;
        Bt_5[j,i].Top := y0 + (i - 1) * h;
        Bt_5[j,i].Caption := '';
        Bt_5[j,i].Visible :=  False;
      End;

  Level5Form.Repaint;
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
          6:
             Begin
               Pole_5[j,i].Picture.LoadFromFile(Pole_Images_5[5]);
               Pole_5[j,i].Transparent := True;
               Pole_5[j,i].Visible := True;
             End;
          7:
             Begin
               Pole_5[j,i].Picture.LoadFromFile(Pole_Images_5[6]);
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
  Seconds := 30;
  Minute := 2;
  count_stars := 3;
  i_box1 := 4;
  j_box1 := 3;
  i_box2 := 5;
  j_box2 := 4;
  i_box3 := 4;
  j_box3 := 5;
  Game_Time_5.Enabled := True;
end;

procedure TLevel5Form.Destroy;
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
  Location_5[2,6] := 7;
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
  Location_5[4,8] := 6;
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

  FreeAndNil(Pole_5[j_pers,i_pers]);
  FreeAndNil(Pole_5[j_box1,i_box1]);
  FreeAndNil(Pole_5[j_box2,i_box2]);
  FreeAndNil(Pole_5[j_box3,i_box3]);

  Game_Time_5.Enabled := False;
  dx := 0;
  dy := 0;
  count_box := 0;
  count_stars := 3;
  Minute := 2;
  Seconds := 30;
  Step := 0;
  Teleport_using := False;
  Auto_using := False;
  Teleport_On := False;
  Time_5.Caption := '2:30';
  Star1_5.Visible := True;
  Star2_5.Visible := True;
  Star3_5.Visible := True;
  Step_Label.Caption := '0';
  Label7.Font.Color := clHighlight;
  Label8.Font.Color := clHighlight;
  Label3.Caption := '';
end;

procedure TLevel5Form.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 27 then
    Begin
      if Already_Press = False then
        Begin
          Destroy;
          Level5Form.Hide;
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
          delay_5.Enabled := True;
          Label3.Caption := '';
          if not(Location_5[j_pers,i_pers-1]=1) and not(Location_5[j_pers,i_pers-1]=2) and not((Location_5[j_pers,i_pers-1]=3)and(Location_5[j_pers,i_pers-2]=1)) and not((Location_5[j_pers,i_pers-1]=3)and(Location_5[j_pers,i_pers-2]=3)) then
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
          delay_5.Enabled := True;
          Label3.Caption := '';
          if not(Location_5[j_pers-1,i_pers]=1) and not(Location_5[j_pers-1,i_pers]=2) and not((Location_5[j_pers-1,i_pers]=3)and(Location_5[j_pers-2,i_pers]=1)) and not((Location_5[j_pers-1,i_pers]=3)and(Location_5[j_pers-2,i_pers]=3)) then
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
          delay_5.Enabled := True;
          Label3.Caption := '';
          if not(Location_5[j_pers,i_pers+1]=1) and not(Location_5[j_pers,i_pers+1]=2) and not((Location_5[j_pers,i_pers+1]=3)and(Location_5[j_pers,i_pers+2]=1)) and not((Location_5[j_pers,i_pers+1]=3)and(Location_5[j_pers,i_pers+2]=3)) then
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
          delay_5.Enabled := True;
          Label3.Caption := '';
          if not(Location_5[j_pers+1,i_pers]=1) and not(Location_5[j_pers+1,i_pers]=2) and not((Location_5[j_pers+1,i_pers]=3)and(Location_5[j_pers+2,i_pers]=1)) and not((Location_5[j_pers+1,i_pers]=3)and(Location_5[j_pers+2,i_pers]=3)) then
            Already_Press := True;
        End;
    End;
  if Key = 49 then   //press 1
    Begin
      if Teleport_On = True then
        Begin
          dx_steps := i_pers;
          dy_steps := j_pers;
          Pole_5[j_pers,i_pers].Destroy;
          Press_1 := True;
          Label3.Caption := '????????????...';
          Teleport_Time_5.Enabled := True;
        End;
    End;
  if Key = 50 then  //press 2
    Begin
      if Teleport_On = True then
        Begin
          dx_steps := i_pers;
          dy_steps := j_pers;
          Pole_5[j_pers,i_pers].Destroy;
          Press_2 := True;
          Label3.Caption := '????????????...';
          Teleport_Time_5.Enabled := True;
        End;
    End;
  if Key = 13 then
    Begin
      if Already_Press = False then
        Begin
          if Level5_Up = True then
            Begin
              Destroy;
              Level5Form.Hide;
              Level5Form.Game_Time_5.Enabled := True;
              WinForm.Show;
            End;
        End;
    End;
end;

procedure TLevel5Form.Game_Time_5Timer(Sender: TObject);
begin
  if count_box = 3 then
    Begin
      Game_Time_5.Enabled := False;
      Level5_Up := True;
      Label3.Caption := '??? ????? ???????????! ??????? ENTER, ????? ??????????.';
    End;
  Dec(Seconds);
  if Seconds > 9 then Time_5.Caption := IntToStr(Minute) + ':' + IntToStr(Seconds)
  else Time_5.Caption := IntToStr(Minute) + ':0' + IntToStr(Seconds);
  if (Seconds = 0) and (Minute > 0) then
    Begin
      Dec(Minute);
      Seconds := 60;
    End;
  if Step = 46 then
    Begin
      Dec(count_stars);
      Star3_5.Visible := False;
    End;
  if Step = 47 then
    Begin
      Dec(count_stars);
      Star2_5.Visible := False;
    End;
  if Step = 48 then
    Begin
      Dec(count_stars);
      Star1_5.Visible := False;
    End;
  if (Seconds = 0) and (Minute = 0) then
    Begin
      Game_Time_5.Enabled := False;
      ShowMessage('????? ?????! ?? ?????????!');
      Destroy;
      Level5Form.Hide;
      MenuForm.Show;
    End;
end;


procedure TLevel5Form.Again_5Click(Sender: TObject);
begin
  Destroy;
  Construct;
end;

procedure TLevel5Form.Teleport_5Click(Sender: TObject);
begin
  if Teleport_using = True then
    Teleport_Time_5.Enabled := True
  else
    Begin
      Teleport_On := True;
      Label3.Caption := '??? ?????? ?????????? ???????? ????? ???????, ?? ??????? ?? ?????? ?????????????.';
    End;
end;

procedure TLevel5Form.Teleport_Time_5Timer(Sender: TObject);
begin
  if Teleport_using = True then
    Begin
      Label3.Caption := '?? ??? ???????????? ????????????!';
      Teleport_Time_5.Enabled := False;
    End;
  if Press_1 = True then
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
      if dy_steps < 4 then
        Begin
          dy := dy + 5;
          if dy = h then
            Begin
              Inc(dy_steps);
              dy := 0;
            End;
        End;
      if dy_steps > 4 then
        Begin
          dy := dy - 5;
          if dy = -h then
            Begin
              Dec(dy_steps);
              dy := 0;
            End;
        End;
      if (dx_steps = 8) and (dy_steps = 4) then
        Begin
          buf := Location_5[j_pers,i_pers];
          Location_5[j_pers,i_pers] := 0;
          Location_5[dy_steps,dx_steps] := buf;
          i_pers := dx_steps;
          j_pers := dy_steps;
          Teleport_Time_5.Enabled := False;
          Teleport_On := False;
          Teleport_using := True;
          Pole_5[j_pers,i_pers].Picture.LoadFromFile(Player_Images_5[1]);
          Pole_5[2,6].SendToBack;
          Press_1 := False;
          Label3.Caption := '';
          Label7.Font.Color := clRed;
        End;
    End;
  if Press_2 = True then
    Begin
      if dx_steps < 6 then
        Begin
          dx := dx + 5;
          if dx = h then
            Begin
              Inc(dx_steps);
              dx := 0;
            End;
        End;
      if dx_steps > 6 then
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
      if (dx_steps = 6) and (dy_steps = 2) then
        Begin
          buf := Location_5[j_pers,i_pers];
          Location_5[j_pers,i_pers] := 0;
          Location_5[dy_steps,dx_steps] := buf;
          i_pers := dx_steps;
          j_pers := dy_steps;
          Teleport_Time_5.Enabled := False;
          Teleport_On := False;
          Teleport_using := True;
          Pole_5[j_pers,i_pers].Picture.LoadFromFile(Player_Images_5[1]);
          Pole_5[4,8].SendToBack;
          Press_2 := False;
          Label3.Caption := '';
          Label7.Font.Color := clRed;
        End;
    End;
end;

end.
