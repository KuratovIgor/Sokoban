unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.Buttons, System.ImageList, Vcl.ImgList, Vcl.Imaging.jpeg,
  Vcl.Menus;



type
  TLevel1Form = class(TForm)
    Pole1: TImage;
    Pole2: TImage;
    Pole6: TImage;
    Pole3: TImage;
    Pole4: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Time: TLabel;
    Game_Time: TTimer;
    Delay: TTimer;
    Panel1: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Step_Label: TLabel;
    Label5: TLabel;
    Teleport: TImage;
    Label6: TLabel;
    Auto: TImage;
    Label7: TLabel;
    Label8: TLabel;
    Star1: TImage;
    Star2: TImage;
    Star3: TImage;
    Teleport_Time: TTimer;
    Pole5: TImage;
    Again: TImage;
    Label9: TLabel;
    Pole7: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DelayTimer(Sender: TObject);
    procedure Game_TimeTimer(Sender: TObject);
    procedure TeleportClick(Sender: TObject);
    procedure AutoClick(Sender: TObject);
    procedure Teleport_TimeTimer(Sender: TObject);
    procedure Destroy;
    procedure Construct;
    procedure AgainClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
       count_pers = 12;
       count_pole = 5;
       n = 6;
       h = 65;
       x0 = 424;
       y0 = 128;
                                                                        //0 - ?????? ???????
var Location: array [1..n,1..n] of Integer =                           //1 - ?????
                                               ((5,1,1,1,5,5),        //2 - ????? ??? ?????
                                                (5,1,2,1,1,5),       //3 - ????
                                                (1,1,3,4,1,1),      //4 - ????????
                                                (1,2,3,0,6,1),     //5 - ????????? ??????? ???????
                                                (1,1,1,1,1,1),    //6 - ????????_1
                                                (5,5,5,5,5,5));

const Player_Images: array [1..count_pers] of String = ('staydown.png','down1.png','down2.png',
'stayleft.png','left1.png','left2.png','stayright.png','right1.png','right2.png',
'stayup.png','up1.png','up2.png');

const Pole_Images: array [1..count_pole] of String = ('red_wall.png','ground_grey.png',
'crate_blue.png','tochka_blue.png','teleport_ground.png');

var
  Level1Form: TLevel1Form;
  Pole: array [1..n,1..n] of TImage;
  Bt: array [1..n,1..n] of TBitBtn;
  Map: TBitMap;
  i_pers, j_pers, dy, dx, buf, a, count_box, Seconds, Animation, Step, count_stars,
  dx_steps, dy_steps, buf_tel, i_box1, j_box1, i_box2, j_box2: Integer;
  down_press, up_press, right_press, left_press, Box, LookLeft, LookDown, Teleport_On,
  Auto_On, Press_1, Teleport_using, Auto_using, Level_Up, Already_Press: Boolean;


implementation

{$R *.dfm}

uses Unit2, Unit6, Unit7;


procedure TLevel1Form.AgainClick(Sender: TObject);
begin
  Destroy;
  Construct;
end;

procedure TLevel1Form.AutoClick(Sender: TObject);
{??? ??????? ?? ?????? ??????????????? ?????? ???????? ??? ????????? ?????
 ?? ??????????? ?????????? ?????. ??? ??????? ???? ?? ????????.}
begin
  if Auto_using = False then
    Begin
      Auto_On := True;
      Game_Time.Enabled := False;
      Auto_1Form.Auto_Time.Enabled := True;
      Auto_1Form.Show;
      Auto_1Form.Construct;
      Label8.Font.Color := clRed;
      Auto_using := True;
    End
  else
    Begin
      Label6.Caption := '?? ??? ???????????? ???????????????!'
    End;
end;

procedure TLevel1Form.DelayTimer(Sender: TObject);
{?? ????? ??????? ????????? ????????, ? ??? ?????? ?????????????? ??????? ?????????????
 ??????? ????? ????????? ????. ??? ??????????? ?? 1 ?????? ?????????? ?????? ???????.}
