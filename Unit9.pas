unit Unit9;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.Imaging.pngimage;

type
  TLevel3Form = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Teleport_Time_3: TTimer;
    Delay_3: TTimer;
    Game_Time_3: TTimer;
    Time_3: TLabel;
    Pole1: TImage;
    Pole2: TImage;
    Pole3: TImage;
    Pole5: TImage;
    Pole4: TImage;
    Pole12: TImage;
    Pole9: TImage;
    Pole7: TImage;
    Pole10: TImage;
    Pole6: TImage;
    Pole8: TImage;
    Pole13: TImage;
    Pole11: TImage;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Step_Label: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Star1_3: TImage;
    Star2_3: TImage;
    Star3_3: TImage;
    Teleport_3: TImage;
    Auto_3: TImage;
    Label6: TLabel;
    Label9: TLabel;
    Again_3: TImage;
    Pole14: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Delay_3Timer(Sender: TObject);
    procedure Game_Time_3Timer(Sender: TObject);
    procedure Teleport_3Click(Sender: TObject);
    procedure Teleport_Time_3Timer(Sender: TObject);
    procedure Auto_3Click(Sender: TObject);
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
       n = 6;
       h = 65;
       x0 = 425;
       y0 = 130;

var Location_3: array [1..n,1..n] of Integer =                           //1 - ?????
                                               ((1,1,1,1,1,5),        //2 - ????? ??? ?????
                                                (1,0,0,0,1,1),       //3 - ????
                                                (1,0,0,3,4,1),      //4 - ????????
                                                (1,1,3,0,0,1),     //5 - ????????? ??????? ???????
                                                (1,6,0,0,0,1),    //6 - ????????_1
                                                (1,1,1,1,1,1));   //7 - ????????_2


const Player_Images_3: array [1..count_pers] of String = ('staydown.png','down1.png','down2.png',
'stayleft.png','left1.png','left2.png','stayright.png','right1.png','right2.png',
'stayup.png','up1.png','up2.png');

const Pole_Images_3: array [1..count_pole] of String = ('grey_wall.png','ground_grey.png',
'crate_blue.png','tochka_blue.png','teleport_ground_br.png','teleport_ground_gr2.png');

var
  Level3Form: TLevel3Form;
  Pole_3: array [1..n,1..n] of TImage;
  Bt_3: array [1..n,1..n] of TBitBtn;
  Map_3: TBitMap;
  i_pers, j_pers, dy, dx, buf, a, count_box, Seconds, Animation, Step, count_stars,
  dx_steps, dy_steps, buf_tel, Minute, i_box1, j_box1, i_box2, j_box2: Integer;
  down_press, up_press, right_press, left_press, Box, LookLeft, LookDown, Teleport_On,
  Auto_On, Press_1, Press_2, Teleport_using, Auto_using, Level3_Up, Already_Press: Boolean;

implementation

{$R *.dfm}

uses Unit7, Unit2, Unit10, Unit11;

procedure TLevel3Form.Again_3Click(Sender: TObject);
begin
  Destroy;
  Construct;
end;

procedure TLevel3Form.Auto_3Click(Sender: TObject);
begin
  if Auto_using = False then
    Begin
      Auto_On := True;
      Game_Time_3.Enabled := False;
      Auto_3Form.Auto_Time_3.Enabled := True;
      Auto_3Form.Show;
      Auto_3Form.Construct;
      Label8.Font.Color := clRed;
      Auto_using := True;
    End
  else
    Begin
      Label6.Caption := '?? ??? ???????????? ???????????????!'
    End;
end;

