unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Menus,
  ExtDlgs, StdCtrls, Buttons, ComCtrls, ColorBox, ActnList,
  FileUtil;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button_Play: TButton;
    buttonPlay: TButton;
    Button_Pause: TButton;
    Button_BgApply: TButton;
    Button_FireApply: TButton;
    Button_AnimApply: TButton;
    Button_Screenshot: TButton;
    CheckBox_TakeOff: TCheckBox;
    ColorBox_BgColor: TColorBox;
    ColorBox_FrColor: TColorBox;
    ComboBox_Speed: TComboBox;
    Edit_Particle: TEdit;
    Edit_Range: TEdit;
    Edit_Ex: TEdit;
    Edit_Anim: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label_Ex: TLabel;
    Label_Anim: TLabel;
    Label13: TLabel;
    Label_Particle: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label_Range: TLabel;
    PageControl2: TPageControl;
    SavePictureDialog1: TSavePictureDialog;
    StaticText1: TStaticText;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TimerAnimDelay: TTimer;
    TimerDelay: TTimer;
    TimerTakeOff: TTimer;
    TimerExplosion: TTimer;
    TrackBar_Particle: TTrackBar;
    TrackBar_Range: TTrackBar;
    TrackBar_Ex_Delay: TTrackBar;
    TrackBar_Anim_Delay: TTrackBar;
    procedure Button_PauseClick(Sender: TObject);
    procedure Button_ScreenshotClick(Sender: TObject);
    procedure Button_AnimApplyClick(Sender: TObject);
    procedure Button_FireApplyClick(Sender: TObject);
    procedure Button_BgApplyClick(Sender: TObject);
    procedure buttonPlayClick(Sender: TObject);
    procedure CheckBox_TakeOffChange(Sender: TObject);
    procedure ColorBox_FrColorChange(Sender: TObject);
    procedure ComboBox_SpeedChange(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit_AnimChange(Sender: TObject);
    procedure Edit_ExChange(Sender: TObject);
    procedure Edit_ParticleChange(Sender: TObject);
    procedure Edit_RangeChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure TimerAnimDelayTimer(Sender: TObject);
    procedure TimerDelayTimer(Sender: TObject);
    procedure TimerTakeOffTimer(Sender: TObject);
    procedure ClearCanvas();
    procedure TimerExplosionTimer(Sender: TObject);
    procedure TrackBar_Anim_DelayChange(Sender: TObject);
    procedure TrackBar_Ex_DelayChange(Sender: TObject);
    procedure TrackBar_RangeChange(Sender: TObject);
    procedure TrackBar_ParticleChange(Sender: TObject);  
    procedure FireworkExplosion();
    procedure FireworkExplosionAnimation();
    procedure FireworkTakeOff();
     procedure ShowAlertDialog(Message: String);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

uses
  Windows;

type
  Spark = Record
    X, Y : Integer;
    ColorR : Integer;
    ColorG : Integer;
    ColorB : Integer;
    Rotation : Single;
    Speed : Single;
    Friction : Single;
    Yvel : Single;
    Gravity : Single;
  end;

var
  x, y : integer;
  Ty   : integer;
  Particle : integer = 50;
  FrColor : string = 'clYellow';
  Range : integer = 50 ;
  Speed : integer = 1;
  Ex_Delay : integer = 1;
  Anim_Delay : integer = 1;
  TakeOff : boolean = True;

  Sparks : array [0..199] of Spark;
  ExplodeHeight : Integer = 100;
  isPlaying : boolean = False;
  ExDelayCounter : integer = 1;
  AnimDelayCounter : Integer = 1;

procedure TForm1.FormCreate(Sender: TObject);
var
  i, j : integer;

begin
  image1.Canvas.brush.color := clWhite;
  Image1.Canvas.FillRect(0, 0, Image1.Canvas.Width, Image1.Canvas.Height); 
  Image1.Canvas.FillRect(0, 0, Image1.Canvas.Width, Image1.Canvas.Height);
  x  := image1.Width div 2;
  y  := image1.Height;
  Ty := -50;
  image1.Canvas.Pen.Color:=clWhite;
  image1.Canvas.Brush.Color:=clWhite;
  image1.Canvas.Rectangle(0,0,image1.Width,image1.Height);
  TimerTakeOff.Enabled := false;

end;

procedure TForm1.Label6Click(Sender: TObject);
begin

end;

procedure TForm1.TimerAnimDelayTimer(Sender: TObject);

begin
  if AnimDelayCounter = 2 then
  begin
    TimerTakeOff.Enabled := isPlaying;
    TimerAnimDelay.Enabled := False;
    AnimDelayCounter := 1;
  end;

  AnimDelayCounter += 1;
end;

procedure TForm1.TimerDelayTimer(Sender: TObject);

begin
  if ExDelayCounter = 2 then
  begin
    FireworkExplosion();
    TimerDelay.Enabled := False;
    ExDelayCounter := 1;
  end;

  ExDelayCounter += 1;
end;

procedure TForm1.buttonPlayClick(Sender: TObject);
begin
  TimerTakeOff.Enabled := true;
  isPlaying := True;
  Button_Pause.Enabled := True;
  Button_Play.Enabled := False;
  TimerTakeOffTimer(Sender);
end;

procedure TForm1.CheckBox_TakeOffChange(Sender: TObject);
begin
  TakeOff := CheckBox_TakeOff.Checked;
end;

procedure TForm1.ColorBox_FrColorChange(Sender: TObject);
begin

end;

procedure TForm1.ComboBox_SpeedChange(Sender: TObject);
begin

end;

procedure TForm1.Button_BgApplyClick(Sender: TObject);
begin
  Image1.Canvas.Brush.Color := ColorBox_BgColor.Selected;
  Image1.Canvas.FillRect(0, 0, Image1.Canvas.Width, Image1.Canvas.Height);
  Image1.Canvas.FillRect(0, 0, Image1.Canvas.Width, Image1.Canvas.Height);
end;

procedure TForm1.Button_FireApplyClick(Sender: TObject);
begin
  Particle := TrackBar_Particle.Position;
  FrColor := ColorBox_FrColor.Text;
  Range := TrackBar_Range.Position;
end;

procedure TForm1.Button_AnimApplyClick(Sender: TObject);
begin
  Speed := ComboBox_Speed.ItemIndex;
  Ex_Delay := TrackBar_Ex_Delay.Position;
  Anim_Delay := TrackBar_Anim_Delay.Position;

end;

procedure TForm1.Button_ScreenshotClick(Sender: TObject);
begin
  Button_Pause.Enabled := False;
  Button_Play.Enabled := True;
  Button_PauseClick(nil);
  if SavePictureDialog1.Execute then
  begin
    image1.Picture.SaveToFile(SavePictureDialog1.FileName);
  end;
end;

procedure TForm1.Button_PauseClick(Sender: TObject);
begin
  isPlaying := False;
  Button_Pause.Enabled := False;
  Button_Play.Enabled := True;
  TimerTakeOff.Enabled := False;
  TimerExplosion.Enabled := False;
end;

procedure TForm1.Edit3Change(Sender: TObject);
begin

end;

procedure TForm1.ShowAlertDialog(Message: String);
begin
  Application.MessageBox(PChar(Message), 'Alert', MB_ICONINFORMATION)
end;

procedure TForm1.Edit_AnimChange(Sender: TObject);
begin
  try
    if StrToInt(Edit_Anim.Text) > 5000 then
        Edit_Anim.Text := '5000';

    if StrToInt(Edit_Anim.Text) < 1 then
        Edit_Anim.Text := '1';

    TrackBar_Anim_Delay.Position := StrToInt(Edit_Anim.Text);
  except
    on e:Exception do ShowAlertDialog('Harap Masukan Angka 1 - 5000');
  end;

end;

procedure TForm1.Edit_ExChange(Sender: TObject);
begin
  try
    if StrToInt(Edit_Ex.Text) > 5000 then
        Edit_Ex.Text := '5000';

    if StrToInt(Edit_Ex.Text) < 1 then
        Edit_Ex.Text := '1';

    TrackBar_Ex_Delay.Position := StrToInt(Edit_Ex.Text);
  except
    on e:Exception do ShowAlertDialog('Harap Masukan Angka 1 - 5000');
  end;
end;

procedure TForm1.Edit_ParticleChange(Sender: TObject);
begin
  try
    if StrToInt(Edit_Particle.Text) > 100 then
        Edit_Particle.Text := '100';

    if StrToInt(Edit_Particle.Text) < 0 then
        Edit_Particle.Text := '0';

    TrackBar_Particle.Position := StrToInt(Edit_Particle.Text);
  except
    on E : Exception do ShowAlertDialog('Harap Masukan Angka 0 - 100');
  end;
end;

procedure TForm1.Edit_RangeChange(Sender: TObject);
begin
  try
    if StrToInt(Edit_Range.Text) > 100 then
        Edit_Range.Text := '100';

    if StrToInt(Edit_Range.Text) < 0 then
        Edit_Range.Text := '0';

    TrackBar_Range.Position := StrToInt(Edit_Range.Text);
  except
    on E : Exception do ShowAlertDialog('Harap Masukan Angka 0 - 100');
  end;
end;

procedure TForm1.TimerTakeOffTimer(Sender: TObject);
begin
  ClearCanvas();
  FireworkTakeOff()
end;

procedure TForm1.FireworkTakeOff();
begin
if TakeOff then
  begin
    if Speed = 0 then
       TimerTakeOff.Interval := 750;
    if Speed = 1 then
       TimerTakeOff.Interval := 200;
    if Speed = 2 then
       TimerTakeOff.Interval := 150;
    if Speed = 3 then
       TimerTakeOff.Interval := 100;
    y := y + Ty;
    //gambar grafik
    image1.Canvas.Brush.Color := ColorBox_FrColor.Selected;
    image1.Canvas.Pen.Color := ColorBox_FrColor.Selected;
    image1.Canvas.Pen.Style := psSolid;
    image1.Canvas.Ellipse(x,y - 25,x + 7,y + 25);

    if y < ExplodeHeight then
    begin
      y  := image1.Height;
      TimerTakeOff.Enabled := False;
      ClearCanvas();
      TimerDelay.Interval := Ex_Delay;
      TimerDelay.Enabled := True;
    end;
  end
else
  begin                     
    TimerTakeOff.Enabled := False;
    ClearCanvas();
    TimerDelay.Interval := Ex_Delay;
    TimerDelay.Enabled := True;
  end;
end;

procedure TForm1.ClearCanvas();
begin
  Image1.Canvas.Brush.Color := ColorBox_BgColor.Selected;
  Image1.Canvas.FillRect(0, 0, Image1.Canvas.Width, Image1.Canvas.Height);
  Image1.Canvas.FillRect(0, 0, Image1.Canvas.Width, Image1.Canvas.Height);
end;

procedure TForm1.FireworkExplosion();
var
  MidX, Midy : Integer;
  i : Integer;
  SelectedColor : Integer;

begin
//  Mengambil warna dari ColorBox.
  SelectedColor := ColorBox_FrColor.Selected;

//  Titik tengah canvas Image1.
  MidX := Image1.Canvas.Width div 2;
  MidY := Image1.Canvas.Height div 2;

//  Initial settings untuk tiap partikel.
  for i:=0 to 199 do
  begin
    Sparks[i].X := Midx;
    Sparks[i].Y := Midy - ExplodeHeight;

//    Mengacak warna input untuk kembang api.
    Sparks[i].ColorR := Random(10) - Random(11) + Red(SelectedColor);
    Sparks[i].ColorG := Random(9) - Random(10) + Green(SelectedColor);
    Sparks[i].ColorB := Random(11) - Random(9) + Blue(SelectedColor);

//    Color thresholding.
    if Sparks[i].ColorR > 255 then Sparks[i].ColorR := Red(SelectedColor);
    if Sparks[i].ColorG > 255 then Sparks[i].ColorG := Green(SelectedColor);
    if Sparks[i].ColorB > 255 then Sparks[i].ColorB := Blue(SelectedColor);

//    Mengacak arah dan kecepatan tiap partikel kembang api.
    Sparks[i].Rotation := Random(360);
    Sparks[i].Speed := Random(10) + Round(Range / 10);

//    Default settings untuk tiap partikel.
    Sparks[i].Friction := 0.9;
    Sparks[i].Yvel := 0;
    Sparks[i].Gravity := 0.1;
  end;

//  Mengaktifkan TTimer TimerExplosion untuk memutar animasi.
  TimerExplosion.Enabled := True;
end;

procedure TForm1.TimerExplosionTimer(Sender: TObject);
begin                
  ClearCanvas();
  if Speed = 0 then
     TimerExplosion.Interval := 200;
  if Speed = 1 then
     TimerExplosion.Interval := 100;
  if Speed = 2 then
     TimerExplosion.Interval := 50;
  if Speed = 3 then
     TimerExplosion.Interval :=  1;

  FireworkExplosionAnimation();

//  Pemberhentian animasi berdasarkan kecepatan partikel dengan index ke-0.
  if (Sparks[0].Speed < 0.35) then
  begin
    TimerExplosion.Enabled := False;

    ClearCanvas();
    TimerAnimDelay.Interval := Anim_Delay;
    TimerAnimDelay.Enabled := True;

    ClearCanvas();
  end;
end;

procedure TForm1.TrackBar_Anim_DelayChange(Sender: TObject);
begin
  Edit_Anim.Text := IntToStr(TrackBar_Anim_Delay.Position);
end;

procedure TForm1.TrackBar_Ex_DelayChange(Sender: TObject);
begin
  Edit_Ex.Text := IntToStr(TrackBar_Ex_Delay.Position);
end;

procedure TForm1.FireworkExplosionAnimation();
var
  StepX, StepY : Integer;   
  SparkCount : Integer;
  i : Integer;

begin
//  Jumlah partikel yang dianimasikan.
  SparkCount := 50 + Round(Particle * 1.5);

//  Penggambaran partikel ke canvas Image1.
  for i := 0 to SparkCount do
  begin
    StepX := Round(Sparks[i].Speed * Cos(Sparks[i].Rotation * Pi / 180));
    StepY := Round(Sparks[i].Speed * Sin(Sparks[i].Rotation * Pi / 180));
    Sparks[i].X += StepX;
    Sparks[i].Y += StepY;

    Sparks[i].Speed *= Sparks[i].Friction;

    Sparks[i].Yvel += Sparks[i].Gravity;
    Sparks[i].Y += Round(Sparks[i].Yvel);

//    Set warna pen.
    Image1.Canvas.Pen.Color := RGB(Sparks[i].ColorR, Sparks[i].ColorG, Sparks[i].ColorB);

//    Main explosion.
    Image1.Canvas.Pen.Width := 3;
    Image1.Canvas.Pen.Style := Pssolid;

    Image1.Canvas.Moveto(Sparks[i].X - Stepx, Sparks[i].Y - Stepy);
    Image1.Canvas.Lineto(Sparks[i].X , Sparks[i].Y);

    Image1.Canvas.Pen.Width := 1;

//    Explosion tambahan.
    Image1.Canvas.Moveto(Sparks[i].X - Round(Sparks[i].Speed * Stepx) , Sparks[i].Y - Round(Sparks[i].Speed * Stepy));
    Image1.Canvas.Lineto(Sparks[i].X - Stepx , Sparks[i].Y - Stepy);

//    Lingkaran explosion.
    Image1.canvas.brush.color := RGB(Sparks[i].ColorR, Sparks[i].ColorG, Sparks[i].ColorB);
    Image1.Canvas.Ellipse(Sparks[i].X - Round(Sparks[i].Speed) , Sparks[i].Y - Round(Sparks[i].Speed), Sparks[i].X + Round(Sparks[i].Speed), Sparks[i].Y + Round(Sparks[i].Speed));
  end;
end;

procedure TForm1.TrackBar_RangeChange(Sender: TObject);
begin
  Edit_Range.Text := IntToStr(TrackBar_Range.Position);
end;

procedure TForm1.TrackBar_ParticleChange(Sender: TObject);
begin  
  Edit_Particle.Text := IntToStr(TrackBar_Particle.Position);
end;

end.