begin
  if left_press = True then               //left
    Begin
      if (Location[j_pers,i_pers-1] = 0) or (Location[j_pers,i_pers-1] = 6) or ((Location[j_pers,i_pers-1] = 3) and not(Location[j_pers,i_pers-2] = 1)) then
        Begin
          if LookLeft = True then
            Begin
              case Animation of
                0: Pole[j_pers,i_pers].Picture.LoadFromFile(Player_Images[4]);
                6: Pole[j_pers,i_pers].Picture.LoadFromFile(Player_Images[5]);
                12: Pole[j_pers,i_pers].Picture.LoadFromFile(Player_Images[6]);
              end;
              Inc(Animation);
              if Animation > 12 then
                Animation := 0;
            End;
          if a = 0 then
          {???? ??????? ???? ? ??????? ??????????? ?????? 1 ??? ??? ?????? ???????
           ??? ???????????? ????? ? ???????.}
            Begin
              if (Location[j_pers,i_pers-1] = 3) and (not(Location[j_pers,i_pers-2] = 1)) then
                Begin
                  Box := True;
                  if (i_pers-1 = i_box1) and (j_pers = j_box1) then
                    Dec(i_box1);
                  if (i_pers-1 = i_box2) and (j_pers = j_box2) then
                    Dec(i_box2);
                  if Location[j_pers,i_pers-2] = 2 then
                    Inc(count_box);
                  buf := Location[j_pers,i_pers-1];
                  Location[j_pers,i_pers-1] := 0;
                  Location[j_pers,i_pers-2] := buf;
                  Pole[j_pers,i_pers-2] := Pole[j_pers,i_pers-1];
                  Inc(a);
                End;
            End;
          if Box = True then   //??????? ????
            Begin
              Pole[j_pers,i_pers-1].Left := Pole[j_pers,i_pers-1].Left - 1;
            End;

          Pole[j_pers,i_pers].Left := Pole[j_pers,i_pers].Left - 1;
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
              Inc(Step);               //??????? ?????
              Step_Label.Caption := IntToStr(Step);
              delay.Enabled := False;
              Already_Press := False;
            End;
        End;
    End;
    //????? ??????????
  if up_press = True then                 //up
    Begin
      if (Location[j_pers-1,i_pers] = 0) or (Location[j_pers-1,i_pers] = 6) or ((Location[j_pers-1,i_pers] = 3) and not(Location[j_pers-2,i_pers] = 1)) then
        Begin
          if LookDown = False then
            Begin
              case Animation of
                6: Pole[j_pers,i_pers].Picture.LoadFromFile(Player_Images[11]);
                12: Pole[j_pers,i_pers].Picture.LoadFromFile(Player_Images[12]);
              end;
              Inc(Animation);
              if Animation > 12 then
                Animation := 0;
            End;
          if a = 0 then
            Begin
              if (Location[j_pers-1,i_pers] = 3) and (not(Location[j_pers-2,i_pers] = 1)) then
                Begin
                  Box := True;
                  if (i_pers = i_box1) and (j_pers-1 = j_box1) then
                    Dec(j_box1);
                  if (i_pers = i_box2) and (j_pers-1 = j_box2) then
                    Dec(j_box2);
                  if Location[j_pers-2,i_pers] = 2 then
                    Inc(count_box);
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
              Inc(Step);
              Step_Label.Caption := IntToStr(Step);
              delay.Enabled := False;
              Already_Press := False;
            End;
        End;
    End;
  if right_press = True then                    //right
    Begin
      if (Location[j_pers,i_pers+1] = 0) or (Location[j_pers,i_pers+1] = 6) or ((Location[j_pers,i_pers+1] = 3) and not(Location[j_pers,i_pers+2] = 1)) then
        Begin
          if LookLeft = False then
            Begin
              case Animation of
                0: Pole[j_pers,i_pers].Picture.LoadFromFile(Player_Images[7]);
                6: Pole[j_pers,i_pers].Picture.LoadFromFile(Player_Images[8]);
                12: Pole[j_pers,i_pers].Picture.LoadFromFile(Player_Images[9]);
              end;
              Inc(Animation);
              if Animation > 12 then
                Animation := 0;
            End;
          if a = 0 then
            Begin
              if (Location[j_pers,i_pers+1] = 3) and (not(Location[j_pers,i_pers+2] = 1)) then
                Begin
                  Box := True;
                  if (i_pers+1 = i_box1) and (j_pers = j_box1) then
                    Inc(i_box1);
                  if (i_pers+1 = i_box2) and (j_pers = j_box2) then
                    Inc(i_box2);
                  if Location[j_pers,i_pers+2] = 2 then
                    Inc(count_box);
                  buf := Location[j_pers,i_pers+1];
                  Location[j_pers,i_pers+1] := 0;
                  Location[j_pers,i_pers+2] := buf;
                  Pole[j_pers,i_pers+2] := Pole[j_pers,i_pers+1];
                  Inc(a);
                End;
            End;
          if Box = True then
            Begin
              Pole[j_pers,i_pers+1].Left := Pole[j_pers,i_pers+1].Left + 1;
            End;
          Pole[j_pers,i_pers].Left := Pole[j_pers,i_pers].Left + 1;
          dx := dx + 1;
          if dx = h then
            Begin
              buf := Location[j_pers,i_pers];
              Location[j_pers,i_pers] := 0;
              Location[j_pers,i_pers+1] := buf;
              Pole[j_pers,i_pers+1] := Pole[j_pers,i_pers];
              i_pers := i_pers + 1;
              dx := 0;
              Pole[j_pers,i_pers].Picture.LoadFromFile(Player_Images[1]);
              Box := False;
              Inc(Step);
              Step_Label.Caption := IntToStr(Step);
              delay.Enabled := False;
              Already_Press := False;
            End;
        End;
    End;
  if down_press = True then                 //down
    Begin
      if (Location[j_pers+1,i_pers] = 0) or (Location[j_pers+1,i_pers] = 6) or ((Location[j_pers+1,i_pers] = 3) and not(Location[j_pers+2,i_pers] = 1)) then
        Begin
          if LookDown = True then
            Begin
              case Animation of
                6: Pole[j_pers,i_pers].Picture.LoadFromFile(Player_Images[2]);
                12: Pole[j_pers,i_pers].Picture.LoadFromFile(Player_Images[3]);
              end;
              Inc(Animation);
              if Animation > 12 then
                Animation := 0;
            End;
          if a = 0 then
            Begin
              if (Location[j_pers+1,i_pers] = 3) and (not(Location[j_pers+2,i_pers] = 1)) then
                Begin
                  Box := True;
                  if (i_pers = i_box1) and (j_pers+1 = j_box1) then
                    Inc(j_box1);
                  if (i_pers = i_box2) and (j_pers+1 = j_box2) then
                    Inc(j_box2);
                  if Location[j_pers+2,i_pers] = 2 then
                    Inc(count_box);
                  buf := Location[j_pers+1,i_pers];
                  Location[j_pers+1,i_pers] := 0;
                  Location[j_pers+2,i_pers] := buf;
                  Pole[j_pers+2,i_pers] := Pole[j_pers+1,i_pers];
                  Inc(a);
                End;
            End;
          if Box = True then
            Begin
              Pole[j_pers+1,i_pers].Top := Pole[j_pers+1,i_pers].Top + 1;
            End;
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
              Box := False;
              Inc(Step);
              Step_Label.Caption := IntToStr(Step);
              delay.Enabled := False;
              Already_Press := False;
            End;
        End;
    End;