procedure TLevel3Form.Delay_3Timer(Sender: TObject);
begin
  if left_press = True then               //left
    Begin
      if (Location_3[j_pers,i_pers-1] = 0) or (Location_3[j_pers,i_pers-1] = 6) or (Location_3[j_pers,i_pers-1] = 7) or ((Location_3[j_pers,i_pers-1] = 3) and (not(Location_3[j_pers,i_pers-2] = 1) and not(Location_3[j_pers,i_pers-2] = 3))) then
        Begin
          if LookLeft = True then
            Begin
              case Animation of
                0: Pole_3[j_pers,i_pers].Picture.LoadFromFile(Player_Images_3[4]);
                6: Pole_3[j_pers,i_pers].Picture.LoadFromFile(Player_Images_3[5]);
                12: Pole_3[j_pers,i_pers].Picture.LoadFromFile(Player_Images_3[6]);
              end;
              Inc(Animation);
              if Animation > 12 then
                Animation := 0;
            End;
          if a = 0 then
            Begin
              if (Location_3[j_pers,i_pers-1] = 3) and (not(Location_3[j_pers,i_pers-2] = 1)) then
                Begin
                  Box := True;
                  if ((j_box1 = 4) and (i_box1-1 = 5)) or ((j_box2 = 5) and (i_box2-1 = 5)) then
                    Inc(count_box);
                  if ((j_box1 = 4) and (i_box1+1 = 5)) or ((j_box2 = 5) and (i_box2+1 = 5)) then
                    Dec(count_box);
                  if (i_pers-1 = i_box1) and (j_pers = j_box1) then
                    Dec(i_box1);
                  if (i_pers-1 = i_box2) and (j_pers = j_box2) then
                    Dec(i_box2);
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
              Inc(Step);
              Step_Label.Caption := IntToStr(Step);
              delay_3.Enabled := False;
              Already_Press := False;
            End;
        End;
    End;
  if up_press = True then                 //up
    Begin
      if (Location_3[j_pers-1,i_pers] = 0) or (Location_3[j_pers-1,i_pers] = 6) or (Location_3[j_pers-1,i_pers] = 7) or ((Location_3[j_pers-1,i_pers] = 3) and not(Location_3[j_pers-2,i_pers] = 1) and not(Location_3[j_pers-2,i_pers] = 3)) then
        Begin
          if LookDown = False then
            Begin
              case Animation of
                6: Pole_3[j_pers,i_pers].Picture.LoadFromFile(Player_Images_3[11]);
                12: Pole_3[j_pers,i_pers].Picture.LoadFromFile(Player_Images_3[12]);
              end;
              Inc(Animation);
              if Animation > 12 then
                Animation := 0;
            End;
          if a = 0 then
            Begin
              if (Location_3[j_pers-1,i_pers] = 3) and (not(Location_3[j_pers-2,i_pers] = 1)) then
                Begin
                  Box := True;
                  if ((j_box1-1 = 4) and (i_box1 = 5)) or ((j_box2-1 = 5) and (i_box2 = 5)) then
                    Inc(count_box);
                  if ((j_box1+1 = 4) and (i_box1 = 5)) or ((j_box2+1 = 5) and (i_box2 = 5)) then
                    Dec(count_box);
                  if (i_pers = i_box1) and (j_pers-1 = j_box1) then
                    Dec(j_box1);
                  if (i_pers = i_box2) and (j_pers-1 = j_box2) then
                    Dec(j_box2);
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
              Inc(Step);
              Step_Label.Caption := IntToStr(Step);
              delay_3.Enabled := False;
              Already_Press := False;
            End;
        End;
    End;
  if right_press = True then                    //right
    Begin
      if (Location_3[j_pers,i_pers+1] = 0) or (Location_3[j_pers,i_pers+1] = 6) or (Location_3[j_pers,i_pers+1] = 7) or ((Location_3[j_pers,i_pers+1] = 3) and not(Location_3[j_pers,i_pers+2] = 1) and not(Location_3[j_pers,i_pers+2] = 3)) then
        Begin
          if LookLeft = False then
            Begin
              case Animation of
                0: Pole_3[j_pers,i_pers].Picture.LoadFromFile(Player_Images_3[7]);
                6: Pole_3[j_pers,i_pers].Picture.LoadFromFile(Player_Images_3[8]);
                12: Pole_3[j_pers,i_pers].Picture.LoadFromFile(Player_Images_3[9]);
              end;
              Inc(Animation);
              if Animation > 12 then
                Animation := 0;
            End;
          if a = 0 then
            Begin
              if (Location_3[j_pers,i_pers+1] = 3) and (not(Location_3[j_pers,i_pers+2] = 1)) then
                Begin
                  Box := True;
                  if ((j_box1 = 4) and (i_box1+1 = 5)) or ((j_box2 = 5) and (i_box2+1 = 5)) then
                    Inc(count_box);
                  if ((j_box1 = 4) and (i_box1-1 = 5)) or ((j_box2 = 5) and (i_box2-1 = 5)) then
                    Dec(count_box);
                  if (i_pers+1 = i_box1) and (j_pers = j_box1) then
                    Inc(i_box1);
                  if (i_pers+1 = i_box2) and (j_pers = j_box2) then
                    Inc(i_box2);
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
            Begin
              buf := Location_3[j_pers,i_pers];
              Location_3[j_pers,i_pers] := 0;
              Location_3[j_pers,i_pers+1] := buf;
              Pole_3[j_pers,i_pers+1] := Pole_3[j_pers,i_pers];
              i_pers := i_pers + 1;
              dx := 0;
              Pole_3[j_pers,i_pers].Picture.LoadFromFile(Player_Images_3[1]);
              Box := False;
              Inc(Step);
              Step_Label.Caption := IntToStr(Step);
              delay_3.Enabled := False;
              Already_Press := False;
            End;
        End;
    End;
  if down_press = True then                 //down
    Begin
      if (Location_3[j_pers+1,i_pers] = 0) or (Location_3[j_pers+1,i_pers] = 6) or (Location_3[j_pers+1,i_pers] = 7) or ((Location_3[j_pers+1,i_pers] = 3) and not(Location_3[j_pers+2,i_pers] = 1) and not(Location_3[j_pers+2,i_pers] = 3)) then
        Begin
          if LookDown = True then
            Begin
              case Animation of
                6: Pole_3[j_pers,i_pers].Picture.LoadFromFile(Player_Images_3[2]);
                12: Pole_3[j_pers,i_pers].Picture.LoadFromFile(Player_Images_3[3]);
              end;
              Inc(Animation);
              if Animation > 12 then
                Animation := 0;
            End;
          if a = 0 then
            Begin
              if (Location_3[j_pers+1,i_pers] = 3) and (not(Location_3[j_pers+2,i_pers] = 1)) then
                Begin
                  Box := True;
                  if ((j_box1+1 = 4) and (i_box1 = 5)) or ((j_box2+1 = 5) and (i_box2 = 5)) then
                    Inc(count_box);
                  if ((j_box1-1 = 4) and (i_box1 = 5)) or ((j_box2-1 = 5) and (i_box2 = 5)) then
                    Dec(count_box);
                  if (i_pers = i_box1) and (j_pers+1 = j_box1) then
                    Inc(j_box1);
                  if (i_pers = i_box2) and (j_pers+1 = j_box2) then
                    Inc(j_box2);
                  buf := Location_3[j_pers+1,i_pers];
                  Location_3[j_pers+1,i_pers] := 0;
                  Location_3[j_pers+2,i_pers] := buf;
                  Pole_3[j_pers+2,i_pers] := Pole_3[j_pers+ 1,i_pers];
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
              Inc(Step);
              Step_Label.Caption := IntToStr(Step);
              delay_3.Enabled := False;
              Already_Press := False;
            End;
        End;
    End;
