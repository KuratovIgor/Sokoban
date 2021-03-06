unit Unit7;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons;

type
  TLevel2Form = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Step_Label: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Star1_2: TImage;
    Star2_2: TImage;
    Star3_2: TImage;
    Teleport_2: TImage;
    Auto_2: TImage;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Time_2: TLabel;
    Teleport_Time_2: TTimer;
    Delay_2: TTimer;
    Game_Time_2: TTimer;
    Pole1: TImage;
    Pole4: TImage;
    Pole7: TImage;
    Pole8: TImage;
    Pole5: TImage;
    Pole6: TImage;
    Pole2: TImage;
    Pole3: TImage;
    Pole9: TImage;
    Label2: TLabel;
    Pole10: TImage;
    Again_2: TImage;
    Label9: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Delay_2Timer(Sender: TObject);
    procedure Game_Time_2Timer(Sender: TObject);
    procedure Teleport_2Click(Sender: TObject);
    procedure Teleport_Time_2Timer(Sender: TObject);
    procedure Auto_2Click(Sender: TObject);
    procedure Construct;
    procedure Destroy;
    procedure Again_2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
       count_pers = 12;
       count_pole = 6;
       n = 7;
       h = 65;
       x0 = 425;
       y0 = 130;

var Location_2: array [1..n,1..n] of Integer =                           //1 - ?????
                                               ((5,1,1,1,5,5,5),        //2 - ????? ??? ?????
                                                (1,1,2,1,1,1,1),       //3 - ????
                                                (1,2,3,3,4,7,1),      //4 - ????????
                                                (1,1,0,0,0,1,1),     //5 - ????????? ??????? ???????
                                                (5,1,6,1,1,1,5),    //6 - ????????_1
                                                (5,1,1,1,5,5,5),   //7 - ????????_2
                                                (5,5,5,5,5,5,5));

const Player_Images_2: array [1..count_pers] of String = ('staydown.png','down1.png','down2.png',
'stayleft.png','left1.png','left2.png','stayright.png','right1.png','right2.png',
'stayup.png','up1.png','up2.png');

const Pole_Images_2: array [1..count_pole] of String = ('brown_wall.png','ground_green.png',
'crate_red.png','tochka_red.png','teleport_ground_gr.png','teleport_ground_gr2.png');

var
  Level2Form: TLevel2Form;
  Pole_2: array [1..n,1..n] of TImage;
  Bt_2: array [1..n,1..n] of TBitBtn;
  Map_2: TBitMap;
  i_pers, j_pers, dy, dx, buf, a, count_box, Seconds, Animation, Step, count_stars,
  dx_steps, dy_steps, buf_tel, i_box1, j_box1, i_box2, j_box2: Integer;
  down_press, up_press, right_press, left_press, Box, LookLeft, LookDown, Teleport_On,
  Auto_On, Press_1, Press_2, Teleport_using, Auto_using, Level2_Up, Already_Press: Boolean;

implementation

{$R *.dfm}

uses Unit2, Unit8, Unit9;

procedure TLevel2Form.Again_2Click(Sender: TObject);
begin
  Destroy;
  Construct;
end;

procedure TLevel2Form.Auto_2Click(Sender: TObject);
begin
  if Auto_using = False then
    Begin
      Auto_On := True;
      Game_Time_2.Enabled := False;
      Auto_2Form.Auto_Time_2.Enabled := True;
      Auto_2Form.Show;
      Auto_2Form.Construct;
      Label6.Font.Color := clRed;
      Auto_using := True;
    End
  else
    Begin
      Label2.Caption := '?? ??? ???????????? ???????????????!'
    End;
end;