end;

procedure TLevel1Form.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure TLevel1Form.Construct;
var i, j: Integer;
begin
  Map := TBitMap.Create;
  for i := 1 to n do
    for j := 1 to n do
      Begin
        Pole[j,i] := TImage.Create(Level1Form);
        Pole[j,i].Parent := Level1Form;
        Pole[j,i].Width := h;
        Pole[j,i].Height := h;
        Pole[j,i].Left := x0 + (i - 1) * h;
        Pole[j,i].Top := y0 + (j - 1) * h;
        Pole[j,i].Visible := False;
      End;

  for i := 1 to n do
    for j := 1 to n do
      Begin
        Bt[j,i] := TBitBtn.Create(Level1Form);
        Bt[j,i].Parent := Level1Form;
        Bt[j,i].Width := h;
        Bt[j,i].Height := h;
        Bt[j,i].Left := x0 + (j - 1) * h;
        Bt[j,i].Top := y0 + (i - 1) * h;
        Bt[j,i].Caption := '';
        Bt[j,i].Visible :=  False;
      End;

  Level1Form.Repaint;
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
          6:
             Begin
               Pole[j,i].Picture.LoadFromFile(Pole_Images[5]);
               Pole[j,i].Transparent := True;
               Pole[j,i].Visible := True;
             End;
        end;
      End;

  Pole6.SendToBack;            //////////////////////////////////////
  Pole1.SendToBack;           //                                  //
  Pole2.SendToBack;          // ??????? ??? ????????? ???????    //
  Pole3.SendToBack;         // ???? ?? ?????? ????, ????? ?????-//
  Pole4.SendToBack;        // ??? ?? ???????? ??? ????         //
  Pole5.SendToBack;       //////////////////////////////////////
  Pole7.SendToBack;
  Seconds := 30;
  count_stars := 3;
  i_box1 := 3;
  j_box1 := 3;
  i_box2 := 3;
  j_box2 := 4;
  Game_Time.Enabled := True;