end;

procedure TLevel3Form.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure TLevel3Form.Construct;
var i, j: Integer;
begin
  Map_3 := TBitMap.Create;
  for i := 1 to n do
    for j := 1 to n do
      Begin
        Pole_3[j,i] := TImage.Create(Level3Form);
        Pole_3[j,i].Parent := Level3Form;
        Pole_3[j,i].Width := h;
        Pole_3[j,i].Height := h;
        Pole_3[j,i].Left := x0 + (i - 1) * h;
        Pole_3[j,i].Top := y0 + (j - 1) * h;
        Pole_3[j,i].Visible := False;
      End;

  for i := 1 to n do
    for j := 1 to n do
      Begin
        Bt_3[j,i] := TBitBtn.Create(Level3Form);
        Bt_3[j,i].Parent := Level3Form;
        Bt_3[j,i].Width := h;
        Bt_3[j,i].Height := h;
        Bt_3[j,i].Left := x0 + (j - 1) * h;
        Bt_3[j,i].Top := y0 + (i - 1) * h;
        Bt_3[j,i].Caption := '';
        Bt_3[j,i].Visible :=  False;
      End;

  Level3Form.Repaint;
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
          6:
             Begin
               Pole_3[j,i].Picture.LoadFromFile(Pole_Images_3[5]);
               Pole_3[j,i].Transparent := True;
               Pole_3[j,i].Visible := True;
             End;
          7:
             Begin
               Pole_3[j,i].Picture.LoadFromFile(Pole_Images_3[6]);
               Pole_3[j,i].Transparent := True;
               Pole_3[j,i].Visible := True;
               Pole_3[j,i].SendToBack;
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
  Pole_3[5,5].Picture.LoadFromFile('tochka_red.png');
  Seconds := 30;
  Minute := 1;
  i_box1 := 4;
  j_box1 := 3;
  i_box2 := 3;
  j_box2 := 4;
  count_stars := 3;
  Game_Time_3.Enabled := True;