procedure TLevel2Form.Delay_2Timer(Sender: TObject);
begin
  if left_press = True then               //left
    Begin
      if (Location_2[j_pers,i_pers-1] = 0) or (Location_2[j_pers,i_pers-1] = 6) or (Location_2[j_pers,i_pers-1] = 7) or ((Location_2[j_pers,i_pers-1] = 3) and (not(Location_2[j_pers,i_pers-2] = 1) and not(Location_2[j_pers,i_pers-2] = 3))) then
        Begin
          if LookLeft = True then
            Begin
              case Animation of
                0: Pole_2[j_pers,i_pers].Picture.LoadFromFile(Player_Images_2[4]);
                6: Pole_2[j_pers,i_pers].Picture.LoadFromFile(Player_Images_2[5]);
                12: Pole_2[j_pers,i_pers].Picture.LoadFromFile(Player_Images_2[6]);
              end;
              Inc(Animation);
              if Animation > 12 then
                Animation := 0;
            End;
          if a = 0 then
            Begin
              if (Location_2[j_pers,i_pers-1] = 3) and (not(Location_2[j_pers,i_pers-2] = 1)) then
                Begin
                  Box := True;
                  if Location_2[j_pers,i_pers-2] = 2 then
                    Inc(count_box);
                  if (i_pers-1 = i_box1) and (j_pers = j_box1) then
                    Dec(i_box1);
                  if (i_pers-1 = i_box2) and (j_pers = j_box2) then
                    Dec(i_box2);
                  buf := Location_2[j_pers,i_pers-1];
                  Location_2[j_pers,i_pers-1] := 0;
                  Location_2[j_pers,i_pers-2] := buf;
                  Pole_2[j_pers,i_pers-2] := Pole_2[j_pers,i_pers-1];
                  Inc(a);
                End;
            End;
          if Box = True then
            Begin
              Pole_2[j_pers,i_pers-1].Left := Pole_2[j_pers,i_pers-1].Left - 1;
            End;

          Pole_2[j_pers,i_pers].Left := Pole_2[j_pers,i_pers].Left - 1;
          dx := dx - 1;
          if dx = -h then
            Begin;
              buf := Location_2[j_pers,i_pers];
              Location_2[j_pers,i_pers] := 0;
              Location_2[j_pers,i_pers-1] := buf;
              Pole_2[j_pers,i_pers-1] := Pole_2[j_pers,i_pers];
              i_pers := i_pers - 1;
              dx := 0;
              Pole_2[j_pers,i_pers].Picture.LoadFromFile(Player_Images_2[1]);
              Box := False;
              Inc(Step);
              Step_Label.Caption := IntToStr(Step);
              delay_2.Enabled := False;
              Already_Press := False;
            End;
        End;
    End;
  if up_press = True then                 //up
    Begin
      if (Location_2[j_pers-1,i_pers] = 0) or (Location_2[j_pers-1,i_pers] = 6) or (Location_2[j_pers-1,i_pers] = 7) or ((Location_2[j_pers-1,i_pers] = 3) and not(Location_2[j_pers-2,i_pers] = 1)) then
        Begin
          if LookDown = False then
            Begin
              case Animation of
                6: Pole_2[j_pers,i_pers].Picture.LoadFromFile(Player_Images_2[11]);
                12: Pole_2[j_pers,i_pers].Picture.LoadFromFile(Player_Images_2[12]);
              end;
              Inc(Animation);
              if Animation > 12 then
                Animation := 0;
            End;
          if a = 0 then
            Begin
              if (Location_2[j_pers-1,i_pers] = 3) and (not(Location_2[j_pers-2,i_pers] = 1)) then
                Begin
                  Box := True;
                  if Location_2[j_pers-2,i_pers] = 2 then
                    Inc(count_box);
                  if (i_pers = i_box1) and (j_pers-1 = j_box1) then
                    Dec(j_box1);
                  if (i_pers = i_box2) and (j_pers-1 = j_box2) then
                    Dec(j_box2);
                  buf := Location_2[j_pers-1,i_pers];
                  Location_2[j_pers-1,i_pers] := 0;
                  Location_2[j_pers-2,i_pers] := buf;
                  Pole_2[j_pers-2,i_pers] := Pole_2[j_pers-1,i_pers];
                  Inc(a);
                End;
            End;
          if Box = True then
            Begin
              Pole_2[j_pers-1,i_pers].Top := Pole_2[j_pers-1,i_pers].Top - 1;
            End;
          Pole_2[j_pers,i_pers].Top := Pole_2[j_pers,i_pers].Top - 1;
          dy := dy - 1;
          if dy = -h then
            Begin
              buf := Location_2[j_pers,i_pers];
              Location_2[j_pers,i_pers] := 0;
              Location_2[j_pers-1,i_pers] := buf;
              Pole_2[j_pers-1,i_pers] := Pole_2[j_pers,i_pers];
              j_pers := j_pers - 1;
              dy := 0;
              Pole_2[j_pers,i_pers].Picture.LoadFromFile(Player_Images_2[1]);
              Box := False;
              Inc(Step);
              Step_Label.Caption := IntToStr(Step);
              delay_2.Enabled := False;
              Already_Press := False;
            End;
        End;
    End;
  if right_press = True then                    //right
    Begin
      if (Location_2[j_pers,i_pers+1] = 0) or (Location_2[j_pers,i_pers+1] = 6) or (Location_2[j_pers,i_pers+1] = 7) or ((Location_2[j_pers,i_pers+1] = 3) and not(Location_2[j_pers,i_pers+2] = 1)) then
        Begin
          if LookLeft = False then
            Begin
              case Animation of
                0: Pole_2[j_pers,i_pers].Picture.LoadFromFile(Player_Images_2[7]);
                6: Pole_2[j_pers,i_pers].Picture.LoadFromFile(Player_Images_2[8]);
                12: Pole_2[j_pers,i_pers].Picture.LoadFromFile(Player_Images_2[9]);
              end;
              Inc(Animation);
              if Animation > 12 then
                Animation := 0;
            End;
          if a = 0 then
            Begin
              if (Location_2[j_pers,i_pers+1] = 3) and (not(Location_2[j_pers,i_pers+2] = 1)) then
                Begin
                  Box := True;
                  if Location_2[j_pers,i_pers+2] = 2 then
                    Inc(count_box);
                  if (i_pers+1 = i_box1) and (j_pers = j_box1) then
                    Inc(i_box1);
                  if (i_pers+1 = i_box2) and (j_pers = j_box2) then
                    Inc(i_box2);
                  buf := Location_2[j_pers,i_pers+1];
                  Location_2[j_pers,i_pers+1] := 0;
                  Location_2[j_pers,i_pers+2] := buf;
                  Pole_2[j_pers,i_pers+2] := Pole_2[j_pers,i_pers+1];
                  Inc(a);
                End;
            End;
          if Box = True then
            Begin
              Pole_2[j_pers,i_pers+1].Left := Pole_2[j_pers,i_pers+1].Left + 1;
            End;
          Pole_2[j_pers,i_pers].Left := Pole_2[j_pers,i_pers].Left + 1;
          dx := dx + 1;
          if dx = h then
            Begin
              buf := Location_2[j_pers,i_pers];
              Location_2[j_pers,i_pers] := 0;
              Location_2[j_pers,i_pers+1] := buf;
              Pole_2[j_pers,i_pers+1] := Pole_2[j_pers,i_pers];
              i_pers := i_pers + 1;
              dx := 0;
              Pole_2[j_pers,i_pers].Picture.LoadFromFile(Player_Images_2[1]);
              Box := False;
              Inc(Step);
              Step_Label.Caption := IntToStr(Step);
              delay_2.Enabled := False;
              Already_Press := False;
            End;
        End;
    End;
  if down_press = True then                 //down
    Begin
      if (Location_2[j_pers+1,i_pers] = 0) or (Location_2[j_pers+1,i_pers] = 6) or (Location_2[j_pers+1,i_pers] = 7) or ((Location_2[j_pers+1,i_pers] = 3) and not(Location_2[j_pers+2,i_pers] = 1)) then
        Begin
          if LookDown = True then
            Begin
              case Animation of
                6: Pole_2[j_pers,i_pers].Picture.LoadFromFile(Player_Images_2[2]);
                12: Pole_2[j_pers,i_pers].Picture.LoadFromFile(Player_Images_2[3]);
              end;
              Inc(Animation);
              if Animation > 12 then
                Animation := 0;
            End;
          if a = 0 then
            Begin
              if (Location_2[j_pers+1,i_pers] = 3) and (not(Location_2[j_pers+2,i_pers] = 1)) then
                Begin
                  Box := True;
                  if Location_2[j_pers+2,i_pers] = 2 then
                    Inc(count_box);
                  if (i_pers = i_box1) and (j_pers+1 = j_box1) then
                    Inc(j_box1);
                  if (i_pers = i_box2) and (j_pers+1 = j_box2) then
                    Inc(j_box2);
                  buf := Location_2[j_pers+1,i_pers];
                  Location_2[j_pers+1,i_pers] := 0;
                  Location_2[j_pers+2,i_pers] := buf;
                  Pole_2[j_pers-2,i_pers] := Pole_2[j_pers-1,i_pers];
                  Inc(a);
                End;
            End;
          if Box = True then
            Begin
              Pole_2[j_pers+1,i_pers].Top := Pole_2[j_pers+1,i_pers].Top + 1;
            End;
          Pole_2[j_pers,i_pers].Top := Pole_2[j_pers,i_pers].Top + 1;
          dy := dy + 1;
          if dy = h then
            Begin
              buf := Location_2[j_pers,i_pers];
              Location_2[j_pers,i_pers] := 0;
              Location_2[j_pers+1,i_pers] := buf;
              Pole_2[j_pers+1,i_pers] := Pole_2[j_pers,i_pers];
              j_pers := j_pers + 1;
              dy := 0;
              Pole_2[j_pers,i_pers].Picture.LoadFromFile(Player_Images_2[1]);
              Box := False;
              Inc(Step);
              Step_Label.Caption := IntToStr(Step);
              delay_2.Enabled := False;
              Already_Press := False;
            End;
        End;
    End;
