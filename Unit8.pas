unit Unit8;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage;

type
  TAuto_2Form = class(TForm)
    Pole9: TImage;
    Pole6: TImage;
    Pole4: TImage;
    Pole5: TImage;
    Pole8: TImage;
    Pole3: TImage;
    Pole7: TImage;
    Pole2: TImage;
    Pole1: TImage;
    Auto_Time_2: TTimer;
    Pole10: TImage;
    procedure Auto_Time_2Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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
       n = 7;
       h = 65;
       x0 = 0;
       y0 = 0;
                                                                          //0 - пустой участок
var Location_2: array [1..n,1..n] of Integer =                           //1 - стена
                                               ((5,1,1,1,5,5,5),        //2 - место для ящика
                                                (1,1,2,1,1,1,1),       //3 - ящик
                                                (1,2,3,3,4,0,1),      //4 - персонаж
                                                (1,1,0,0,0,1,1),     //5 - невидимый участок массива
                                                (5,1,0,1,1,1,5),
                                                (5,1,1,1,5,5,5),
                                                (5,5,5,5,5,5,5));

const Player_Images_2: array [1..count_pers] of String = ('staydown.png','down1.png','down2.png',
'stayleft.png','left1.png','left2.png','stayright.png','right1.png','right2.png',
'stayup.png','up1.png','up2.png');

const Pole_Images_2: array [1..count_pole] of String = ('brown_wall.png','ground_green.png',
'crate_red.png','tochka_red.png');

var
  Auto_2Form: TAuto_2Form;
  Pole_2: array [1..n,1..n] of TImage;
  Bt_2: array [1..n,1..n] of TBitBtn;
  Map_2: TBitMap;
  i_pers, j_pers, dy, dx, buf, a, Animation, steps: Integer;
  Box: Boolean;

implementation

{$R *.dfm}

uses Unit7;