end;

procedure TLevel3Form.Destroy;
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
  Location_3[5,2] := 6;
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

  FreeAndNil(Pole_3[j_pers,i_pers]);
  FreeAndNil(Pole_3[j_box1,i_box1]);
  FreeAndNil(Pole_3[j_box2,i_box2]);

  Game_Time_3.Enabled := False;
  dx := 0;
  dy := 0;
  count_box := 0;
  count_stars := 3;
  Minute := 1;
  Seconds := 30;
  Step := 0;
  Teleport_using := False;
  Auto_using := False;
  Teleport_On := False;
  Time_3.Caption := '1:30';
  Star1_3.Visible := True;
  Star2_3.Visible := True;
  Star3_3.Visible := True;
  Step_Label.Caption := '0';
  Label7.Font.Color := clHighlight;
  Label8.Font.Color := clHighlight;
  Label6.Caption := '';
end;

procedure TLevel3Form.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 27 then
    Begin
      if Already_Press = False then
        Begin
          Destroy;
          Level3Form.Hide;
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
          delay_3.Enabled := True;
          Label6.Caption := '';
          if not(Location_3[j_pers,i_pers-1]=1) and not(Location_3[j_pers,i_pers-1]=2) and not((Location_3[j_pers,i_pers-1]=3)and(Location_3[j_pers,i_pers-2]=1)) and not((Location_3[j_pers,i_pers-1]=3)and(Location_3[j_pers,i_pers-2]=3)) then
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
          delay_3.Enabled := True;
          Label6.Caption := '';
          if not(Location_3[j_pers-1,i_pers]=1) and not(Location_3[j_pers-1,i_pers]=2) and not((Location_3[j_pers-1,i_pers]=3)and(Location_3[j_pers-2,i_pers]=1)) and not((Location_3[j_pers-1,i_pers]=3)and(Location_3[j_pers-2,i_pers]=3)) then
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
          delay_3.Enabled := True;
          Label6.Caption := '';
          if not(Location_3[j_pers,i_pers+1]=1) and not(Location_3[j_pers,i_pers+1]=2) and not((Location_3[j_pers,i_pers+1]=3)and(Location_3[j_pers,i_pers+2]=1)) and not((Location_3[j_pers,i_pers+1]=3)and(Location_3[j_pers,i_pers+2]=3)) then
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
          delay_3.Enabled := True;
          Label6.Caption := '';
          if not(Location_3[j_pers+1,i_pers]=1) and not(Location_3[j_pers+1,i_pers]=2) and not((Location_3[j_pers+1,i_pers]=3)and(Location_3[j_pers+2,i_pers]=1)) and not((Location_3[j_pers+1,i_pers]=3)and(Location_3[j_pers+2,i_pers]=3)) then
            Already_Press := True;
        End;
    End;
  if Key = 49 then   //press 1
    Begin
      if Teleport_On = True then
        Begin
          dx_steps := i_pers;
          dy_steps := j_pers;
          Pole_3[j_pers,i_pers].Destroy;
          Press_1 := True;
          Label6.Caption := '????????????...';
          Teleport_Time_3.Enabled := True;
        End;
    End;
  if Key = 50 then  //press 2
    Begin
      if Teleport_On = True then
        Begin
          dx_steps := i_pers;
          dy_steps := j_pers;
          Pole_3[j_pers,i_pers].Destroy;
          Press_2 := True;
          Label6.Caption := '????????????...';
          Teleport_Time_3.Enabled := True;
        End;
    End;
  if Key = 13 then
    Begin
      if Already_Press = False then
        Begin
          if Level3_Up = True then
            Begin
              Destroy;
              Level3Form.Hide;
              Level4Form.Construct;
              Level4Form.Game_Time_4.Enabled := True;
              Level4Form.Show;
            End;
        End;
    End;