end;


procedure TLevel2Form.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure TLevel2Form.Construct;
var i, j: Integer;
begin
  Map_2 := TBitMap.Create;
  for i := 1 to n do
    for j := 1 to n do
      Begin
        Pole_2[j,i] := TImage.Create(Level2Form);
        Pole_2[j,i].Parent := Level2Form;
        Pole_2[j,i].Width := h;
        Pole_2[j,i].Height := h;
        Pole_2[j,i].Left := x0 + (i - 1) * h;
        Pole_2[j,i].Top := y0 + (j - 1) * h;
        Pole_2[j,i].Visible := False;
      End;

  for i := 1 to n do
    for j := 1 to n do
      Begin
        Bt_2[j,i] := TBitBtn.Create(Level2Form);
        Bt_2[j,i].Parent := Level2Form;
        Bt_2[j,i].Width := h;
        Bt_2[j,i].Height := h;
        Bt_2[j,i].Left := x0 + (j - 1) * h;
        Bt_2[j,i].Top := y0 + (i - 1) * h;
        Bt_2[j,i].Caption := '';
        Bt_2[j,i].Visible :=  False;
      End;

  Level2Form.Repaint;
  for i := 1 to n do
    for j := 1 to n do
      Begin
        Bt_2[j,i].Hide;
      End;

  for i := 1 to n do
    for j := 1 to n do
      Begin
        case Location_2[j,i] of
          1:
             Begin
               Pole_2[j,i].Picture.LoadFromFile(Pole_Images_2[1]);
               Pole_2[j,i].Transparent := True;
               Pole_2[j,i].Visible := True;
             End;
          2:
             Begin
               Pole_2[j,i].Picture.LoadFromFile(Pole_Images_2[4]);
               Pole_2[j,i].Transparent := True;
               Pole_2[j,i].Visible := True;
             End;
          3:
             Begin
               Pole_2[j,i].Picture.LoadFromFile(Pole_Images_2[3]);
               Pole_2[j,i].Transparent := True;
               Pole_2[j,i].Visible := True;
             End;
          4:
             Begin
               i_pers := i;
               j_pers := j;
               dy := 0;
               dx := 0;
               Pole_2[j,i].Picture.LoadFromFile(Player_Images_2[1]);
               Pole_2[j,i].Transparent := True;
               Pole_2[j,i].Visible := True;
             End;
          6:
             Begin
               Pole_2[j,i].Picture.LoadFromFile(Pole_Images_2[5]);
               Pole_2[j,i].Transparent := True;
               Pole_2[j,i].Visible := True;
             End;
          7:
             Begin
               Pole_2[j,i].Picture.LoadFromFile(Pole_Images_2[6]);
               Pole_2[j,i].Transparent := True;
               Pole_2[j,i].Visible := True;
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
  i_box1 := 3;
  j_box1 := 3;
  i_box2 := 4;
  j_box2 := 3;
  Seconds := 60;
  count_stars := 3;
  Game_Time_2.Enabled := True;