end;

procedure TLevel1Form.Destroy;
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
  Location[3,6] := 1;
  Location[4,1] := 1;
  Location[4,2] := 2;
  Location[4,3] := 3;
  Location[4,4] := 0;
  Location[4,5] := 1;
  Location[4,5] := 6;
  Location[5,1] := 1;
  Location[5,2] := 1;
  Location[5,3] := 1;
  Location[5,4] := 1;
  Location[5,5] := 1;

  FreeAndNil(Pole[j_pers,i_pers]);
  FreeAndNil(Pole[j_box1,i_box1]);
  FreeAndNil(Pole[j_box2,i_box2]);

  Game_Time.Enabled := False;
  count_box := 0;
  count_stars := 3;
  Seconds := 30;
  Step := 0;
  Teleport_using := False;
  Auto_using := False;
  Teleport_On := False;
  Time.Caption := '0:30';
  Star1.Visible := True;
  Star2.Visible := True;
  Star3.Visible := True;
  Step_Label.Caption := '0';
  Label7.Font.Color := clHighlight;
  Label8.Font.Color := clHighlight;
  Label6.Caption := '';
end;

procedure TLevel1Form.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i: Integer;
  j: Integer;
begin
  if Key = 27 then
    Begin
      if Already_Press = False then
        Begin
          Destroy;
          Level1Form.Hide;
          MenuForm.Show;
        End;
    End;
  if Key = 37 then              //left
  {??? ?????? ???? ?????????? ?????????? ????????????, ???? ?? ????????? ????????? ?
   ? ????? ??????? ?? ???????. ??? ??? ?????????? ???????????? ???????? delay.}
    Begin
      if Already_Press = False then
        Begin
          a := 0;
          up_press := False;
          left_press := True;
          right_press := False;
          down_press := False;
          LookLeft := True;
          delay.Enabled := True;
          Label6.Caption := '';
          if not(Location[j_pers,i_pers-1] = 1) and not((Location[j_pers,i_pers-1]=3)and(Location[j_pers,i_pers-2]=1)) then
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
          delay.Enabled := True;
          Label6.Caption := '';
          if not(Location[j_pers-1,i_pers] = 1) and not((Location[j_pers-1,i_pers]=3)and(Location[j_pers-2,i_pers]=1)) then
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
          delay.Enabled := True;
          Label6.Caption := '';
          if not(Location[j_pers,i_pers+1] = 1) and not((Location[j_pers,i_pers+1]=3)and(Location[j_pers,i_pers+2]=1)) then
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
          delay.Enabled := True;
          Label6.Caption := '';
          if not(Location[j_pers+1,i_pers] = 1) and not((Location[j_pers+1,i_pers]=3)and(Location[j_pers+2,i_pers]=1)) then
            Already_Press := True;
        End;
    End;
  if Key = 49 then   //press 1
  {??? ??????? ?? ??????? "1" ???????????? ????????, ? ???????? ??????????? ?? ???????
   ????, ??????????????? ????? ??????? ?????? ??????? ?????. ????? ????? ????? ?? ???????
   ? ?????????? ????? ?????????. ??? ???????? ???? ??????? ????? ??????????? ?????????
   ? ?????? Location ?? ????? ???????, ???????? ?????? ???? ? ?????? ??? ????????.}
    Begin
      if Teleport_On = True then
        Begin
          dx_steps := i_pers;
          dy_steps := j_pers;
          Pole[j_pers,i_pers].Destroy;
          Press_1 := True;
          Label6.Caption := '????????????...';
          Teleport_Time.Enabled := True;
        End;
    End;
  if Key = 13 then
    Begin
      if Already_Press = False then
        Begin
          if Level_Up = True then
            Begin
              Destroy;
              Level1Form.Hide;
              Level2Form.Construct;
              Level2Form.Game_Time_2.Enabled := True;
              Level2Form.Show;
            End;
        End;
    End;