procedure TAuto_2Form.Auto_Time_2Timer(Sender: TObject);
begin
  case steps of
  0:
     Begin
       if (Location_2[j_pers+1,i_pers] = 0) then
        Begin
          case Animation of
            6: Pole_2[j_pers,i_pers].Picture.LoadFromFile(Player_Images_2[2]);
            12: Pole_2[j_pers,i_pers].Picture.LoadFromFile(Player_Images_2[3]);
          end;
          Inc(Animation);
          if Animation > 12 then
            Animation := 0;
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
              Inc(steps);
            End;
        End;
     End;
  1,2:
     Begin
       if (Location_2[j_pers,i_pers-1] = 0) then
        Begin
          case Animation of
            0: Pole_2[j_pers,i_pers].Picture.LoadFromFile(Player_Images_2[4]);
            6: Pole_2[j_pers,i_pers].Picture.LoadFromFile(Player_Images_2[5]);
            12: Pole_2[j_pers,i_pers].Picture.LoadFromFile(Player_Images_2[6]);
          end;
          Inc(Animation);
          if Animation > 12 then
          Animation := 0;

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
              Inc(steps);
            End;
        End;
     End;
  3:
     Begin
       if (Location_2[j_pers-1,i_pers] = 0) or ((Location_2[j_pers-1,i_pers] = 3) and not(Location_2[j_pers-2,i_pers] = 1)) then
        Begin
          case Animation of
            6: Pole_2[j_pers,i_pers].Picture.LoadFromFile(Player_Images_2[11]);
            12: Pole_2[j_pers,i_pers].Picture.LoadFromFile(Player_Images_2[12]);
          end;
          Inc(Animation);
          if Animation > 12 then
            Animation := 0;
          if a = 0 then
            Begin
              if (Location_2[j_pers-1,i_pers] = 3) and (not(Location_2[j_pers-2,i_pers] = 1)) then
                Begin
                  Box := True;
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
              a := 0;
              Inc(steps);
            End;
        End;
     End;
  4:
     Begin
       if (Location_2[j_pers+1,i_pers] = 0) then
        Begin
          case Animation of
            6: Pole_2[j_pers,i_pers].Picture.LoadFromFile(Player_Images_2[2]);
            12: Pole_2[j_pers,i_pers].Picture.LoadFromFile(Player_Images_2[3]);
          end;
          Inc(Animation);
          if Animation > 12 then
            Animation := 0;
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
              Inc(steps);
            End;
        End;
     End;
  5,6:
     Begin
       if (Location_2[j_pers,i_pers+1] = 0) then
        Begin
        case Animation of
          0: Pole_2[j_pers,i_pers].Picture.LoadFromFile(Player_Images_2[7]);
          6: Pole_2[j_pers,i_pers].Picture.LoadFromFile(Player_Images_2[8]);
          12: Pole_2[j_pers,i_pers].Picture.LoadFromFile(Player_Images_2[9]);
        end;
        Inc(Animation);
        if Animation > 12 then
          Animation := 0;
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
            Inc(steps);
          End;
        End;
     End;
  7:
     Begin
       if (Location_2[j_pers-1,i_pers] = 0) then
        Begin
          case Animation of
            6: Pole_2[j_pers,i_pers].Picture.LoadFromFile(Player_Images_2[11]);
            12: Pole_2[j_pers,i_pers].Picture.LoadFromFile(Player_Images_2[12]);
          end;
          Inc(Animation);
          if Animation > 12 then
            Animation := 0;
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
              Inc(steps);
            End;
        End;
     End;
  8,9:
     Begin
       if (Location_2[j_pers,i_pers-1] = 0) or ((Location_2[j_pers,i_pers-1] = 3) and (not(Location_2[j_pers,i_pers-2] = 1) and not(Location_2[j_pers,i_pers-2] = 3))) then
        Begin
          case Animation of
            0: Pole_2[j_pers,i_pers].Picture.LoadFromFile(Player_Images_2[4]);
            6: Pole_2[j_pers,i_pers].Picture.LoadFromFile(Player_Images_2[5]);
            12: Pole_2[j_pers,i_pers].Picture.LoadFromFile(Player_Images_2[6]);
          end;
          Inc(Animation);
          if Animation > 12 then
          Animation := 0;
          if a = 0 then
            Begin
              if (Location_2[j_pers,i_pers-1] = 3) and (not(Location_2[j_pers,i_pers-2] = 1)) then
                Begin
                  Box := True;;
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
              a := 0;
              if steps = 9 then
                Auto_Time_2.Interval := 100;
              Inc(steps);
            End;
        End;
     End;
  10:
     Begin
       Destroy;
     End;
  end;
end;

procedure TAuto_2Form.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure TAuto_2Form.Construct;
var i, j: Integer;
begin
  Map_2 := TBitMap.Create;
  for i := 1 to n do
    for j := 1 to n do
      Begin
        Pole_2[j,i] := TImage.Create(Auto_2Form);
        Pole_2[j,i].Parent := Auto_2Form;
        Pole_2[j,i].Width := h;
        Pole_2[j,i].Height := h;
        Pole_2[j,i].Left := x0 + (i - 1) * h;
        Pole_2[j,i].Top := y0 + (j - 1) * h;
        Pole_2[j,i].Visible := False;
      End;

  for i := 1 to n do
    for j := 1 to n do
      Begin
        Bt_2[j,i] := TBitBtn.Create(Auto_2Form);
        Bt_2[j,i].Parent := Auto_2Form;
        Bt_2[j,i].Width := h;
        Bt_2[j,i].Height := h;
        Bt_2[j,i].Left := x0 + (j - 1) * h;
        Bt_2[j,i].Top := y0 + (i - 1) * h;
        Bt_2[j,i].Caption := '';
        Bt_2[j,i].Visible :=  False;
      End;

  Auto_2Form.Repaint;
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
        end;
      End;
  steps := 0;
end;

procedure TAuto_2Form.Destroy;
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
  Location_2[3,6] := 0;
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
  Location_2[5,3] := 0;
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

  FreeAndNil(Pole_2[3,3]);
  FreeAndNil(Pole_2[3,2]);
  FreeAndNil(Pole_2[2,3]);

  dx := 0;
  dy := 0;

  Auto_Time_2.Enabled := False;
  Auto_Time_2.Interval := 10;
  Level2Form.Game_Time_2.Enabled := True;
  Auto_2Form.Hide;
  steps := 0;
end;

end.