end;

procedure TLevel2Form.Destroy;
var i, j: Integer;
begin
  Location_2[1,1] := 5;
  Location_2[1,2] := 1;
  Location_2[1,3] := 1;
  Location_2[1,4] := 1;
  Location_2[1,5] := 5;
  Location_2[1,6] := 5;
  Location_2[1,7] := 5;
  Location_2[2,1] := 1;
  Location_2[2,2] := 1;
  Location_2[2,3] := 2;
  Location_2[2,4] := 1;
  Location_2[2,5] := 1;
  Location_2[2,6] := 1;
  Location_2[2,7] := 1;
  Location_2[3,1] := 1;
  Location_2[3,2] := 2;
  Location_2[3,3] := 3;
  Location_2[3,4] := 3;
  Location_2[3,5] := 4;
  Location_2[3,6] := 7;
  Location_2[3,7] := 1;
  Location_2[4,1] := 1;
  Location_2[4,2] := 1;
  Location_2[4,3] := 0;
  Location_2[4,4] := 0;
  Location_2[4,5] := 0;
  Location_2[4,6] := 1;
  Location_2[4,7] := 1;
  Location_2[5,1] := 5;
  Location_2[5,2] := 1;
  Location_2[5,3] := 6;
  Location_2[5,4] := 1;
  Location_2[5,5] := 1;
  Location_2[5,6] := 1;
  Location_2[5,7] := 5;
  Location_2[6,1] := 5;
  Location_2[6,2] := 1;
  Location_2[6,3] := 1;
  Location_2[6,4] := 1;
  Location_2[6,5] := 5;
  Location_2[6,6] := 5;
  Location_2[6,7] := 5;
  Location_2[7,1] := 5;
  Location_2[7,2] := 5;
  Location_2[7,3] := 5;
  Location_2[7,4] := 5;
  Location_2[7,5] := 5;
  Location_2[7,6] := 5;
  Location_2[7,7] := 5;



  FreeAndNil(Pole_2[j_pers,i_pers]);
  FreeAndNil(Pole_2[j_box1,i_box1]);
  FreeAndNil(Pole_2[j_box2,i_box2]);

  Game_Time_2.Enabled := False;
  dx := 0;
  dy := 0;
  count_box := 0;
  count_stars := 3;
  Seconds := 60;
  Step := 0;
  Teleport_using := False;
  Auto_using := False;
  Teleport_On := False;
  Time_2.Caption := '1:00';
  Star1_2.Visible := True;
  Star2_2.Visible := True;
  Star3_2.Visible := True;
  Step_Label.Caption := '0';
  Label5.Font.Color := clHighlight;
  Label6.Font.Color := clHighlight;
  Label2.Caption := '';