end;

procedure TLevel1Form.Game_TimeTimer(Sender: TObject);
begin
  if count_box = 2 then
    Begin
      Game_Time.Enabled := False;
      Level_Up := True;
      Label6.Caption := '??? ????? ???????????! ??????? ENTER, ????? ??????????.';
    End;
  Dec(Seconds);
  if Seconds > 9 then Time.Caption := '0:' + IntToStr(Seconds)
  else Time.Caption := '0:0' + IntToStr(Seconds);
  if Step = 4 then
    Begin                                  ////////////////////////////////////////
      Dec(count_stars);                   //? ??????????? ?? ?????????? ?????   //
      Star3.Visible := False;            //???????????? ?????????? ??????????  //
    End;                                //?????                               //
  if Step = 5 then                     //                                    //
    Begin                             //                                    //
      Dec(count_stars);              //                                    //
      Star2.Visible := False;       //                                    //
    End;                           //                                    //
  if Step = 6 then                //                                    //
    Begin                        //                                    //
      Dec(count_stars);         ////////////////////////////////////////
      Star1.Visible := False;
    End;
  if Seconds = 0 then
    Begin
      Game_Time.Enabled := False;
      ShowMessage('????? ?????! ?? ?????????!');
      Destroy;
      Level1Form.Hide;
      MenuForm.Show;
    End;
end;

procedure TLevel1Form.TeleportClick(Sender: TObject);
{????? ???????????? ?????????? ????????????? ?????????.
 ?????????? ????? ???????????? ?????? 1 ??? ?? ???????.
 ???? ??? ??????? ??? ????????????, ?? ???????? ????? ???????? ???????}
begin
  if Teleport_using = True then  //???? ???????? ??? ???????????
    Teleport_Time.Enabled := True
  else
    Begin    //????? ??????? ??? ???????????? ?????? ? ????????? ??????? ??????
      Teleport_On := True;
      Label6.Caption := '??? ?????? ?????????? ???????? ????? ???????, ?? ??????? ?? ?????? ?????????????.';
    End;
end;

procedure TLevel1Form.Teleport_TimeTimer(Sender: TObject);
{??? ?????? ????? ??????? ?????????? ????????????. ? ??????????? ?? ?????????? ???????
 ???????? ???? ?????? ??????? ?? ????????? ?????. ???? ???????????? ???????????, ??
 ????? ???????? ?????????????? ?????????. ???????????? ????? ????????????
 ????? ??? ???????????? ?? ????????????? :) }
begin
  if Teleport_using = True then
    Begin
      Label6.Caption := '?? ??? ???????????? ????????????!';
      Teleport_Time.Enabled := False;
    End;
  if Press_1 = True then
  {????? ????? ?????????? ?????????????? ??? ?????? ?????????? dx_steps ? dy_steps.}
    Begin
      if dx_steps < 5 then
        Begin
          dx := dx + 1;
          if dx = h then
            Begin
              Inc(dx_steps);
              dx := 0;
            End;
        End;
      if dx_steps > 5 then
        Begin
          dx := dx - 1;
          if dx = -h then
            Begin
              Dec(dx_steps);
              dx := 0;
            End;
        End;
      if dy_steps < 4 then
        Begin
          dy := dy + 1;
          if dy = h then
            Begin
              Inc(dy_steps);
              dy := 0;
            End;
        End;
      if dy_steps > 4 then
        Begin
          dy := dy - 1;
          if dy = -h then
            Begin
              Dec(dy_steps);
              dy := 0;
            End;
        End;
      if (dx_steps = 5) and (dy_steps = 4) then
        Begin
          buf := Location[j_pers,i_pers];
          Location[j_pers,i_pers] := 0;
          Location[dy_steps,dx_steps] := buf;
          i_pers := dx_steps;
          j_pers := dy_steps;
          Teleport_Time.Enabled := False;
          Teleport_On := False;
          Teleport_using := True;
          Pole[j_pers,i_pers].Picture.LoadFromFile(Player_Images[1]);
          Press_1 := False;
          Label6.Caption := '';
          Label7.Font.Color := clRed;
        End;
    End;
end;

End.