end;

procedure TLevel3Form.Game_Time_3Timer(Sender: TObject);
begin
  if count_box = 2 then
    Begin
      Game_Time_3.Enabled := False;
      Level3_Up := True;
      Label6.Caption := '??? ????? ???????????! ??????? ENTER, ????? ??????????.';
    End;
  Dec(Seconds);
  if Seconds > 9 then Time_3.Caption := IntToStr(Minute) + ':' + IntToStr(Seconds)
  else Time_3.Caption := IntToStr(Minute) + ':0' + IntToStr(Seconds);
  if (Seconds = 0) and (Minute > 0) then
    Begin
      Dec(Minute);
      Seconds := 60;
    End;
  if Step = 30 then
    Begin
      Dec(count_stars);
      Star3_3.Visible := False;
    End;
  if Step = 31 then
    Begin
      Dec(count_stars);
      Star2_3.Visible := False;
    End;
  if Step = 32 then
    Begin
      Dec(count_stars);
      Star1_3.Visible := False;
    End;
  if (Seconds = 0) and (Minute = 0) then
    Begin
      Game_Time_3.Enabled := False;
      ShowMessage('????? ?????! ?? ?????????!');
      Destroy;
      Level3Form.Hide;
      MenuForm.Show;
    End;
end;

procedure TLevel3Form.Teleport_3Click(Sender: TObject);
begin
  if Teleport_using = True then
    Teleport_Time_3.Enabled := True
  else
    Begin
      Teleport_On := True;
      Label6.Caption := '??? ?????? ?????????? ???????? ????? ???????, ?? ??????? ?? ?????? ?????????????.';
    End;
end;

procedure TLevel3Form.Teleport_Time_3Timer(Sender: TObject);
begin
  if Teleport_using = True then
    Begin
      Label6.Caption := '?? ??? ???????????? ????????????!';
      Teleport_Time_3.Enabled := False;
    End;
  if Press_1 = True then
    Begin
      if dx_steps < 2 then
        Begin
          dx := dx + 5;
          if dx = h then
            Begin
              Inc(dx_steps);
              dx := 0;
            End;
        End;
      if dx_steps > 2 then
        Begin
          dx := dx - 5;
          if dx = -h then
            Begin
              Dec(dx_steps);
              dx := 0;
            End;
        End;
      if dy_steps < 5 then
        Begin
          dy := dy + 5;
          if dy = h then
            Begin
              Inc(dy_steps);
              dy := 0;
            End;
        End;
      if dy_steps > 5 then
        Begin
          dy := dy - 1;
          if dy = -h then
            Begin
              Dec(dy_steps);
              dy := 0;
            End;
        End;
      if (dx_steps = 2) and (dy_steps = 5) then
        Begin
          buf := Location_3[j_pers,i_pers];
          Location_3[j_pers,i_pers] := 0;
          Location_3[dy_steps,dx_steps] := buf;
          i_pers := dx_steps;
          j_pers := dy_steps;
          Teleport_Time_3.Enabled := False;
          Teleport_On := False;
          Teleport_using := True;
          Pole_3[j_pers,i_pers].Picture.LoadFromFile(Player_Images_3[1]);
          Pole_3[3,6].SendToBack;
          Press_1 := False;
          Label6.Caption := '';
          Label7.Font.Color := clRed;
        End;
    End;
end;

end.