end;

procedure TLevel2Form.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 27 then
    Begin
      if Already_Press = False then
        Begin
          Destroy;
          Level2Form.Hide;
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
          delay_2.Enabled := True;
          Label2.Caption := '';
          if not(Location_2[j_pers,i_pers-1]=1) and not(Location_2[j_pers,i_pers-1]=2) and not((Location_2[j_pers,i_pers-1]=3)and(Location_2[j_pers,i_pers-2]=1)) and not((Location_2[j_pers,i_pers-1]=3)and(Location_2[j_pers,i_pers-2]=3)) then

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
          delay_2.Enabled := True;
          Label2.Caption := '';
          if not(Location_2[j_pers-1,i_pers]=1) and not(Location_2[j_pers-1,i_pers]=2) and not((Location_2[j_pers-1,i_pers]=3)and(Location_2[j_pers-2,i_pers]=1)) and not((Location_2[j_pers-1,i_pers]=3)and(Location_2[j_pers-2,i_pers]=3)) then
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
          delay_2.Enabled := True;
          Label2.Caption := '';
          if not(Location_2[j_pers,i_pers+1]=1) and not(Location_2[j_pers,i_pers+1]=2) and not((Location_2[j_pers,i_pers+1]=3)and(Location_2[j_pers,i_pers+2]=1)) and not((Location_2[j_pers,i_pers+1]=3)and(Location_2[j_pers,i_pers+2]=3)) then
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
          delay_2.Enabled := True;
          Label2.Caption := '';
          if not(Location_2[j_pers+1,i_pers]=1) and not(Location_2[j_pers+1,i_pers]=2) and not((Location_2[j_pers+1,i_pers]=3)and(Location_2[j_pers+2,i_pers]=1)) and not((Location_2[j_pers+1,i_pers]=3)and(Location_2[j_pers+2,i_pers]=3)) then
            Already_Press := True;
        End;
    End;
  if Key = 49 then   //press 1
    Begin
      if Teleport_On = True then
        Begin
          dx_steps := i_pers;
          dy_steps := j_pers;
          Pole_2[j_pers,i_pers].Destroy;
          Press_1 := True;
          Label2.Caption := '????????????...';
          Teleport_Time_2.Enabled := True;
        End;
    End;
  if Key = 50 then  //press 2
    Begin
      if Teleport_On = True then
        Begin
          dx_steps := i_pers;
          dy_steps := j_pers;
          Pole_2[j_pers,i_pers].Destroy;
          Press_2 := True;
          Label2.Caption := '????????????...';
          Teleport_Time_2.Enabled := True;
        End;
    End;
  if Key = 13 then
    Begin
      if Already_Press = False then
        Begin
          if Level2_Up = True then
            Begin
              Destroy;
              Level2Form.Hide;
              Level3Form.Construct;
              Level3Form.Game_Time_3.Enabled := True;
              Level3Form.Show;
            End;
        End;
    End;
