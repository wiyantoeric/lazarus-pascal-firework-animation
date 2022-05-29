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
    ComboBox1: TComboBox;
    Edit4: TEdit;
    Edit5: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    PageControl2: TPageControl;
    SavePictureDialog1: TSavePictureDialog;
    ScrollBox1: TScrollBox;
    StaticText1: TStaticText;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
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
    procedure Edit3Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure TimerTakeOffTimer(Sender: TObject);
    procedure ClearCanvas();
    procedure TimerExplosionTimer(Sender: TObject);
    procedure TrackBar_RangeChange(Sender: TObject);
    procedure TrackBar_ParticleChange(Sender: TObject);  
    procedure FireworkExplosion();
    procedure FireworkExplosionAnimation();
    procedure FireworkTakeOff();
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
  BgColor : string = 'clNavy';
  Particle : integer = 50;
  FrColor : string = 'clYellow';
  Range : integer = 50 ;
  Speed : integer = 1;
  Ex_Delay : integer = 500;
  Anim_Delay : integer = 500;
  TakeOff : boolean = True;

  Sparks : array [0..199] of Spark;
  ExplodeHeight : Integer = 150;

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

procedure TForm1.buttonPlayClick(Sender: TObject);
begin
  TimerTakeOff.Enabled := true;
  TimerTakeOffTimer(Sender);
end;

procedure TForm1.CheckBox_TakeOffChange(Sender: TObject);
begin
  TakeOff := CheckBox_TakeOff.Checked;
end;

procedure TForm1.ColorBox_FrColorChange(Sender: TObject);
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
  Speed := ComboBox1.ItemIndex;
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
   TimerTakeOff.Enabled := False;
end;

procedure TForm1.Edit3Change(Sender: TObject);
begin

end;

procedure TForm1.TimerTakeOffTimer(Sender: TObject);
begin
  Button_BgApplyClick(nil);
  FireworkTakeOff()
end;

procedure TForm1.FireworkTakeOff();
begin
if TakeOff then
  begin
    y := y + Ty;
    //gambar grafik
    image1.Canvas.Brush.Color := ColorBox_FrColor.Selected;
    image1.Canvas.Pen.Color := ColorBox_FrColor.Selected;
    image1.Canvas.Pen.Style := psSolid;
    image1.Canvas.Ellipse(x,y - 25,x + 7,y + 25);

    if y <= ExplodeHeight then
    begin
      y  := image1.Height;
      TimerTakeOff.Enabled := False;
      ClearCanvas();
      FireworkExplosion();
    end;
  end
  else
  begin
    TimerTakeOff.Enabled := False;
    FireworkExplosion();
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
  i, j : Integer;

begin
//  Titik tengah canvas Image1.
  MidX := Image1.Canvas.Width div 2;
  MidY := Image1.Canvas.Height div 2;

//  Initial settings untuk tiap partikel.
  for i:=0 to 190 do
  begin
    Sparks[i].X := Midx;
    Sparks[i].Y := Midy - ExplodeHeight;

    Sparks[i].ColorR := Random(100) + 100;
    Sparks[i].ColorG := Random(100) + 100;
    Sparks[i].ColorB := Random(100) + 100;

    Sparks[i].Rotation := Random(360);
    Sparks[i].Speed := Random(10) + Round(Range / 10);

    Sparks[i].Friction := 0.9;
    Sparks[i].Yvel := 0;
    Sparks[i].Gravity := 0.1;
  end;

//  Enable TTimer TimerExplosion untuk memutar animasi.
  TimerExplosion.Enabled := True;
end;

procedure TForm1.TimerExplosionTimer(Sender: TObject);
begin                
  ClearCanvas();
  FireworkExplosionAnimation();

//  Pemberhentian animasi berdasarkan kecepatan partikel dengan index ke-0.
  if (Sparks[0].Speed < 0.35) then
  begin
    TimerExplosion.Enabled := False;
    ClearCanvas();
  end;
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

//    Warna random.
    //Image1.Canvas.Pen.Color := RGB(Sparks[i].ColorR, Sparks[i].ColorG, Sparks[i].ColorB);

//    Warna input.
    Image1.Canvas.Pen.Color := ColorBox_FrColor.Selected;

  //    Main explosion.
    Image1.Canvas.Pen.Width := 3;
    Image1.Canvas.Pen.Style := Pssolid;

    Image1.Canvas.Moveto(Sparks[i].X - Stepx, Sparks[i].Y - Stepy);
    Image1.Canvas.Lineto(Sparks[i].X , Sparks[i].Y);

    Image1.Canvas.Pen.Width := 1;

  //    Explosion tambahan.
    Image1.Canvas.Moveto(Sparks[i].X - Round(Sparks[i].Speed * Stepx) , Sparks[i].Y - Round(Sparks[i].Speed * Stepy));
    Image1.Canvas.Lineto(Sparks[i].X - Stepx , Sparks[i].Y - Stepy);

  //    Explode tambahan 2.
    //Image1.Canvas.Pen.Style := Psdash;
    //Image1.Canvas.Moveto(Sparks[i].X - (2*Stepx), Sparks[i].Y - (2*Stepy));
    //Image1.Canvas.Lineto(Sparks[i].X + Round(Stepx * Sparks[i].Speed) - Stepx, Sparks[i].Y + Round(Stepy * Sparks[i].Speed) - Stepy );

  //    Lingkaran explosion.
    //Image1.Canvas.Ellipse(Sparks[i].X - Round(Sparks[i].Speed) , Sparks[i].Y - Round(Sparks[i].Speed), Sparks[i].X + Round(Sparks[i].Speed), Sparks[i].Y + Round(Sparks[i].Speed));
  end;
end;

procedure TForm1.TrackBar_RangeChange(Sender: TObject);
begin

end;

procedure TForm1.TrackBar_ParticleChange(Sender: TObject);
begin

end;

end.