end;

procedure TLevel2Form.Game_Time_2Timer(Sender: TObject);
begin
  if count_box = 2 then
    Begin
      Game_Time_2.Enabled := False;
      Level2_Up := True;
      Label2.Caption := '??? ????? ???????????! ??????? ENTER, ????? ??????????.';
    End;
  Dec(Seconds);
  if Seconds > 9 then Time_2.Caption := '0:' + IntToStr(Seconds)
  else Time_2.Caption := '0:0' + IntToStr(Seconds);
  if Step = 11 then
    Begin
      Dec(count_stars);
      Star3_2.Visible := False;
    End;
  if Step = 12 then
    Begin
      Dec(count_stars);
      Star2_2.Visible := False;
    End;
  if Step = 13 then
    Begin
      Dec(count_stars);
      Star1_2.Visible := False;
    End;
  if Seconds = 0 then
    Begin
      Game_Time_2.Enabled := False;
      ShowMessage('????? ?????! ?? ?????????!');
      Destroy;
      Level2Form.Hide;
      MenuForm.Show;
    End;
end;

procedure TLevel2Form.Teleport_2Click(Sender: TObject);
begin
  if Teleport_using = True then
    Teleport_Time_2.Enabled := True
  else
    Begin
      Teleport_On := True;
      Label2.Caption := '??? ?????? ?????????? ???????? ????? ???????, ?? ??????? ?? ?????? ?????????????.';
    End;
end;

procedure TLevel2Form.Teleport_Time_2Timer(Sender: TObject);
begin
  if Teleport_using = True then
    Begin
      Label2.Caption := '?? ??? ???????????? ????????????!';
      Teleport_Time_2.Enabled := False;
    End;
  if Press_1 = True then
    Begin
      if dx_steps < 3 then
        Begin
          dx := dx + 5;
          if dx = h then
            Begin
              Inc(dx_steps);
              dx := 0;
            End;
        End;
      if dx_steps > 3 then
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
          dy := dy - 5;
          if dy = -h then
            Begin
              Dec(dy_steps);
              dy := 0;
            End;
        End;
      if (dx_steps = 3) and (dy_steps = 5) then
        Begin
          buf := Location_2[j_pers,i_pers];
          Location_2[j_pers,i_pers] := 0;
          Location_2[dy_steps,dx_steps] := buf;
          i_pers := dx_steps;
          j_pers := dy_steps;
          Teleport_Time_2.Enabled := False;
          Teleport_On := False;
          Teleport_using := True;
          Pole_2[j_pers,i_pers].Picture.LoadFromFile(Player_Images_2[1]);
          Pole_2[3,6].SendToBack;
          Press_1 := False;
          Label2.Caption := '';
          Label5.Font.Color := clRed;
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
      if dy_steps < 3 then
        Begin
          dy := dy + 5;
          if dy = h then
            Begin
              Inc(dy_steps);
              dy := 0;
            End;
        End;
      if dy_steps > 3 then
        Begin
          dy := dy - 5;
          if dy = -h then
            Begin
              Dec(dy_steps);
              dy := 0;
            End;
        End;
      if (dx_steps = 6) and (dy_steps = 3) then
        Begin
          buf := Location_2[j_pers,i_pers];
          Location_2[j_pers,i_pers] := 0;
          Location_2[dy_steps,dx_steps] := buf;
          i_pers := dx_steps;
          j_pers := dy_steps;
          Teleport_Time_2.Enabled := False;
          Teleport_On := False;
          Teleport_using := True;
          Pole_2[j_pers,i_pers].Picture.LoadFromFile(Player_Images_2[1]);
          Pole_2[5,3].SendToBack;
          Press_2 := False;
          Label2.Caption := '';
          Label5.Font.Color := clRed;
        End;
    End;
end;

end.
